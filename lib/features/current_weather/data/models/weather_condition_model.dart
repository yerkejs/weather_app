
import 'package:flutter/foundation.dart';
import 'package:weather_yerke/core/constants/constants.dart';
import 'package:weather_yerke/features/current_weather/domain/entities/weather_condition.dart';
import 'package:weather_yerke/core/helpers/num_extension.dart';

/// DTO Model for decoding [WeatherCondition] class
class WeatherConditionModel extends WeatherCondition {
  final int id;
  final String name;
  final String description;
  final String iconKey;
  final String mainImagePath;

  WeatherConditionModel({
    @required this.id, 
    @required this.name, 
    @required this.description, 
    @required this.iconKey,
    @required this.mainImagePath
  }) : super(
    id: id,
    name: name,
    description: description,
    iconKey: iconKey,
    mainImagePath: mainImagePath
  );

  /// Converts Json of the condition to the [WeatherConditionModel] class
  /// which is the subclass of the [WeatherCondition]
  factory WeatherConditionModel.fromJson (Map<String, dynamic> json) {
    final isDay = ((json['icon'] ?? '') as String).endsWith('d');
    
    return WeatherConditionModel(
      id: json['id'],
      name: json['main'],
      description: json['description'],
      iconKey: json['icon'],
      mainImagePath: getMainImageAssetPath(json['id'], isDay: isDay)
    );
  }

  /// Returns Path of the image in assets folder for the specific id of the weather condition
  static String getMainImageAssetPath (int id, {bool isDay = true}) {
    var dayNightMark = isDay ? "d" : "n";
    String idPath = "";

    if (id.isBetween(200, 299)) {
      /// Thunderstorm
      idPath = "01";
    } else if (id.isBetween(300, 399)) {
      /// Drizzle
      idPath = "09";
    } else if (id.isBetween(500, 599)) {
      /// Rain
      idPath = id <= 504 ? '10' : id >= 520 ? '09' : '13';
    } else if (id.isBetween(600, 699)) {
      /// Snow
      idPath = '13';
    } else if (id.isBetween(700, 799)) {
      idPath = '50';
    } else if (id.isBetween(800, 899)) {
      /// Clouds
      if (id == 800) {
        idPath = '01';
      } else if (id == 801) {
        idPath = '02';
      } else if (id == 802) {
        idPath = '03';
      } else {
        idPath = '04';
      }
    }

    return "$IMAGE_ASSET_PATH$idPath$dayNightMark.png";
  }  
}