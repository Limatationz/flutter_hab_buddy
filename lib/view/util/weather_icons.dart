import 'package:weather_pack/weather_pack.dart';

String convertWeatherCodeToIconName(String code){
  switch(code){
    case "01d":
      return "wi-day-sunny";
    case "01n":
      return "wi-night-clear";
    case "02d":
      return "wi-day-cloudy";
    case "02n":
      return "wi-night-alt-cloudy";
    case "03d":
      return "wi-cloud";
    case "03n":
      return "wi-cloud";
    case "04d":
      return "wi-cloudy";
    case "04n":
      return "wi-cloudy";
    case "09d":
      return "wi-day-showers";
    case "09n":
      return "wi-night-alt-showers";
    case "10d":
      return "wi-day-rain";
    case "10n":
      return "wi-night-alt-rain";
    case "11d":
      return "wi-day-thunderstorm";
    case "11n":
      return "wi-night-alt-thunderstorm";
    case "13d":
      return "wi-day-snow";
    case "13n":
      return "wi-night-alt-snow";
    case "50d":
      return "wi-day-fog";
    case "50n":
      return "wi-night-fog";
    default:
      return "wi-na";
  }
}

String? worksTempUnits({
  required double? temp,
  int precision = 1,
  Temp unitsMeasure = Temp.celsius,
}) {
  if (temp == null) {
    return null;
  }
  return unitsMeasure.valueToString(temp, precision);
}