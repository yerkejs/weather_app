import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_yerke/core/models/location.dart';
import 'package:weather_yerke/features/current_weather/domain/entities/city.dart';
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

  /// Getting weather details for the current location of the user
  Future<void> getWeatherByLocation (
    Geolocation usersLocation
  ) async {

    /// Sending loading status
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

  /// Getting weather details for the specific city
  Future<void> getWeatherByCity (
    String cityName
  ) async {

    /// Sending loading status
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


