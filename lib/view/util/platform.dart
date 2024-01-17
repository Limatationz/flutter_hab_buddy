import 'dart:io';

bool isIos() => Platform.isIOS;

bool isAndroid() => Platform.isAndroid;

bool isMacOS() => Platform.isMacOS;

bool isWindows() => Platform.isWindows;

bool isDesktop() => isMacOS() || isWindows();