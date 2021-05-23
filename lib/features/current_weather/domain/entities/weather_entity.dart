import 'package:equatable/equatable.dart';
import 'package:weather_yerke/core/models/location.dart';
import 'package:weather_yerke/features/current_weather/domain/entities/weather_condition.dart';

class WeatherEntity extends Equatable {
  final DateTime dateTime;
  final num temperature;
  final num feelsLikeTemperature;
  final num humidity;
  final num windSpeed;
  final WeatherCondition condition;
  final String cityName;
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
    this.cityName,
    this.forecasts,
    this.geolocation
  });
  
  // MARK: - Methods

  WeatherEntity copyWith ({
    DateTime dateTime,
    num temperature,
    num feelsLikeTemperature,
    num humidity,
    num windSpeed,
    WeatherCondition condition,
    String cityName,
    List<WeatherEntity> forecasts,
    Geolocation geolocation
  }) => WeatherEntity(
    dateTime: dateTime ?? this.dateTime,
    temperature: temperature ?? this.temperature,
    feelsLikeTemperature: feelsLikeTemperature ?? this.feelsLikeTemperature,
    humidity: humidity ?? this.humidity,
    windSpeed: windSpeed ?? this.windSpeed,
    condition: condition ?? this.condition,
    cityName: cityName ?? this.cityName,
    forecasts: forecasts ?? this.forecasts,
    geolocation: geolocation ?? this.geolocation
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
    geolocation
  ];
}