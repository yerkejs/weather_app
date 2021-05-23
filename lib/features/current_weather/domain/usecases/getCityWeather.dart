import 'package:flutter/foundation.dart';
import 'package:weather_yerke/core/exceptions/exceptions_base.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_yerke/core/helpers/usecase_base.dart';
import 'package:weather_yerke/features/current_weather/domain/entities/weather_entity.dart';
import 'package:weather_yerke/features/current_weather/domain/repositories/current_weather_repository.dart';

class GetCityWeather extends UseCase<WeatherEntity, String> {
  
  // MARK: - Props
  
  final CurrentWeatherRepository repository;
  
  // MARK: - Constructor

  GetCityWeather({
    @required this.repository
  });

  @override
  Future<Either<Failure, WeatherEntity>> call(String cityName) {
    return repository.getCityWeather(cityName);
  }
}