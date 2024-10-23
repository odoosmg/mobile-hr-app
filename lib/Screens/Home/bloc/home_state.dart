part of 'home_bloc.dart';

class HomeState {
  HomeStateType? stateType;
  ApiResult<InOutModel>? checkInResult;
  ApiResult<InOutModel>? checkOutResult;
  ApiResult<InOutModel>? getDataResult;
  ApiResult<AppPermissionModel>? permissionResult;
  HomeState({
    this.stateType,
    this.checkInResult,
    this.checkOutResult,
    this.getDataResult,
    this.permissionResult,
  });

  ///
  HomeState copyWith(HomeState d) {
    return HomeState(
        stateType: d.stateType,
        checkInResult: d.checkInResult,
        checkOutResult: d.checkOutResult,
        getDataResult: d.getDataResult,
        permissionResult: d.permissionResult);
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

  @override
  ApiResult<AppPermissionModel>? get permissionResult => ApiResult()
    ..status = ApiStatus.loading
    ..data = AppPermissionModel();
}

enum HomeStateType {
  getData,
  checkin,
  checkout,
  appPermission,
}
