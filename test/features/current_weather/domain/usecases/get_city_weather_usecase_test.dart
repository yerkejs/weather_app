import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_yerke/core/models/location.dart';
import 'package:weather_yerke/features/current_weather/data/models/weather_condition_model.dart';
import 'package:weather_yerke/features/current_weather/data/models/weather_model.dart';
import 'package:weather_yerke/features/current_weather/domain/entities/city.dart';
import 'package:weather_yerke/features/current_weather/domain/entities/weather_condition.dart';
import 'package:weather_yerke/features/current_weather/domain/entities/weather_entity.dart';
import 'package:weather_yerke/features/current_weather/domain/repositories/current_weather_repository.dart';
import 'package:weather_yerke/features/current_weather/domain/usecases/getCityWeather.dart';

class MockCurrentWeatherRepository extends Mock implements CurrentWeatherRepository {}

void main () {
  GetCityWeather getCityWeather;
  MockCurrentWeatherRepository mockRepository;

  WeatherEntity weatherEntity = WeatherEntity(
    geolocation: Geolocation(
      latitude: 37.39,
      longtitude: -122.08
    ),
    dateTime: DateTime(2019, 6, 12, 20, 44, 5),
    temperature: 282.55,
    feelsLikeTemperature: 281.86,
    humidity: 100,
    windSpeed: 1.5,
    condition: WeatherCondition(
      id: 800,
      name: 'Clear',
      description: "clear sky",
      iconKey: '01d',
      mainImagePath: "image_path"
    ),
    city: City(
      cityName: "Mountain View",
      conutryCode: "US",
      sunrise: DateTime(2019, 6, 12, 18, 47, 7),
      sunset: DateTime(2019, 6, 13, 9, 29, 23),
    ),
    pressure: 1023,
    forecasts: [
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
    ]
  );

  setUp (() {
    mockRepository = MockCurrentWeatherRepository();
    getCityWeather = GetCityWeather(repository: mockRepository);
  });

  test ("Should return weather entity from the repository", () async {
    // Arrange 
    when(mockRepository.getCityWeather(any))
      .thenAnswer((_) async => Right(weatherEntity));
    
    // Act 
    final result = await getCityWeather.call("Almaty");

    // Assert 
    expect(result, Right(weatherEntity));
    verify(mockRepository.getCityWeather("Almaty"));
  });
}