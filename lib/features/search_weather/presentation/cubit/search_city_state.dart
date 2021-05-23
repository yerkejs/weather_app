part of 'search_city_cubit.dart';

enum SearchCityStatus { 
  loading, success, done
}

class SearchCityState extends Equatable {

  /// History of last searches 
  final List<String> historySearches;

  /// Status of the current state 
  final SearchCityStatus status;

  /// City search's query text
  final String queryText;

  /// Responsible for toggling visibility of the hint button "Select this city"
  bool get showHintButton => (historySearches ?? []).length == 0;

  SearchCityState({
    this.historySearches = const [],
    this.status,
    this.queryText
  });

  SearchCityState copyWith ({
    List<String> historySearches,
    SearchCityStatus status,
    String queryText
  }) => SearchCityState(
    historySearches: historySearches ?? this.historySearches,
    status: status ?? this.status,
    queryText: queryText ?? this.queryText
  );

  @override
  List<Object> get props => [
    historySearches,
    showHintButton,
    queryText
  ];
}

