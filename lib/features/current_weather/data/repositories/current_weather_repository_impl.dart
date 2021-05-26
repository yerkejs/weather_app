
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_yerke/core/exceptions/app_exceptions.dart';
import 'package:weather_yerke/core/exceptions/exceptions_base.dart';
import 'package:weather_yerke/core/models/location.dart';
import 'package:weather_yerke/features/current_weather/data/datasources/current_weather_remote_datasource.dart';
import 'package:weather_yerke/features/current_weather/domain/entities/weather_entity.dart';
import 'package:weather_yerke/features/current_weather/domain/repositories/current_weather_repository.dart';

class CurrentWeatherRepositoryImpl extends CurrentWeatherRepository {
  final CurrentWeatherRemoteDataSource currentWeatherRemoteDataSource;

  // MARK: - Constructor

  CurrentWeatherRepositoryImpl({
    @required this.currentWeatherRemoteDataSource
  });

  // MARK: - Public

  @override
  Future<Either<Failure, WeatherEntity>> getCityWeather(String cityName) async {
    try {
      final weatherDetails = await currentWeatherRemoteDataSource.getCityWeather(cityName);
      final weatherForecasts = await currentWeatherRemoteDataSource.getForecastForDays(
        weatherDetails.geolocation.latitude,
        weatherDetails.geolocation.longtitude
      );

      return Right(weatherDetails.copyWith(
        forecasts: weatherForecasts
      ));
    } on SocketException {
      return Left(NetworkErrorFailure());
    } on FormatException {
      return Left(FormatFailure());
    } catch (error) {
      if (error is Failure) {
        return Left(error);
      }

      return Left(UndefinedFailure());
    }
  }
  
  @override
  Future<Either<Failure, WeatherEntity>> getUserLocationWeather(Geolocation location) async {
    try {
      final weatherDetails = await currentWeatherRemoteDataSource.getCurrentPositionsWeather(location);
      final weatherForecasts = await currentWeatherRemoteDataSource.getForecastForDays(
        weatherDetails.geolocation.latitude,
        weatherDetails.geolocation.longtitude
      );

      return Right(weatherDetails.copyWith(
        forecasts: weatherForecasts
      ));
    } on SocketException {
      return Left(NetworkErrorFailure());
    } on FormatException {
      return Left(FormatFailure());
    } catch (error) {
      if (error is Failure) {
        return Left(error);
      }

      return Left(UndefinedFailure());
    }
  }  
}