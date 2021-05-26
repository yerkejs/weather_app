part of 'internet_connection_cubit.dart';

enum InternetConnectionStatus { hasConnection, noConnection }

class InternetConnectionState extends Equatable {
  
  /// Status of the network connection
  final InternetConnectionStatus status;
  
  const InternetConnectionState({
    @required this.status
  });

  @override
  List<Object> get props => [
    status
  ];
}


