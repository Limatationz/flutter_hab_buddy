import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:screen_brightness/screen_brightness.dart';

import '../../locator.dart';

class FaceRecognitionService {
  final String enabledKey = 'faceRecognitionEnabled';

  final _logger = Logger();
  final _prefs = locator<RxSharedPreferences>();

  bool _isEnabled = false;

  bool get isEnabled => _isEnabled;

  FaceRecognitionServiceError? _error;

  FaceRecognitionServiceError? get error => _error;

  // camera
  late List<CameraDescription> _cameras;
  CameraDescription? _camera;
  CameraController? _cameraController;
  final _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  // face detection
  FaceDetector? _faceDetector;
  bool _isFaceDetected = false;

  bool get isFaceDetected => _isFaceDetected;
  Timer? _faceDetectionTimeoutTimer;

  // system brightness
  static const brightnessActive = 0.8; // TODO: anpassbar in settings?
  static const brightnessInactive = 0.03;
  double? _brightnessOnEnabled;

  FaceRecognitionService() {
    asyncInit();
  }

  Future<void> asyncInit() async {
    if (await isSupported()) {
      if (await canRequestCameraPermission()) {
        _error = FaceRecognitionServiceError.cameraPermissionNotRequested;
      } else {
        if (await hasCameraPermission()) {
          final isEnabled = await _prefs.getBool(enabledKey) ?? false;
          _isEnabled = isEnabled;
        } else {
          _error = FaceRecognitionServiceError.cameraPermissionDenied;
        }
      }
    } else {
      // not supported (only ios and android)
      _isEnabled = false;
      _error = FaceRecognitionServiceError.faceRecognitionNotSupported;
    }
  }

  static Future<bool> isSupported() async {
    // check platform
    final platform = !kIsWeb && (Platform.isAndroid || Platform.isIOS);
    if (!platform) {
      Logger().e('Face recognition is not supported on this platform');
      return false;
    }

    // front camera is required
    final cameras = await availableCameras();
    final hasFrontCamera = cameras
        .any((element) => element.lensDirection == CameraLensDirection.front);
    if (!hasFrontCamera) {
      Logger().e('Front camera is required');
      return false;
    }

    return true;
  }

  Future<bool> hasCameraPermission() async {
    final permissionStatus = Permission.camera.status;
    return permissionStatus.isGranted;
  }

  Future<bool> requestCameraPermission() async {
    // open app settings
    if (error == FaceRecognitionServiceError.cameraPermissionDenied) {
      await openAppSettings();
      final permission = await hasCameraPermission();
      if (!permission) {
        _error = FaceRecognitionServiceError.cameraPermissionDenied;
      } else {
        _error = null;
      }
    }

    // request permission via popup
    final permissionStatus = await Permission.camera.request();

    if (error == FaceRecognitionServiceError.cameraPermissionNotRequested) {
      if (!permissionStatus.isGranted) {
        _error = FaceRecognitionServiceError.cameraPermissionDenied;
      } else {
        _error = null;
      }
    }

    return permissionStatus.isGranted;
  }

  Future<bool> canRequestCameraPermission() async {
    final permissionStatus = await Permission.camera.request();
    return permissionStatus.isDenied;
  }

  Future<void> setEnabled(bool value) async {
    _isEnabled = value;
    await _prefs.setBool(enabledKey, value);
  }

  Future<void> toggleEnabled() async {
    _isEnabled = !_isEnabled;
    await _prefs.setBool(enabledKey, _isEnabled);
  }

  static Future<bool> openSettings() {
    return openAppSettings();
  }

