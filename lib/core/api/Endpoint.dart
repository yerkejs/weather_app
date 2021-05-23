import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'EndpointConstants.dart';

abstract class RequestEndpoint {
  Map<String, String> queryParams;
  String path;
}

class WeatherEndpoints extends RequestEndpoint {
  @override
  final Map<String, String> queryParams;
  
  @override
  final String path;

  WeatherEndpoints({
    @required this.path,
    @required this.queryParams
  });
  

  factory WeatherEndpoints.getCurrentWeather ({
    double latitude, 
    double longitude 
  }) {
    return WeatherEndpoints(
      path: EndpointConstants.pathBuilder(WeatherAPIServices.weather),
      queryParams: {
        "lat": '$latitude',
        "lon": '$longitude',
        "appid": EndpointConstants.appID
      }
    );
  }

  factory WeatherEndpoints.getForecastsForDays ({
    double lat,
    double lon 
  }) => WeatherEndpoints(
    path: EndpointConstants.pathBuilder(WeatherAPIServices.forecast),
    queryParams: {
      "appid": EndpointConstants.appID,
      "lat": lat.toString(),
      "lon": lon.toString(),
      "exclude": "hourly,current,minutely,alerts"
    }
  );
 
  factory WeatherEndpoints.getCityWeather ({
    String cityName
  }) => WeatherEndpoints(
    path: EndpointConstants.pathBuilder(WeatherAPIServices.weather),
    queryParams: {
      "appid": EndpointConstants.appID,
      "q": cityName,
    }
  );

  /// Builder method which returns Uri
  Uri getURL () {
    return Uri(
      scheme: 'https',
      host: EndpointConstants.host,
      path: this.path,
      queryParameters: this.queryParams
    );
  }
}







