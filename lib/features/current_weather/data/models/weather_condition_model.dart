
import 'package:flutter/foundation.dart';
import 'package:weather_yerke/features/current_weather/domain/entities/weather_condition.dart';

class WeatherConditionModel extends WeatherCondition {
  final int id;
  final String name;
  final String description;
  final String iconKey;

  WeatherConditionModel({
    @required this.id, 
    @required this.name, 
    @required this.description, 
    @required this.iconKey
  }) : super(
    id: id,
    name: name,
    description: description,
    iconKey: iconKey
  );

  /// Converts Json of the condition to the [WeatherConditionModel] class
  /// which is the subclass of the [WeatherCondition]
  factory WeatherConditionModel.fromJson (Map<String, dynamic> json) {
    return WeatherConditionModel(
      id: json['id'],
      name: json['main'],
      description: json['description'],
      iconKey: json['icon']
    );
  }
}