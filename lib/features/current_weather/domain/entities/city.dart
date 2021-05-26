import 'package:equatable/equatable.dart';

class City extends Equatable {
  final String cityName;
  final DateTime sunrise;
  final DateTime sunset;
  final String conutryCode;

  City({
    this.cityName,
    this.sunrise,
    this.sunset,
    this.conutryCode
  });

  /// Default city instance
  static City empty = City(
    cityName: "--",
    conutryCode: "--",
  );

  @override
  List<Object> get props => [
    cityName,
    sunrise, 
    sunset,
    conutryCode
  ];
}