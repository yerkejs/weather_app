import 'package:flutter/foundation.dart';
import 'package:weather_yerke/core/exceptions/exceptions_base.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_yerke/core/helpers/usecase_base.dart';
import 'package:weather_yerke/core/models/location.dart';
import 'package:weather_yerke/features/current_weather/domain/entities/weather_entity.dart';
import 'package:weather_yerke/features/current_weather/domain/repositories/current_weather_repository.dart';

class GetUserLocationWeather extends UseCase<WeatherEntity, Geolocation> {
  
  // MARK: - Props
  
  final CurrentWeatherRepository repository;
  
  // MARK: - Constructor

  GetUserLocationWeather({
    @required this.repository
  });

  @override
  Future<Either<Failure, WeatherEntity>> call(Geolocation params) {
    return repository.getUserLocationWeather(params);
  }
}