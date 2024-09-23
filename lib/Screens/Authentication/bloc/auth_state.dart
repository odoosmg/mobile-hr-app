part of 'auth_bloc.dart';

class AuthState {
  ApiResult<Session>? signin;
  AuthState({
    this.signin,
  });

  AuthState copyWith(AuthState d) {
    return AuthState(signin: d.signin);
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
