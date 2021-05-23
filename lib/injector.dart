import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:weather_yerke/features/current_weather/data/datasources/current_weather_remote_datasource.dart';
import 'package:http/http.dart' as http;
import 'package:weather_yerke/features/current_weather/domain/repositories/current_weather_repository.dart';
import 'package:weather_yerke/features/current_weather/domain/usecases/getCityWeather.dart';
import 'package:weather_yerke/features/current_weather/domain/usecases/getUserLocationWeather.dart';
import 'package:weather_yerke/features/current_weather/presentation/bloc/location/user_location_bloc.dart';
import 'package:weather_yerke/features/search_weather/data/datasource/search_city_datasource.dart';
import 'package:weather_yerke/features/search_weather/data/repository/search_city_repository_impl.dart';
import 'package:weather_yerke/features/search_weather/domain/repository/search_city_repository.dart';
import 'package:weather_yerke/features/search_weather/domain/usecases/get_cities_from_cache.dart';
import 'package:weather_yerke/features/search_weather/domain/usecases/save_city_in_cache.dart';
import 'package:weather_yerke/features/search_weather/presentation/cubit/search_city_cubit.dart';

import 'features/current_weather/data/repositories/current_weather_repository_impl.dart';
import 'features/current_weather/presentation/bloc/current_weather/current_weather_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  
  // Bloc

  sl.registerFactory(
    () => CurrentWeatherCubit(
      getUserLocationWeather: sl(),
      getCityWeather: sl()
    )
  );

  sl.registerFactory(
    () => UserLocationBloc()
  );

  sl.registerFactory(
    () => SearchCityCubit(
      saveCityInCache: sl(), 
      getCitiesFromCache: sl()
    )
  );

  // Use case

  sl.registerLazySingleton(
    () => GetUserLocationWeather(repository: sl())
  );

  sl.registerLazySingleton(
    () => GetCityWeather(repository: sl())
  );

  sl.registerLazySingleton(
    () => SaveCityInCache(repository: sl())
  );

  sl.registerLazySingleton(
    () => GetCitiesFromCache(repository: sl())
  );

  // Repository

  sl.registerLazySingleton<CurrentWeatherRepository>(
    () => CurrentWeatherRepositoryImpl(
      currentWeatherRemoteDataSource: sl()
    )
  );

  sl.registerLazySingleton<SearchCityRepository>(
    () => SearchCityRepositoryImpl(
      dataSource: sl()
    )
  );

  // DataSources

  sl.registerLazySingleton<CurrentWeatherRemoteDataSource>(
    () => CurrentWeatherRemoteDataSourceImpl(client: sl())
  );

  sl.registerLazySingleton<SearchCityDataSource>(
    () => SearchCityDataSourceImpl(
      hive: Hive
    )
  );

  // Helpers

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}