import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Geolocation extends Equatable {
  final num latitude;
  final num longtitude;

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