  Future<void> enable() async {
    if (!isEnabled) {
      return;
    }

    // init camera

    _cameras = await availableCameras();

    if (!_cameras
        .any((element) => element.lensDirection == CameraLensDirection.front)) {
      _error = FaceRecognitionServiceError.noFrontCamera;
      _logger.e('No front camera found');
      return;
    }

    _camera = _cameras.firstWhere(
        (element) => element.lensDirection == CameraLensDirection.front);

    final controller = CameraController(
      _camera!, ResolutionPreset.low, enableAudio: false,
      fps: 1,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21 // for Android
          : ImageFormatGroup.bgra8888, // for iOS
    );
    await controller.initialize().catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            _error = FaceRecognitionServiceError.cameraPermissionDenied;
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });

    if (error == FaceRecognitionServiceError.cameraPermissionDenied) {
      _logger.e('Camera permission is denied');
      _error = FaceRecognitionServiceError.cameraPermissionDenied;
      return;
    }

    if (!controller.supportsImageStreaming()) {
      _logger.e('Camera does not support image streaming');
      _error = FaceRecognitionServiceError.imageStreamNotSupported;
      return;
    }

    // init face detection
    final options = FaceDetectorOptions(enableLandmarks: true);
    _faceDetector = FaceDetector(options: options);

    // store current brightness
    _brightnessOnEnabled = await applicationBrightness;

    controller.startImageStream(_onImageAvailable);

    _cameraController = controller;
  }

  InputImage? _inputImageFromCameraImage(CameraImage image) {
    if (_camera == null || _cameraController == null) return null;

    // get image rotation
    // it is used in android to convert the InputImage from Dart to Java
    // `rotation` is not used in iOS to convert the InputImage from Dart to Obj-C
    // in both platforms `rotation` and `camera.lensDirection` can be used to compensate `x` and `y` coordinates on a canvas
    final camera = _camera!;
    final sensorOrientation = camera.sensorOrientation;
    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation =
          _orientations[_cameraController!.value.deviceOrientation];
      if (rotationCompensation == null) return null;
      if (camera.lensDirection == CameraLensDirection.front) {
        // front-facing
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        // back-facing
        rotationCompensation =
            (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
    }
    if (rotation == null) return null;

    // get image format
    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    // validate format depending on platform
    // only supported formats:
    // * nv21 for Android
    // * bgra8888 for iOS
    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) {
      return null;
    }

    // since format is constraint to nv21 or bgra8888, both only have one plane
    if (image.planes.length != 1) return null;
    final plane = image.planes.first;

    // compose InputImage using bytes
    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation, // used only in Android
        format: format, // used only in iOS
        bytesPerRow: plane.bytesPerRow, // used only in iOS
      ),
    );
  }

  Future<double> get applicationBrightness async {
    try {
      return await ScreenBrightness.instance.application;
    } catch (e, s) {
      _logger.e('Failed to get application brightness',
          error: e, stackTrace: s);
      throw 'Failed to get application brightness';
    }
  }

  Future<void> setApplicationBrightness(double brightness) async {
    try {
      await ScreenBrightness.instance
          .setApplicationScreenBrightness(brightness);
    } catch (e, s) {
      _logger.e('Failed to set application brightness',
          error: e, stackTrace: s);
      throw 'Failed to set application brightness';
    }
  }

  Future<void> resetApplicationBrightness() async {
    try {
      await ScreenBrightness.instance.resetApplicationScreenBrightness();
    } catch (e, s) {
      _logger.e('Failed to reset application brightness',
          error: e, stackTrace: s);
      throw 'Failed to reset application brightness';
    }
  }

  DateTime lastProcessed = DateTime.now();

  Future<void> _onImageAvailable(CameraImage image) async {
    final now = DateTime.now();
    if (now.difference(lastProcessed).inMilliseconds < 1000) return; // ~1 fps
    lastProcessed = now;

    if (_faceDetector == null) return;

    final inputImage = _inputImageFromCameraImage(image);
    if (inputImage == null) return;

    // detect faces
    final List<Face> faces = await _faceDetector!.processImage(inputImage);

    // check if any face is looking in camera
    final facesLookingInCamera = faces.where((e) =>
        e.landmarks[FaceLandmarkType.rightEye] != null ||
        e.landmarks[FaceLandmarkType.leftEye] != null);

    if (facesLookingInCamera.isEmpty) {
      if (_isFaceDetected) {
        _isFaceDetected = false;
        _logger.e('No faces looking in camera detected');
      }
    } else {
      if (!_isFaceDetected) {
        _isFaceDetected = true;
        _logger.d(
            'Faces looking in camera detected: ${facesLookingInCamera.length}');

        // set system brightness
        await setApplicationBrightness(brightnessActive);

        // reset timeout timer
        if (_faceDetectionTimeoutTimer != null) {
          _faceDetectionTimeoutTimer!.cancel();
          _faceDetectionTimeoutTimer = null;
        }

        // start timer to disable face detection after 10 seconds
        _startFaceDetectionTimeoutTimer();
      }
    }
  }

  void _startFaceDetectionTimeoutTimer({int? timeoutSeconds}) {
    final timeout = Duration(seconds: timeoutSeconds ?? 10);

    _faceDetectionTimeoutTimer?.cancel();

    _faceDetectionTimeoutTimer = Timer(timeout, () {
      if (!_isFaceDetected) {
        // we set the brightness to inactive after 10 seconds
        setApplicationBrightness(brightnessInactive);

        _logger.d('Faces looking in camera not detected for 10 seconds');

        _faceDetectionTimeoutTimer = null;
      } else {
        _logger.d('Faces looking in camera detected again');

        _startFaceDetectionTimeoutTimer();
      }
    });
  }

  Future<void> disable() async {
    // disable camera
    if (_cameraController != null) {
      try {
        _cameraController!.stopImageStream();
      } catch (e) {
        _logger.e('Error on stopImageStream', error: e);
      }
      await _cameraController!.dispose();
      _cameraController = null;
    }

    // disable face detection
    if (_faceDetector != null) {
      await _faceDetector!.close();
      _faceDetector = null;
    }

    // restore brightness
    if (_brightnessOnEnabled != null) {
      await setApplicationBrightness(_brightnessOnEnabled!);
    }
  }
}

enum FaceRecognitionServiceError {
  cameraPermissionNotRequested,
  cameraPermissionDenied,
  faceRecognitionNotSupported,
  noFrontCamera,
  imageStreamNotSupported;
}
