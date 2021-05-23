import 'package:flutter/foundation.dart';
import 'package:weather_yerke/core/exceptions/exceptions_base.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_yerke/core/helpers/usecase_base.dart';
import 'package:weather_yerke/features/search_weather/domain/repository/search_city_repository.dart';

class SaveCityInCache extends VoidUseCase<List<String>> {
  
  // MARK: - Props
  
  final SearchCityRepository repository;
  
  // MARK: - Constructor

  SaveCityInCache({
    @required this.repository
  });

  @override
  Future<void> call(List<String> params) {
    return repository.cacheCitySearch(params);
  }
}