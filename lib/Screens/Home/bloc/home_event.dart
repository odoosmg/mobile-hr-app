part of 'home_bloc.dart';

class HomeEvent {}

class HomeCheckIn extends HomeEvent {}

class HomeCheckOut extends HomeEvent {
  final int checkInId;
  HomeCheckOut({required this.checkInId});
}

class HomeGetData extends HomeEvent {
  /// display loading when get data
  /// *note: onRefresh no need to display loading
  final bool isLoading;
  HomeGetData({this.isLoading = true});
}

class HomeAppPermission extends HomeEvent {}
