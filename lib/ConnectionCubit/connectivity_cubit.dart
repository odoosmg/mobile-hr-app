import 'dart:ffi';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/Screens/components/snackbar/connectivity_snackar.dart';
import 'package:hrm_employee/Services/app_services.dart';
import 'package:hrm_employee/Services/navigation_service.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final Connectivity _connectivity = Connectivity();
  ConnectivityCubit() : super(ConnectivityState()) {
    _connectivity.onConnectivityChanged.listen((value) {
      bool isConnected = false;

      /// mobile or wifi
      if (value.contains(ConnectivityResult.mobile) ||
          value.contains(ConnectivityResult.wifi)) {
        isConnected = true;
      }

      state.isConnected = isConnected;

      // print("cubit ==================");

      // if (state.isConnected != null) {
      //   if (state.isConnected!) {
      //     ConnectivitySnackbar.online();
      //   } else {
      //     ConnectivitySnackbar.offline();
      //   }
      // }

      // emit(state.copyWith(state));
    });
  }
}
