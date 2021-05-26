import 'package:equatable/equatable.dart';
import 'package:weather_yerke/core/models/location.dart';
import 'package:weather_yerke/features/current_weather/domain/entities/weather_condition.dart';

import 'city.dart';

class WeatherEntity extends Equatable {
  final DateTime dateTime;
  final num temperature;
  final num feelsLikeTemperature;
  final num humidity;
  final num windSpeed;
  final num pressure;
  final WeatherCondition condition;
  final City city;
  final List<WeatherEntity> forecasts;
  final Geolocation geolocation;

  // MARK: - Constructor

  WeatherEntity({
    this.dateTime,
    this.temperature,
    this.feelsLikeTemperature,
    this.humidity,
    this.windSpeed,
    this.condition,
    this.city,
    this.forecasts,
    this.geolocation,
    this.pressure
  });
  
  // MARK: - Methods

  WeatherEntity copyWith ({
    DateTime dateTime,
    num temperature,
    num feelsLikeTemperature,
    num humidity,
    num windSpeed,
    num pressure,
    WeatherCondition condition,
    City city,
    List<WeatherEntity> forecasts,
    Geolocation geolocation
  }) => WeatherEntity(
    dateTime: dateTime ?? this.dateTime,
    temperature: temperature ?? this.temperature,
    feelsLikeTemperature: feelsLikeTemperature ?? this.feelsLikeTemperature,
    humidity: humidity ?? this.humidity,
    windSpeed: windSpeed ?? this.windSpeed,
    condition: condition ?? this.condition,
    city: city ?? this.city,
    forecasts: forecasts ?? this.forecasts,
    geolocation: geolocation ?? this.geolocation,
    pressure: pressure ?? this.pressure
  );

  @override
  List<Object> get props => [
    dateTime,
    temperature,
    feelsLikeTemperature,
    humidity,
    windSpeed,
    condition,
    forecasts,
    geolocation,
    pressure,
    city
  ];
}