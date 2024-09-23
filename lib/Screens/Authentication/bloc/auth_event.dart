part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthSignIn extends AuthEvent {
  final String username;
  final String password;
  AuthSignIn({
    required this.username,
    required this.password,
  });
}

class AuthValidate extends AuthEvent {
  final String username;
  final String password;
  AuthValidate({
    required this.username,
    required this.password,
  });
}
