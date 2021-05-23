import 'package:flutter/foundation.dart';
import 'package:weather_yerke/features/search_weather/data/datasource/search_city_datasource.dart';
import 'package:weather_yerke/features/search_weather/domain/repository/search_city_repository.dart';

class SearchCityRepositoryImpl extends SearchCityRepository {
  
  final SearchCityDataSource dataSource;

  SearchCityRepositoryImpl({
    @required this.dataSource
  });
  
  @override
  Future<void> cacheCitySearch(List<String> cities) async {
    try {
      await dataSource.cacheCitySearch(cities);
    } catch (_) {}
  }

  @override
  Future<List<String>> getCachedCities() {
    try {
      return dataSource.getCachedCities();
    } catch (_) {
      return Future.value([]);
    }
  }
}