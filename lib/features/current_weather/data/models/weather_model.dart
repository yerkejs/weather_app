import 'package:weather_yerke/core/models/location.dart';
import 'package:weather_yerke/features/current_weather/data/models/weather_condition_model.dart';
import 'package:weather_yerke/features/current_weather/domain/entities/city.dart';
import 'package:weather_yerke/features/current_weather/domain/entities/weather_entity.dart';

class WeatherEntityModel extends WeatherEntity {
  
  // MARK: - Props
  
  final DateTime dateTime;
  final num temperature;
  final num feelsLikeTemperature;
  final num humidity;
  final num windSpeed;
  final WeatherConditionModel conditionModel;
  final City city;
  final Geolocation geolocation;
  final num pressure;
  
  // MARK: - Constructor

  WeatherEntityModel({
    this.dateTime,
    this.temperature,
    this.feelsLikeTemperature,
    this.humidity,
    this.windSpeed,
    this.conditionModel,
    this.city,
    this.geolocation,
    this.pressure
  }) : super(
    dateTime: dateTime,
    temperature: temperature,
    feelsLikeTemperature: feelsLikeTemperature,
    humidity: humidity,
    windSpeed: windSpeed,
    condition: conditionModel,
    city: city,
    geolocation: geolocation,
    pressure: pressure
  );

  // MARK: - Factories

  factory WeatherEntityModel.fromJson (Map<String, dynamic> json) {
    var weatherConditionsJson = ((json['weather'] ?? []) as List);
    
    return WeatherEntityModel(
      dateTime: json['dt'] != null ? 
        DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000) : null,
      temperature: json["main"]['temp'],
      feelsLikeTemperature: json["main"]['feels_like'],
      humidity: json["main"]['humidity'],
      windSpeed: json["wind"]['speed'],
      conditionModel: weatherConditionsJson.length == 0 ? 
        null : WeatherConditionModel.fromJson(weatherConditionsJson[0]),
      geolocation: Geolocation(
        latitude: json["coord"]["lat"],
        longtitude: json['coord']['lon']
      ),
      pressure: json['main']['pressure'],
      city: City(
        cityName: json['name'],
        sunrise: json['sys']["sunrise"] != null ? 
          DateTime.fromMillisecondsSinceEpoch(json['sys']["sunrise"] * 1000) : null,
        sunset: json['sys']["sunset"] != null ? 
          DateTime.fromMillisecondsSinceEpoch(json['sys']["sunset"] * 1000) : null,
        conutryCode: json['sys']['country']
      )
    );
  }

  static List<WeatherEntity> getWeatherForecasts (Map<String, dynamic> json) {
    final List<WeatherEntityModel> weathers = [];
    
    for (final item in json['daily']) { 
      var weatherConditionsJson = ((item['weather'] ?? []) as List);

      weathers.add(WeatherEntityModel(
        dateTime: item['dt'] != null ? 
          DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000) : null,
        temperature: item['temp']['day'],
        conditionModel: weatherConditionsJson.length == 0 ? 
          null : WeatherConditionModel.fromJson(weatherConditionsJson[0]),
        feelsLikeTemperature: item['feels_like']['day'],
        humidity: item['humidity'],
        windSpeed: item['wind_speed'],
        pressure: item['pressure']
      ));
    }

    return weathers;
  }
}