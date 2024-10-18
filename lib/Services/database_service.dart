import 'dart:async';
import 'package:hive/hive.dart';

import 'package:hrm_employee/Models/auth/user_model.dart';
import 'package:hrm_employee/Models/auth/app_local.dart';
import 'package:hrm_employee/Models/auth/session.dart';
import 'package:hrm_employee/Models/form/select_form_model.dart';
import 'package:hrm_employee/Screens/components/select/SelectForm/ui/select_form.dart';

class DatabaseService {
  late Box<Session>? session;
  late Box<AppLocal>? appLocal;
  late Box<UserModel>? user;
  late Box<SelectFormModel>? formData;

  Future registerAdapter() async {
    Hive.registerAdapter(SessionAdapter());
    Hive.registerAdapter(AppLocalAdapter());
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(SelectFormModelAdapter());

    ///
    session = await Hive.openBox(Session.boxName);
    appLocal = await Hive.openBox(AppLocal.boxName);
    user = await Hive.openBox(UserModel.boxName);
    formData = await Hive.openBox(SelectFormModel.boxName);

    /// init default value, if null.
    if (getAppLocal == null) {
      putAppLocal(AppLocal()..isOnboardClose = false);
    }
  }

  /// clear data login Data
  /// data that use in Login
  Future clearSession() async {
    await session?.clear();
  }

  ///*****************
  ///     Session
  ///*****************/

  String get getToken => session?.get(Session.boxName)?.accessToken ?? '';

  /// get
  String get getRefreshToken =>
      session?.get(Session.boxName)?.refreshToken ?? '';

  /// put
  Future<void> putSession(Session data) async =>
      await session?.put(Session.boxName, data);

  Session? get getSession => session?.get(Session.boxName);

  ///*****************
  ///     AppLocal
  ///*****************/

  /// get
  AppLocal? get getAppLocal => appLocal?.get(AppLocal.boxName);

  /// put
  void putAppLocal(AppLocal data) => appLocal?.put(AppLocal.boxName, data);

  ///*****************
  ///     Form Data
  ///*****************/

  SelectFormModel? get getFormData => formData?.get(SelectFormModel.boxName);
  void putFormData(SelectFormModel data) =>
      formData?.put(SelectFormModel.boxName, data);

  List<int>? get formDataCompanyIds =>
      (getFormData!.companySelected ?? []).map((e) => e.id!).toList();
}
