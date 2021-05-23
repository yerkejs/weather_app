part of 'user_location_bloc.dart';

abstract class UserLocationState extends Equatable {
  const UserLocationState();
  
  @override
  List<Object> get props => [];
}

class UserLocationIdleState extends UserLocationState {}

class LocationUseApproved extends UserLocationState {}

class LocationUseDeniedForever extends UserLocationState {}

class LocationUseDenied extends UserLocationState {}

class LocationUseSucceed extends LocationUseApproved {
  final Geolocation geolocation;

  LocationUseSucceed({
    @required this.geolocation
  });

  @override
  List<Object> get props => [
    geolocation
  ];
}

class LocationUseFailure extends UserLocationState {}