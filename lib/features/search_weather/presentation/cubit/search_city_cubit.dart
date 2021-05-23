import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_yerke/core/helpers/usecase_base.dart';
import 'package:weather_yerke/features/search_weather/domain/usecases/get_cities_from_cache.dart';
import 'package:weather_yerke/features/search_weather/domain/usecases/save_city_in_cache.dart';

part 'search_city_state.dart';

const MAX_NUMBER_OF_CACHED_CITIES = 5;

class SearchCityCubit extends Cubit<SearchCityState> {
  
  // MARK: - Props
  
  final SaveCityInCache saveCityInCache;
  final GetCitiesFromCache getCitiesFromCache;

  /// original array of search history
  /// not filtered by the user, text search does not affect it 
  List<String> _mainSearchHistory = [];

  // MARK: - Constructor

  SearchCityCubit({
    @required this.saveCityInCache,
    @required this.getCitiesFromCache
  }) : super(SearchCityState(
    status: SearchCityStatus.loading
  ));

  // MARK: - Public 

  Future<void> getSavedCities () async {
    final savedCities = await getCitiesFromCache(NoParams());
    _mainSearchHistory = savedCities;
    emit(state.copyWith(
      historySearches: savedCities ?? [],
      status: SearchCityStatus.success
    ));
  }

  Future<void> saveCity (String cityName) async {
    _mainSearchHistory = [cityName, ..._mainSearchHistory.take(MAX_NUMBER_OF_CACHED_CITIES - 1)];
    await saveCityInCache.call(_mainSearchHistory);
    emit(state.copyWith(
      status: SearchCityStatus.done,
      historySearches: _mainSearchHistory
    ));
  }

  void cityQueryChanged (String queryText) {
    emit(state.copyWith(
      queryText: queryText,
      historySearches: _mainSearchHistory.where(
        (cachedCity) => cachedCity.toLowerCase().contains(queryText.toLowerCase())
      ).toList()
    ));
  } 

  void onSelectedCity () => emit(state.copyWith(status: SearchCityStatus.done));
}
