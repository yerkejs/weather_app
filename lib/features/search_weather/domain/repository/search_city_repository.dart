abstract class SearchCityRepository {
  Future<void> cacheCitySearch(List<String> cities);
  Future<List<String>> getCachedCities ();
}