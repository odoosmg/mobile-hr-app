part of 'home_bloc.dart';

class HomeState {
  ApiResult<InOutModel>? checkInResult;
  HomeState({this.checkInResult});

  HomeState copyWith(HomeState d) {
    return HomeState(checkInResult: d.checkInResult);
  }
}

final class HomeInitial extends HomeState {
  @override
  ApiResult<InOutModel>? get checkInResult => ApiResult()
    ..status = ApiStatus.loading
    ..data = InOutModel();
}
