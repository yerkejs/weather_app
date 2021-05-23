part of 'user_location_bloc.dart';

abstract class UserLocationEvent extends Equatable {
  const UserLocationEvent();

  @override
  List<Object> get props => [];
}


class LocationUseCheckPermission extends UserLocationEvent {}

class LocationUseRequestPermission extends UserLocationEvent {}

class GetUserLocation extends UserLocationEvent {}

