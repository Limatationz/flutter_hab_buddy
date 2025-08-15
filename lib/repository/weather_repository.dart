import 'dart:async';
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';
import 'package:weather_pack/weather_pack.dart';

import '../core/database/items/item_type.dart';
import '../core/hive/state/item_state.dart';
import '../locator.dart';
import '../util/secrets.dart';
import '../view/main/items/weather/weather_data.dart';
import 'item_repository.dart';

class WeatherRepository {
  final _logger = Logger();
  final ItemRepository itemRepository = locator<ItemRepository>();

  WeatherService? _weatherService;
  GeocodingService? _geocodingService;

  bool _isForecastAvailable = true;
  bool get isForecastAvailable => _isForecastAvailable;

  bool _isCurrentAvailable = true;
  bool get isCurrentAvailable => _isCurrentAvailable;

  final BehaviorSubject<List<WeatherData>> _requestSubject = BehaviorSubject();

  WeatherRepository() {
    // create factory
    _createService();

    asyncInit();
  }

  Future<void> asyncInit() async {
    // get all weather items from database
    final items = await itemRepository
        .getItemsByTypes([ItemType.weather, ItemType.weatherForecast]);
    final requests = items
        .map((e) {
          if (e.complexJson == null) {
            return null;
          }
          final data = WeatherData.fromJson(e.complexJson!);
          return data;
        })
        .whereType<WeatherData>()
        .toList();

    // add requests
    _requestSubject.add(requests);

    // fetch weather initial
    Stream.periodic(const Duration(minutes: 15), (_) {
      return DateTime.now();
    }).withLatestFrom(_requestSubject.stream, (t, requests) {
      for (final request in requests) {
        _fetchAndStoreWeather(request);
      }
    });
  }

  Future<bool> startWeatherObserver(WeatherData args) async {
    if (args.location.lat == null && args.location.lon == null) {
      // calculate lat and lon
      final List<PlaceGeocode> places =
          await _geocodingService!.getLocationByCityName(args.location.city!);
      if (places.isNotEmpty) {
        if (places.first.latitude != null && places.first.longitude != null) {
          args = WeatherData(
              itemName: args.itemName,
              location: WeatherLocationData(
                city: args.location.city,
                lat: places.first.latitude,
                lon: places.first.longitude,
              ),
              type: args.type);
        }
      }
    }

    // check if location is already in requests
    final requests = _requestSubject.valueOrNull ?? [];
    if (requests.contains(args)) {
      return false;
    }

    // add to requests
    requests.add(args);
    _requestSubject.add(requests);

    // fetch weather initial
    _fetchAndStoreWeather(args);

    return true;
  }

  void stopWeatherObserver(WeatherData args) {
    final requests = _requestSubject.valueOrNull ?? [];
    requests.removeWhere((element) => element.itemName == args.itemName);
    _requestSubject.add(requests);
  }

  void _createService() {
    if (_weatherService == null) {
      final lang = _getWeatherLanguage();
      _weatherService = WeatherService(weatherApiKey, language: lang, oneCallApi: OneCallApi.api_3_0);
      _geocodingService = GeocodingService(weatherApiKey);
    }
  }

  Future<void> _fetchAndStoreWeather(WeatherData request) async {
    final data = await fetchWeather(request);
    final current = data.item1;
    final oneCall = data.item2;

    // store in item states
    if (current != null || oneCall != null) {
      final weatherJson = current?.toJson();
      final forecastJson = oneCall?.toJson();
      final state = {
        "type": (weatherJson != null
                ? WeatherRequestType.current
                : WeatherRequestType.forecast)
            .name,
        "data": weatherJson ?? forecastJson,
        "city": request.location.city,
      };
      itemRepository.insertOrUpdateState(request.itemName,
        ItemState(state: jsonEncode(state), ohName: request.itemName),
      );
    }
  }

