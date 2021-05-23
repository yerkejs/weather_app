import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_yerke/core/api/EndpointConstants.dart';

class WeatherCondition extends Equatable {
  final int id;
  final String name;
  final String description;
  final String iconKey;

  Uri get iconUri => EndpointConstants.getConditionIcon(iconKey);

  WeatherCondition({
    @required this.id, 
    @required this.name, 
    @required this.description, 
    @required this.iconKey
  });

  @override
  List<Object> get props => [
    id, name, description, iconKey
  ];
}