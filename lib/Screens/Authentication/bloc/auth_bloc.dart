import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/GlobalComponents/dialog/custom_dialog.dart';
import 'package:hrm_employee/GlobalComponents/dialog/custom_loading.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/api/api_result.dart';
import 'package:hrm_employee/Models/auth/session.dart';
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
    state.signin!.status = ApiStatus.loading;
    emit(state.copyWith(state));

    await authRepository
        .login(event.username.trim(), event.password)
        .then((value) {
      if (value.isSuccess) {
        AppServices.instance<DatabaseService>().putSession(value.data!);
      }

      ///
      state.signin = value;
      emit(state.copyWith(state));
    });
  }
}
