part of 'home_bloc.dart';

class HomeState {
  HomeStateType? stateType;
  ApiResult<InOutModel>? checkInResult;
  ApiResult<InOutModel>? checkOutResult;
  ApiResult<InOutModel>? getDataResult;
  HomeState({
    this.stateType,
    this.checkInResult,
    this.checkOutResult,
    this.getDataResult,
  });

  ///
  HomeState copyWith(HomeState d) {
    return HomeState(
      stateType: d.stateType,
      checkInResult: d.checkInResult,
      checkOutResult: d.checkOutResult,
      getDataResult: d.getDataResult,
    );
  }
}

final class HomeInitial extends HomeState {
  @override
  ApiResult<InOutModel>? get checkInResult => ApiResult()
    ..status = ApiStatus.loading
    ..data = InOutModel();

  @override
  ApiResult<InOutModel>? get checkOutResult => ApiResult()
    ..status = ApiStatus.loading
    ..data = InOutModel();

  @override
  ApiResult<InOutModel>? get getDataResult => ApiResult()
    ..status = ApiStatus.loading
    ..data = InOutModel();
}

enum HomeStateType {
  getData,
  checkin,
  checkout,
}
