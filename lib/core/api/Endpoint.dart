import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'EndpointConstants.dart';

abstract class RequestEndpoint {
  Map<String, String> queryParams;
  String path;
}

class WeatherEndpoints extends RequestEndpoint {

  /// Query parameters for the HTTP/HTTPS requests
  @override
  final Map<String, String> queryParams;
  
  /// Path of the quest 
  @override
  final String path;

  WeatherEndpoints({
    @required this.path,
    @required this.queryParams
  });
  

  /// Endpoint for the request for getting weather data in specific location
  /// [num latitude], [num longitude] - locations of  the user
  factory WeatherEndpoints.getCurrentWeather ({
    num latitude, 
    num longitude 
  }) {
    return WeatherEndpoints(
      path: EndpointConstants.pathBuilder(WeatherAPIServices.weather),
      queryParams: {
        "lat": '$latitude',
        "lon": '$longitude',
        "appid": EndpointConstants.appID,
        "units": 'metric'
      }
    );
  }


  /// Endpoint for getting the forecasts for few days
  /// [num lat, num lon] - geolocation of the user 
  factory WeatherEndpoints.getForecastsForDays ({
    num lat,
    num lon 
  }) => WeatherEndpoints(
    path: EndpointConstants.pathBuilder(WeatherAPIServices.forecast),
    queryParams: {
      "appid": EndpointConstants.appID,
      "lat": lat.toString(),
      "lon": lon.toString(),
      "exclude": "hourly,current,minutely,alerts",
      "units": 'metric'
    }
  );
 

  /// Endpoint for getting weather data in specific city
  /// [String cityName] - Name of the city
  factory WeatherEndpoints.getCityWeather ({
    String cityName
  }) => WeatherEndpoints(
    path: EndpointConstants.pathBuilder(WeatherAPIServices.weather),
    queryParams: {
      "appid": EndpointConstants.appID,
      "q": cityName,
      "units": 'metric'
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