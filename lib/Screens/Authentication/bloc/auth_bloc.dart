import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/Repository/auth_repository.dart';
import 'package:hrm_employee/Services/app_services.dart';
import 'package:hrm_employee/Services/database_service.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AuthSignIn>(_authSingIn);
  }

  void _authSingIn(AuthSignIn event, Emitter<AuthState> emit) async {
    // return;
    await authRepository.login("api_user", "123").then((value) {
      if (value.isSuccess) {
        AppServices.instance<DatabaseService>().putSession(value.data!);
        print("aaa === ${AppServices.instance<DatabaseService>().getToken}");
      }
    });
  }
}