  Future<Tuple2<WeatherCurrent?, WeatherOneCall?>> fetchWeather(
      WeatherData request) async {
    WeatherCurrent? current;
    WeatherOneCall? oneCall;

    // request from api
    if (request.location.lat != null && request.location.lon != null) {
      if (request.type == WeatherRequestType.current) {
        try {
          current =
          await _getCurrent(request.location.lat!, request.location.lon!);
        } catch (e, s) {
          _isCurrentAvailable = false;
          _logger.e("Error on fetching current weather", error: e, stackTrace: s);
        }
      } else {
        try {
          oneCall =
          await _getOneCall(request.location.lat!, request.location.lon!);
        } catch (e, s) {
          _isForecastAvailable = false;
          _logger.e("Error on fetching one call weather", error: e, stackTrace: s);
        }
      }
    } else if (request.location.city != null) {
      double lat = 0;
      double lon = 0;
      final List<PlaceGeocode> places = await _geocodingService!
          .getLocationByCityName(request.location.city!);
      if (places.isEmpty) {
        // no location
        return const Tuple2(null, null);
      } else {
        if (places.first.latitude == null || places.first.longitude == null) {
          // no location
          return const Tuple2(null, null);
        } else {
          lat = places.first.latitude!;
          lon = places.first.longitude!;
        }
      }
      if (request.type == WeatherRequestType.current) {
        current = await _getCurrent(lat, lon);
      } else {
        oneCall = await _getOneCall(lat, lon);
      }
    }
    return Tuple2(current, oneCall);
  }

  Future<WeatherOneCall> _getOneCall(double lat, double lon) async {
    return await _weatherService!
        .oneCallWeatherByLocation(latitude: lat, longitude: lon);
  }

  Future<WeatherCurrent> _getCurrent(double lat, double lon) async {
    return await _weatherService!
        .currentWeatherByLocation(latitude: lat, longitude: lon);
  }

  Future<String?> getCityByLocation({
    required double latitude,
    required double longitude,
  }) async {
    final places = await _geocodingService!.getLocationByCoordinates(
      latitude: latitude,
      longitude: longitude,
    );
    if (places.isEmpty) {
      return null;
    } else {
      return places.first.name;
    }
  }

  WeatherLanguage _getWeatherLanguage() {
    final systemLang = Intl.getCurrentLocale();
    switch (systemLang) {
      case "en_US":
        return WeatherLanguage.english;
      case "de_DE":
        return WeatherLanguage.german;
      case "fr_FR":
        return WeatherLanguage.french;
      case "it_IT":
        return WeatherLanguage.italian;
      case "es_ES":
        return WeatherLanguage.spanish;
      case "ca_ES":
        return WeatherLanguage.catalan;
      case "pt_PT":
        return WeatherLanguage.portuguese;
      case "ru_RU":
        return WeatherLanguage.russian;
      case "uk_UA":
        return WeatherLanguage.ukrainian;
      case "fi_FI":
        return WeatherLanguage.finnish;
      case "nl_NL":
        return WeatherLanguage.dutch;
      case "pl_PL":
        return WeatherLanguage.polish;
      case "bg_BG":
        return WeatherLanguage.bulgarian;
      case "sv_SE":
        return WeatherLanguage.swedish;
      case "zh_CN":
        return WeatherLanguage.chineseSimplified;
      case "zh_TW":
        return WeatherLanguage.chineseTraditional;
      case "tr_TR":
        return WeatherLanguage.turkish;
      case "hr_HR":
        return WeatherLanguage.croatian;
      case "hu_HU":
        return WeatherLanguage.hungarian;
      case "ro_RO":
        return WeatherLanguage.romanian;
      case "id_ID":
        return WeatherLanguage.indonesian;
      case "ko_KR":
        return WeatherLanguage.korean;
      case "ar":
        return WeatherLanguage.arabic;
      case "sk_SK":
        return WeatherLanguage.slovak;
      case "cs_CZ":
        return WeatherLanguage.czech;
      case "gl_ES":
        return WeatherLanguage.galician;
      case "eu_ES":
        return WeatherLanguage.basque;
      case "vi_VN":
        return WeatherLanguage.vietnamese;
      case "nb_NO":
        return WeatherLanguage.norwegian;
      case "th_TH":
        return WeatherLanguage.thai;
      case "el_GR":
        return WeatherLanguage.greek;
      default:
        return WeatherLanguage.english;
    }
  }
}
