part of 'current_weather_cubit.dart';

class CurrentWeatherState extends Equatable {

  // MARK: - Props
  
  final CurrentWeatherStatus status;
  final WeatherEntity weatherDetails;

  CurrentWeatherState({
    @required this.weatherDetails,
    @required this.status
  });

  @override
  List<Object> get props => [
    weatherDetails,
    status
  ];

  CurrentWeatherState copyWith ({
    CurrentWeatherStatus status,
    WeatherEntity weatherDetails
  }) => CurrentWeatherState(
    weatherDetails: weatherDetails ?? this.weatherDetails,
    status: status ?? this.status 
  );

  static CurrentWeatherState emptyState = CurrentWeatherState(
    weatherDetails: WeatherEntity(),
    status: CurrentWeatherLoadedStatus()
  );
}




/// MARK: - Statuses of state

abstract class CurrentWeatherStatus extends Equatable {
  @override
  List<Object> get props => [];
}

class CurrentWeatherLoadingStatus extends CurrentWeatherStatus {}

class CurrentWeatherErrorStatus extends CurrentWeatherStatus {
  final String message;

  CurrentWeatherErrorStatus(this.message);

  @override
  List<Object> get props => [message];
}

class CurrentWeatherLoadedStatus extends CurrentWeatherStatus {}