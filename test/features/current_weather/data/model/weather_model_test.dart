import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_yerke/core/models/location.dart';
import 'package:weather_yerke/features/current_weather/data/models/weather_condition_model.dart';
import 'package:weather_yerke/features/current_weather/data/models/weather_model.dart';
import 'package:weather_yerke/features/current_weather/domain/entities/city.dart';
import '../../../../fixtures/fixture_reader.dart';

void main () {
  final weatherModel = WeatherEntityModel(
    geolocation: Geolocation(
      latitude: 37.39,
      longtitude: -122.08
    ),
    dateTime: DateTime(2019, 6, 12, 20, 44, 5),
    temperature: 282.55,
    feelsLikeTemperature: 281.86,
    humidity: 100,
    windSpeed: 1.5,
    conditionModel: WeatherConditionModel(
      id: 800,
      name: 'Clear',
      description: "clear sky",
      iconKey: '01d',
      mainImagePath: WeatherConditionModel.getMainImageAssetPath(
        800, isDay: true
      )
    ),
    city: City(
      cityName: "Mountain View",
      conutryCode: "US",
      sunrise: DateTime(2019, 6, 12, 18, 47, 7),
      sunset: DateTime(2019, 6, 13, 9, 29, 23),
    ),
    pressure: 1023
  );

  final List<WeatherEntityModel> forecastModels = [
    WeatherEntityModel(
      dateTime: DateTime(2019, 6, 12, 20, 44, 5),
      temperature: 282.55,
      feelsLikeTemperature: 281.86,
      humidity: 100,
      windSpeed: 1.5,
      conditionModel: WeatherConditionModel(
        id: 800,
        name: 'Clear',
        description: "clear sky",
        iconKey: '01d',
        mainImagePath: WeatherConditionModel.getMainImageAssetPath(
          800, isDay: true
        )
      ),
      pressure: 1023
    )
  ];


  test("Should correctly decode weather model from the JSON", () {
    // Arrange 
    final Map decodedJson = json.decode(fixture('current_weather.json'));

    // Act
    final WeatherEntityModel decodedModel = WeatherEntityModel.fromJson(decodedJson);

    // Assert 
    expect(decodedModel, equals(weatherModel));
  });


  test("Should correctly decode forecasts from the JSON", () {
    // Arrange 
    final Map decodedJson = json.decode(fixture('weather_forecast.json'));

    // Act
    final List<WeatherEntityModel> decodedModels = WeatherEntityModel.getWeatherForecasts(decodedJson);

    // Assert 
    expect(decodedModels, equals(forecastModels));
  });
}