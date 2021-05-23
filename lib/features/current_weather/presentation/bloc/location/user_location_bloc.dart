import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_yerke/core/models/location.dart';

part 'user_location_event.dart';
part 'user_location_state.dart';

class UserLocationBloc extends Bloc<UserLocationEvent, UserLocationState> {
  UserLocationBloc() : super(UserLocationIdleState());

  // MARK: - Main Stream

  @override
  Stream<UserLocationState> mapEventToState(
    UserLocationEvent event,
  ) async* {
    if (event is LocationUseCheckPermission) {
      // Check current state of the user's permission for using location 
      LocationPermission locationPermission = await Geolocator.checkPermission();
      yield _mapPermissionToState(locationPermission);
    } else if (event is LocationUseRequestPermission) {
      // Requesting from user giving access to the location usage
      LocationPermission permission = await Geolocator.requestPermission();
      yield _mapPermissionToState(permission);
    } else if (event is GetUserLocation) {
      try {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

        if (position == null) {
          position = await Geolocator.getLastKnownPosition();
        }

        yield LocationUseSucceed(geolocation: position.toGeolocation());
      } catch (e) {
        yield LocationUseFailure();
      }
    }
  }

  // MARK: - Helpers 

  UserLocationState _mapPermissionToState (LocationPermission permission) {
    switch (permission) {
      case LocationPermission.always: case LocationPermission.whileInUse:
        return LocationUseApproved();
      case LocationPermission.deniedForever:
        return LocationUseDeniedForever();
      case LocationPermission.denied:
        return LocationUseDenied();
    }
  }
}


extension PositionExtension on Position {
  Geolocation toGeolocation () {
    return Geolocation(
      latitude: this.latitude,
      longtitude: this.longitude
    );
  }
}
