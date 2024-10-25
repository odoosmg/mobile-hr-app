import 'dart:async';
import 'package:hive/hive.dart';
import 'package:hrm_employee/Models/PublicHoliday/public_holiday_model.dart';
import 'package:hrm_employee/Models/auth/app_permission_model.dart';

import 'package:hrm_employee/Models/auth/user_model.dart';
import 'package:hrm_employee/Models/auth/app_local.dart';
import 'package:hrm_employee/Models/auth/session.dart';
import 'package:hrm_employee/Models/form/select_form_model.dart';

class DatabaseService {
  late Box<Session>? session;
  late Box<AppLocal>? appLocal;
  late Box<UserModel>? user;
  late Box<SelectFormModel>? formData;
  late Box<AppPermissionModel>? permission;
  late Box<PublicHolidayModel>? publicHoliday;

  Future registerAdapter() async {
    Hive.registerAdapter(SessionAdapter());
    Hive.registerAdapter(AppLocalAdapter());
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(SelectFormModelAdapter());
    Hive.registerAdapter(AppPermissionModelAdapter());
    Hive.registerAdapter(PublicHolidayModelAdapter());

    ///
    session = await Hive.openBox(Session.boxName);
    appLocal = await Hive.openBox(AppLocal.boxName);
    user = await Hive.openBox(UserModel.boxName);
    formData = await Hive.openBox(SelectFormModel.boxName);
    permission = await Hive.openBox(AppPermissionModel.boxName);
    publicHoliday = await Hive.openBox(PublicHolidayModel.boxName);

    /// init default value, if null.
    if (getAppLocal == null) {
      putAppLocal(AppLocal()..isOnboardClose = false);
    }
  }

  /// clear data login Data
  /// data that use in Login
  Future clearSession() async {
    clearCompanyList();
    await session?.clear();
    await publicHoliday?.clear();
  }

  void clearCompanyList() {
    SelectFormModel d = getFormData!;
    d.companyList = [];
    d.companySelected = [];
    putFormData(d);
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

  List<int>? get getCompanyIds =>
      (getFormData!.companySelected ?? []).map((e) => e.id!).toList();

  ///*****************
  ///     Permissoin
  ///*****************/

  ///** Note. [null] set as failed */

  /// get
  AppPermissionModel? get getPermissoin =>
      permission?.get(AppPermissionModel.boxName);

  /// put
  void putPermission(AppPermissionModel data) =>
      permission?.put(AppPermissionModel.boxName, data);

  /// Get App Permissoin Success
  bool get isGetPermissionSucces => getPermissoin!.isRetrieveSuccess!;

  ///***********************
  ///     Public Holiday
  ///***********************/

  /// Get
  PublicHolidayModel? get getPublicHoliday =>
      publicHoliday?.get(PublicHolidayModel.boxName);

  /// Put
  void putPublicHoliday(PublicHolidayModel data) =>
      publicHoliday?.put(PublicHolidayModel.boxName, data);
}
