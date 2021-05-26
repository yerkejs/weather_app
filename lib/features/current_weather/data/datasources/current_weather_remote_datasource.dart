import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/testing.dart';
import 'package:weather_yerke/core/api/Endpoint.dart';
import 'package:weather_yerke/core/exceptions/app_exceptions.dart';
import 'package:weather_yerke/core/models/location.dart';
import 'package:weather_yerke/features/current_weather/data/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:weather_yerke/features/current_weather/domain/entities/weather_entity.dart';

abstract class CurrentWeatherRemoteDataSource {
  Future<WeatherEntity> getCurrentPositionsWeather (Geolocation location);
  Future<WeatherEntity> getCityWeather (String cityName);
  Future<List<WeatherEntity>> getForecastForDays(double lat, double lon);
}

class CurrentWeatherRemoteDataSourceImpl extends CurrentWeatherRemoteDataSource {
  
  // MARK: - Props

  final http.Client client;

  // MARK: - Constructor

  CurrentWeatherRemoteDataSourceImpl({
    @required this.client
  });
  
  // MARK: - Public

  /// Sending request to the server to retrieve weather in specific location 
  /// [Geolocation location] - location of the user
  @override
  Future<WeatherEntity> getCurrentPositionsWeather(Geolocation location) async {
    http.Response response = await client.get(
      WeatherEndpoints.getCurrentWeather(
        latitude: location.latitude, 
        longitude: location.longtitude
      ).getURL(),
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return WeatherEntityModel.fromJson(json);
    } else {
      throw RequestFailure();
    }
  }

  /// Sending request to the server to retrieve weather in specific city 
  /// [String cityName] - city of the user
  @override
  Future<WeatherEntity> getCityWeather(String cityName) async {
    http.Response response = await client.get(WeatherEndpoints.getCityWeather(
      cityName: cityName 
    ).getURL());

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return WeatherEntityModel.fromJson(json);
    } else {
      throw RequestFailure();
    }
  }

  /// Sending request to get forecasts for few days
  /// [double lat, double lon] - geopositions of the user
  @override
  Future<List<WeatherEntity>> getForecastForDays(double lat, double lon) async {
    http.Response response = await client.get(WeatherEndpoints.getForecastsForDays(
      lat: lat,
      lon: lon
    ).getURL());
    
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return WeatherEntityModel.getWeatherForecasts(json);
    } else {
      throw RequestFailure();
    }
  }
}