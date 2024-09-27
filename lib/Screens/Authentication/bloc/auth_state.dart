part of 'auth_bloc.dart';

class AuthState {
  ApiResult<Session>? signin;
  bool isValidForm;
  AuthStateType? authStateType;

  ApiResult<UserModel>? myProfileResult;
  AuthState({
    this.signin,
    this.isValidForm = false,
    this.authStateType,
    this.myProfileResult,
  });

  AuthState copyWith(AuthState d) {
    return AuthState(
        signin: d.signin,
        isValidForm: d.isValidForm,
        authStateType: d.authStateType,
        myProfileResult: d.myProfileResult);
  }
}

final class AuthInitial extends AuthState {
  @override
  ApiResult<Session>? get signin => ApiResult()..status = ApiStatus.loading;

  @override
  ApiResult<UserModel>? get myProfileResult => ApiResult()
    ..status = ApiStatus.loading
    ..data = UserModel();
}

enum AuthStateType {
  signin,
  signout,
  myProfile,
  validate,
}
