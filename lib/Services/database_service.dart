import 'dart:async';
import 'package:hive/hive.dart';

import 'package:hrm_employee/Models/auth/user_model.dart';
import 'package:hrm_employee/Models/auth/app_local.dart';
import 'package:hrm_employee/Models/auth/session.dart';

class DatabaseService {
  late Box<Session>? session;
  late Box<AppLocal>? appLocal;
  late Box<UserModel>? user;

  Future registerAdapter() async {
    Hive.registerAdapter(SessionAdapter());
    Hive.registerAdapter(AppLocalAdapter());
    Hive.registerAdapter(UserModelAdapter());

    ///
    session = await Hive.openBox(Session.boxName);
    appLocal = await Hive.openBox(AppLocal.boxName);
    user = await Hive.openBox(UserModel.boxName);

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
}
