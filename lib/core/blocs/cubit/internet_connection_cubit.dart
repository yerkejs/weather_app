import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'internet_connection_state.dart';

class InternetConnectionCubit extends Cubit<InternetConnectionState> {
  
  final DataConnectionChecker dataConnectionChecker;
  
  InternetConnectionCubit({
    @required this.dataConnectionChecker
  }) : super(
    InternetConnectionState(status: InternetConnectionStatus.hasConnection)
  ) {
    connectionStatusSubscription = dataConnectionChecker.onStatusChange.listen((status) { 
      emit(InternetConnectionState(
        status: status == DataConnectionStatus.connected ? 
          InternetConnectionStatus.hasConnection : InternetConnectionStatus.noConnection
      ));
    });
  }

  StreamSubscription<DataConnectionStatus> connectionStatusSubscription;

  @override
  Future<void> close() {
    connectionStatusSubscription.cancel();
    return super.close();
  }
}
