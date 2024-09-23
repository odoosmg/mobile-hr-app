part of 'auth_bloc.dart';

class AuthState {
  ApiResult<Session>? signin;
  bool isValidForm;
  BlocEventType blocEventType;
  AuthState({
    this.signin,
    this.isValidForm = false,
    this.blocEventType = BlocEventType.others,
  });

  AuthState copyWith(AuthState d) {
    return AuthState(
        signin: d.signin,
        isValidForm: d.isValidForm,
        blocEventType: d.blocEventType);
  }
}

final class AuthInitial extends AuthState {
  // @override
  // set signin(ApiResult<Session>? _signin) {
  //   // TODO: implement signin
  //   _signin = ApiResult()..status = ApiStatus.loading;
  // }

  @override
  // TODO: implement signin
  ApiResult<Session>? get signin => ApiResult()..status = ApiStatus.loading;
}
