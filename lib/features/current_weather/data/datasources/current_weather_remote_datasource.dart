import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:weather_yerke/core/api/Endpoint.dart';
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

  @override
  Future<WeatherEntity> getCurrentPositionsWeather(Geolocation location) async {
    http.Response response = await http.get(WeatherEndpoints.getCurrentWeather(
      latitude: location.latitude, 
      longitude: location.longtitude
    ).getURL());

    var json = jsonDecode(response.body);
    return WeatherEntityModel.fromJson(json);
  }

  @override
  Future<WeatherEntity> getCityWeather(String cityName) async {
    http.Response response = await http.get(WeatherEndpoints.getCityWeather(
      cityName: cityName 
    ).getURL());

    var json = jsonDecode(response.body);
    return WeatherEntityModel.fromJson(json);
  }

  @override
  Future<List<WeatherEntity>> getForecastForDays(double lat, double lon) async {
    http.Response response = await http.get(WeatherEndpoints.getForecastsForDays(
      lat: lat,
      lon: lon
    ).getURL());

    var json = jsonDecode(response.body);
    return WeatherEntityModel.getWeatherForecasts(json);
  }
}