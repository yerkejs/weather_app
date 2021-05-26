import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_yerke/core/api/EndpointConstants.dart';

/// Entity which is responsible for the weather conditions 
/// such as Clear Sky, Rain, Snow and e.t.c
class WeatherCondition extends Equatable {
  final int id;
  final String name;
  final String description;
  
  /// Key of the icon 
  final String iconKey;
  
  /// Path for the image in assets
  final String mainImagePath;

  Uri get iconUri => EndpointConstants.getConditionIcon(iconKey);

  WeatherCondition({
    @required this.id, 
    @required this.name, 
    @required this.description, 
    @required this.iconKey,
    @required this.mainImagePath
  });

  @override
  List<Object> get props => [
    id, name, description, iconKey, mainImagePath
  ];
}