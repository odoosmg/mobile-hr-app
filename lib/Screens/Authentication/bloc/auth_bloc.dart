import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/api/api_result.dart';
import 'package:hrm_employee/Models/auth/session.dart';
import 'package:hrm_employee/Repository/auth_repository.dart';
import 'package:hrm_employee/Services/app_services.dart';
import 'package:hrm_employee/Services/database_service.dart';
import 'package:hrm_employee/utlis/app_trans.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AuthSignIn>(_authSingIn);
    on<AuthValidate>(_validateForm);
  }

  void _authSingIn(AuthSignIn event, Emitter<AuthState> emit) async {
    state.signin!.status = ApiStatus.loading;
    state.blocEventType = BlocEventType.requestApi;
    emit(state.copyWith(state));

    await authRepository
        .login(event.username.trim(), event.password)
        .then((value) {
      if (value.isSuccess) {
        /// update db local
        AppServices.instance<DatabaseService>().putSession(value.data!);
      } else {
        if (value.statuscode == ApiStatus.connectionError.statusCode) {
          value.errorMessage = AppTrans.t.connectionErrMsg;
        } else {
          value.errorMessage = AppTrans.t.loginFailedMsg;
        }
      }

      ///
      state.signin = value;
      emit(state.copyWith(state));
    });
  }

  /// Validate
  void _validateForm(AuthValidate event, Emitter<AuthState> emit) async {
    bool isValid = false;

    state.blocEventType = BlocEventType.validateForm;

    ///
    if (event.username.isNotEmpty && event.password.isNotEmpty) {
      isValid = true;
    }

    state.isValidForm = isValid;
    emit(state.copyWith(state));
  }

  // @override
  // void onChange(Change<AuthState> change) {
  //   // TODO: implement onChange
  //   print("onchange ====== $change");
  //   super.onChange(change);
  // }
}
