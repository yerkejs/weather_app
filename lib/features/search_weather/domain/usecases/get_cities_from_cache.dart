import 'package:flutter/foundation.dart';
import 'package:weather_yerke/core/helpers/usecase_base.dart';
import 'package:weather_yerke/features/search_weather/domain/repository/search_city_repository.dart';

class GetCitiesFromCache extends SuccessOnlyUseCase<List<String>, NoParams> {
  
  // MARK: - Props
  
  final SearchCityRepository repository;
  
  // MARK: - Constructor

  GetCitiesFromCache({
    @required this.repository
  });

  @override
  Future<List<String>> call(NoParams params) async {
    return await repository.getCachedCities();
  }
}