import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_yerke/core/exceptions/app_exceptions.dart';
import 'package:weather_yerke/core/models/location.dart';
import 'package:weather_yerke/features/current_weather/data/datasources/current_weather_remote_datasource.dart';
import 'package:weather_yerke/features/current_weather/data/models/weather_condition_model.dart';
import 'package:weather_yerke/features/current_weather/data/models/weather_model.dart';
import 'package:weather_yerke/features/current_weather/data/repositories/current_weather_repository_impl.dart';
import 'package:weather_yerke/features/current_weather/domain/entities/city.dart';
import 'package:weather_yerke/features/current_weather/domain/entities/weather_entity.dart';
import 'package:weather_yerke/features/current_weather/domain/repositories/current_weather_repository.dart';

class MockRemoteDataSource extends Mock implements CurrentWeatherRemoteDataSource {}

void main () {

  WeatherEntityModel weatherModel;
  WeatherEntity weatherEntity;
  WeatherEntity fullWeatherEntity; 

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



  MockRemoteDataSource mockRemoteDataSource;
  CurrentWeatherRepository currentWeatherRepository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    currentWeatherRepository = CurrentWeatherRepositoryImpl(
      currentWeatherRemoteDataSource: mockRemoteDataSource
    );

    weatherModel = WeatherEntityModel(
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

    fullWeatherEntity = WeatherEntityModel(
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
      pressure: 1023,
    );

    fullWeatherEntity = fullWeatherEntity.copyWith(
      forecasts: forecastModels
    );
    weatherEntity = weatherModel;
  });

  group("getCityWeather", () {
    test ("Check offline mode", () async {
      // Assign 
      when(
        mockRemoteDataSource.getCityWeather(any)
      ).thenAnswer((_) async => throw SocketException("no internet"));

      // Act 
      final response = await currentWeatherRepository.getCityWeather("Almaty");
      var output;

      response.fold(
        (leftPart) => output = leftPart, 
        (rightPart) => output = rightPart
      );

      // Assert 
      expect(response.isLeft(), true);
      expect(output, isA<NetworkErrorFailure>());
    });

    test("Right data is retrieved", () async {
      // Assign 
      
      when(
        mockRemoteDataSource.getCityWeather(any)
      ).thenAnswer((_) async => weatherModel);

      when(
        mockRemoteDataSource.getForecastForDays(any, any)
      ).thenAnswer((_) async => forecastModels);

      // act
      
      final result = await currentWeatherRepository.getCityWeather("Almaty");
      final output = result.getOrElse(() => null);

      // assert
      
      verify(mockRemoteDataSource.getCityWeather("Almaty"));
      verify(mockRemoteDataSource.getForecastForDays(37.39, -122.08));
      expect(output.forecasts, equals(forecastModels));
      expect(output, equals(fullWeatherEntity));
    });
  });


  group("getUserLocationWeather", () {
    test ("Check offline mode", () async {
      // Assign 
      when(
        mockRemoteDataSource.getCurrentPositionsWeather(any)
      ).thenAnswer((_) async => throw SocketException("no internet"));

      // Act 
      final response = await currentWeatherRepository.getUserLocationWeather(
        Geolocation(latitude: 0.9, longtitude: 0.9)
      );

      var output;

      response.fold(
        (leftPart) => output = leftPart, 
        (rightPart) => output = rightPart
      );

      // Assert 
      expect(response.isLeft(), true);
      expect(output, isA<NetworkErrorFailure>());
    });

    test("Right data is retrieved", () async {
      // Assign 
      when(
        mockRemoteDataSource.getCurrentPositionsWeather(any)
      ).thenAnswer((_) async => weatherModel);

      when(
        mockRemoteDataSource.getForecastForDays(any, any)
      ).thenAnswer((_) async => forecastModels);

      // act
      final result = await currentWeatherRepository.getUserLocationWeather(
        Geolocation(latitude: 0.9, longtitude: 0.9)
      );
      final output = result.getOrElse(() => null);

      // assert
      verify(mockRemoteDataSource.getCurrentPositionsWeather(
        Geolocation(latitude: 0.9, longtitude: 0.9)
      ));
      expect(output, equals(fullWeatherEntity));
    });
  });
}