part of 'internet_connection_cubit.dart';

enum InternetConnectionStatus { hasConnection, noConnection }

class InternetConnectionState extends Equatable {
  
  final InternetConnectionStatus status;
  
  const InternetConnectionState({
    @required this.status
  });

  @override
  List<Object> get props => [
    status
  ];
}


