import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_yerke/core/models/location.dart';
import 'package:weather_yerke/features/current_weather/domain/entities/weather_entity.dart';
import 'package:weather_yerke/features/current_weather/domain/usecases/getCityWeather.dart';
import 'package:weather_yerke/features/current_weather/domain/usecases/getUserLocationWeather.dart';

part 'current_weather_state.dart';

class CurrentWeatherCubit extends Cubit<CurrentWeatherState> {
  
  // MARK: - Props

  final GetUserLocationWeather getUserLocationWeather;
  final GetCityWeather getCityWeather;

  // MARK: - Constructor

  CurrentWeatherCubit({
    @required this.getUserLocationWeather,
    @required this.getCityWeather
  }) : super(CurrentWeatherState.emptyState);

  // MARK: - Public 

  Future<void> getWeatherByLocation (
    Geolocation usersLocation
  ) async {
    emit(state.copyWith(status: CurrentWeatherLoadingStatus()));

    final response = await getUserLocationWeather(usersLocation);
    response.fold(
      (failure) => emit(
        state.copyWith(status: CurrentWeatherErrorStatus(failure.message))
      ), 
      (WeatherEntity entity) => emit (
        state.copyWith(
          weatherDetails: entity,
          status: CurrentWeatherLoadedStatus()
        )
      )
    );
  }

  Future<void> getWeatherByCity (
    String cityName
  ) async {
    emit(state.copyWith(status: CurrentWeatherLoadingStatus()));

    final response = await getCityWeather(cityName);
    
    response.fold(
      (failure) => emit(
        state.copyWith(status: CurrentWeatherErrorStatus(failure.message))
      ), 
      (WeatherEntity entity) => emit (
        state.copyWith(
          weatherDetails: entity,
          status: CurrentWeatherLoadedStatus()
        )
      )
    );
  }
}


