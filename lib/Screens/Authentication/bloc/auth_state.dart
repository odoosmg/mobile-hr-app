part of 'auth_bloc.dart';

class AuthState {
  ApiResult<Session>? signin;
  bool isValidForm;
  BlocEventType blocEventType;
  AuthStateType? authStateType;
  AuthState({
    this.signin,
    this.isValidForm = false,
    this.blocEventType = BlocEventType.others,
    this.authStateType,
  });

  AuthState copyWith(AuthState d) {
    return AuthState(
      signin: d.signin,
      isValidForm: d.isValidForm,
      blocEventType: d.blocEventType,
      authStateType: d.authStateType,
    );
  }
}

final class AuthInitial extends AuthState {
  @override
  ApiResult<Session>? get signin => ApiResult()..status = ApiStatus.loading;
}

enum AuthStateType {
  signin,
  signout,
  myProfile,
}
