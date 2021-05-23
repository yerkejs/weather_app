import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Geolocation extends Equatable {
  final double latitude;
  final double longtitude;

  Geolocation({
    @required this.latitude,
    @required this.longtitude
  });

  @override
  List<Object> get props => [
    latitude,
    longtitude
  ];
}