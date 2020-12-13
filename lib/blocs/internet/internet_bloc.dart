import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  InternetBloc() : super(InternetInitial());
  StreamSubscription isThereInternet;

  @override
  Stream<InternetState> mapEventToState(InternetEvent event) async* {
    if (event is InitiateInternetStream) {
      isThereInternet?.cancel();
      isThereInternet = DataConnectionChecker().onStatusChange.listen((status) {
        switch (status) {
          case DataConnectionStatus.connected:
            add(InternetStateUpdated(connected: true));
            break;
          case DataConnectionStatus.disconnected:
            add(InternetStateUpdated(connected: false));
            break;
        }
      });
    }
    if (event is InternetStateUpdated) {
      if (event.connected) {
        yield InternetConnected();
      } else {
        yield InternetDisconnected();
      }
    }
  }

  @override
  Future<void> close() {
    isThereInternet?.cancel();
    return super.close();
  }
}
