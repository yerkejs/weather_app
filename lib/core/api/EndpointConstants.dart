abstract class EndpointConstants {
  static final String host = "api.openweathermap.org";
  static final String defaultPath = "data/2.5";
  static final String appID = "09bff20391771a747a2c001fa08763e4";

  static String pathBuilder (WeatherAPIServices serviceType) => 
    "$defaultPath/${serviceType.pathKey}";

  static Uri getConditionIcon (String iconKey) => 
    Uri.parse("http://openweathermap.org/img/wn/${iconKey}@2x.png");
}

enum WeatherAPIServices { weather, forecast }

extension WeatherAPIServicesExtension on WeatherAPIServices {
  String get pathKey {
    switch (this) {
      case WeatherAPIServices.weather:
        return "weather";
      case WeatherAPIServices.forecast:
        return "onecall";
      default:
        return "";
    }
  }
}
