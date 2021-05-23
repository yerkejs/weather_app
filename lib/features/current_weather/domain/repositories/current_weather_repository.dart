import 'package:dartz/dartz.dart';
import 'package:weather_yerke/core/exceptions/exceptions_base.dart';
import 'package:weather_yerke/core/models/location.dart';
import 'package:weather_yerke/features/current_weather/domain/entities/weather_entity.dart';

abstract class CurrentWeatherRepository {
  Future<Either<Failure, WeatherEntity>> getUserLocationWeather (Geolocation location);
  Future<Either<Failure, WeatherEntity>> getCityWeather (String cityName);
}
