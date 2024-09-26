part of 'connectivity_cubit.dart';

class ConnectivityState {
  bool? isConnected;
  ConnectivityState({this.isConnected});

  ConnectivityState copyWith(ConnectivityState d) {
    return ConnectivityState(isConnected: d.isConnected);
  }
}

final class ConnectionInitial extends ConnectivityState {}
