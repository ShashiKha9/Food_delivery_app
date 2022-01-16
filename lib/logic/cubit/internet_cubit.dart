
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/constants/internet.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription _connectivityStreamSubscription;

  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    monitorinternet();
  }

  StreamSubscription<ConnectivityResult>monitorinternet(){
  return
  _connectivityStreamSubscription = connectivity.onConnectivityChanged.listen((connectivityResult) {
    if(connectivityResult == ConnectivityResult.wifi){
      emit(InternetConnected(internet: Internet.Online));
  } else if(connectivityResult== ConnectivityResult.none){
      emit(InternetDisconnected());
  }
  });

  }
  @override
  close() async {
    _connectivityStreamSubscription.cancel();
    super.close();
  }
}

