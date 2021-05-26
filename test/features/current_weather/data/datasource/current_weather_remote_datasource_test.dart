import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_yerke/core/api/Endpoint.dart';
import 'package:weather_yerke/core/exceptions/app_exceptions.dart';
import 'package:weather_yerke/core/models/location.dart';
import 'package:weather_yerke/features/current_weather/data/datasources/current_weather_remote_datasource.dart';
import 'package:weather_yerke/features/current_weather/data/models/weather_model.dart';
import 'package:http/http.dart' as http;
import '../../../../fixtures/fixture_reader.dart';
import '../../../../shared/constants.dart';
import '../../../../shared/mocked_http_client.dart';
import 'package:mockito/mockito.dart';


void main () {
  CurrentWeatherRemoteDataSourceImpl dataSource;
  MockHttpClient httpClient;

  setUp(() {
    httpClient = MockHttpClient();
    dataSource = CurrentWeatherRemoteDataSourceImpl(client: httpClient);
  });

  group ("getCurrentPositionsWeather", () {
    final currentWeatherModel = WeatherEntityModel.fromJson(
      json.decode(fixture("current_weather.json"))
    );

    test("Should send GET Request to the right server", () async {
      // Arrange
      when(httpClient.get(any, headers: anyNamed('headers')))
      .thenAnswer((_) async {
        return http.Response(fixture('current_weather.json'), 200);
      });

      // Act
      dataSource.getCurrentPositionsWeather(Geolocation(
        latitude: 0.9,
        longtitude: 0.9
      ));
      
      // Assert 
      verify(httpClient.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=0.9&lon=0.9&appid=${TestConstants.appID}&units=metric"
        ),
      ));
    }); 


    test("Should return correct entity's model", () async {
      // Arrange
      when(httpClient.get(any, headers: anyNamed('headers')))
      .thenAnswer((_) async {
        return http.Response(fixture('current_weather.json'), 200);
      });

      // Act
      final result = await dataSource.getCurrentPositionsWeather(Geolocation(
        latitude: 0.9,
        longtitude: 0.9
      ));

      // Assert
      expect(result, equals(currentWeatherModel));
    });

    test("Should throw RequestError when status is bad", () async {
      // Arrange
      when(httpClient.get(any, headers: anyNamed('headers')))
      .thenAnswer((_) async {
        return http.Response("Error", 403);
      });

      // Act
      final result = dataSource.getCurrentPositionsWeather;

      // Assert
      expect(
        result.call(Geolocation(
          latitude: 0.9,
          longtitude: 0.9
        )), 
      throwsA(isA<RequestFailure>()));
    });
  }); 


  group ("getCityWeather", () {
    final currentWeatherModel = WeatherEntityModel.fromJson(
      json.decode(fixture("current_weather.json"))
    );


    test("Should send GET Request to the right server", () async {
      // Arrange
      when(httpClient.get(any, headers: anyNamed('headers')))
      .thenAnswer((_) async {
        return http.Response(fixture('current_weather.json'), 200);
      });

      // Act
      dataSource.getCityWeather("Almaty");

      // Assert 
      verify(httpClient.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?appid=${TestConstants.appID}&q=Almaty&units=metric"
        ),
      ));
    }); 


    test("Should return correct entity's model", () async {
      // Arrange
      when(httpClient.get(any, headers: anyNamed('headers')))
      .thenAnswer((_) async {
        return http.Response(fixture('current_weather.json'), 200);
      });

      // Act
      final result = await dataSource.getCityWeather("Almaty");

      // Assert
      expect(result, equals(currentWeatherModel));
    });

    test("Should throw RequestError when status is bad", () async {
      // Arrange
      when(httpClient.get(any, headers: anyNamed('headers')))
      .thenAnswer((_) async {
        return http.Response("Error", 403);
      });

      // Act
      final result = dataSource.getCityWeather;

      // Assert
      expect(
        result.call('Almaty'), 
      throwsA(isA<RequestFailure>()));
    });
  }); 

  group ("getForecastForDays", () {
    Map weatherForecastMap = json.decode(fixture("weather_forecast.json"));
    List<WeatherEntityModel> forecasts = WeatherEntityModel.getWeatherForecasts(weatherForecastMap);

    test("Should send GET Request to the right server", () async {
      // Arrange
      when(httpClient.get(any, headers: anyNamed('headers')))
      .thenAnswer((_) async {
        return http.Response(fixture('weather_forecast.json'), 200);
      });

      // Act
      await dataSource.getForecastForDays(0.9, 0.9);

      // Assert 
      verify(httpClient.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/onecall?appid=${TestConstants.appID}&lat=0.9&lon=0.9&exclude=hourly%2Ccurrent%2Cminutely%2Calerts&units=metric"
        ),
      ));
    }); 


    test("Should return correct entity's model", () async {
      // Arrange
      when(httpClient.get(any, headers: anyNamed('headers')))
      .thenAnswer((_) async {
        return http.Response(fixture('weather_forecast.json'), 200);
      });

      // Act
      final result = await dataSource.getForecastForDays(0.9, 0.9);

      // Assert
      expect(result, equals(forecasts));
    });

    test("Should throw RequestError when status is bad", () async {
      // Arrange
      when(httpClient.get(any, headers: anyNamed('headers')))
      .thenAnswer((_) async {
        return http.Response("Error", 403);
      });

      // Act
      final result = dataSource.getForecastForDays;

      // Assert
      expect(
        result.call(0.9, 0.9), 
      throwsA(isA<RequestFailure>()));
    });
  }); 

}