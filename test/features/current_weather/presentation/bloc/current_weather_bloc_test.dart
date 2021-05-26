import 'package:bloc_test/bloc_test.dart' as blocTest;
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_yerke/core/exceptions/app_exceptions.dart';
import 'package:weather_yerke/core/models/location.dart';
import 'package:weather_yerke/features/current_weather/domain/entities/city.dart';
import 'package:weather_yerke/features/current_weather/domain/entities/weather_condition.dart';
import 'package:weather_yerke/features/current_weather/domain/entities/weather_entity.dart';
import 'package:weather_yerke/features/current_weather/domain/usecases/getCityWeather.dart';
import 'package:weather_yerke/features/current_weather/domain/usecases/getUserLocationWeather.dart';
import 'package:weather_yerke/features/current_weather/presentation/bloc/current_weather/current_weather_cubit.dart';

class MockGetUserLocationWeatherUseCase extends Mock implements GetUserLocationWeather {}

class MockGetCityWeatherUseCase extends Mock implements GetCityWeather {}

void main () {
  CurrentWeatherCubit cubit;
  MockGetUserLocationWeatherUseCase mockGetUserLocationWeatherUseCase;
  MockGetCityWeatherUseCase mockGetCityWeatherUseCase;

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
  );

  setUp(() {
    mockGetUserLocationWeatherUseCase = MockGetUserLocationWeatherUseCase();
    mockGetCityWeatherUseCase = MockGetCityWeatherUseCase();
    cubit = CurrentWeatherCubit(
      getCityWeather: mockGetCityWeatherUseCase,
      getUserLocationWeather: mockGetUserLocationWeatherUseCase
    );
  });

  test("Check initial state of the cubit", () {
    expect(cubit.state, equals(CurrentWeatherState.emptyState));
  });

  group ("getWeatherByLocation", () {
    blocTest.blocTest<CurrentWeatherCubit, CurrentWeatherState>(
      'Should emit success status',
      build: () {
        when(mockGetUserLocationWeatherUseCase.call(any))
          .thenAnswer((_) async => Right(weatherEntity));
        return cubit;
      },
      act: (cubit) => cubit.getWeatherByLocation(Geolocation(latitude: 0.9, longtitude: 0.9)),
      expect: () => <CurrentWeatherState>[
        CurrentWeatherState(
          weatherDetails: CurrentWeatherState.emptyState.weatherDetails,
          status: CurrentWeatherLoadingStatus()
        ),
        CurrentWeatherState(
          weatherDetails: weatherEntity,
          status: CurrentWeatherLoadedStatus()
        )
      ],
    );

    blocTest.blocTest<CurrentWeatherCubit, CurrentWeatherState>(
      'Should emit error status',
      build: () {
        when(mockGetUserLocationWeatherUseCase.call(any))
          .thenAnswer((_) async => Left(RequestFailure()));
        return cubit;
      },
      act: (cubit) => cubit.getWeatherByLocation(Geolocation(latitude: 0.9, longtitude: 0.9)),
      expect: () => <CurrentWeatherState>[
        CurrentWeatherState(
          weatherDetails: CurrentWeatherState.emptyState.weatherDetails,
          status: CurrentWeatherLoadingStatus()
        ),
        CurrentWeatherState(
          weatherDetails: CurrentWeatherState.emptyState.weatherDetails,
          status: CurrentWeatherErrorStatus(
            "Couldn't get weather details"
          )
        )
      ],
    );
  });


  group ("getWeatherByCity", () {
    blocTest.blocTest<CurrentWeatherCubit, CurrentWeatherState>(
      'Should emit success status',
      build: () {
        when(mockGetCityWeatherUseCase.call(any))
          .thenAnswer((_) async => Right(weatherEntity));
        return cubit;
      },
      act: (cubit) => cubit.getWeatherByCity("Almaty"),
      expect: () => <CurrentWeatherState>[
        CurrentWeatherState(
          weatherDetails: CurrentWeatherState.emptyState.weatherDetails,
          status: CurrentWeatherLoadingStatus()
        ),
        CurrentWeatherState(
          weatherDetails: weatherEntity,
          status: CurrentWeatherLoadedStatus()
        )
      ],
    );

    blocTest.blocTest<CurrentWeatherCubit, CurrentWeatherState>(
      'Should emit error status',
      build: () {
        when(mockGetCityWeatherUseCase.call(any))
          .thenAnswer((_) async => Left(RequestFailure()));
        return cubit;
      },
      act: (cubit) => cubit.getWeatherByCity("Almaty"),
      expect: () => <CurrentWeatherState>[
        CurrentWeatherState(
          weatherDetails: CurrentWeatherState.emptyState.weatherDetails,
          status: CurrentWeatherLoadingStatus()
        ),
        CurrentWeatherState(
          weatherDetails: CurrentWeatherState.emptyState.weatherDetails,
          status: CurrentWeatherErrorStatus(
            "Couldn't get weather details"
          )
        )
      ],
    );
  });
}