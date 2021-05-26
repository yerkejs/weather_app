import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:weather_yerke/core/constants/constants.dart';
import 'package:weather_yerke/core/exceptions/app_exceptions.dart';

abstract class SearchCityDataSource {
  Future<void> cacheCitySearch(List<String> cities);
  Future<List<String>> getCachedCities ();
}

class SearchCityDataSourceImpl extends SearchCityDataSource {
  final HiveInterface hive;

  SearchCityDataSourceImpl({
    @required this.hive
  });

  @override
  Future<void> cacheCitySearch(List<String> cities) async {
    Box cityBox = await _openBox(CITY_BOX_KEY);
    cityBox.put(CITY_BOX_KEY, cities);
  }

  @override
  Future<List<String>> getCachedCities() async {
    Box cityBox = await _openBox(CITY_BOX_KEY);
    return cityBox.get(CITY_BOX_KEY);
  }

  /// Retrieves [Box] of [Hive]
  Future<Box> _openBox(String type) async {
    try {
      final box = await hive.openBox(type);
      return box;
    } catch (_) {
      throw CacheFailure();
    }
  }
}