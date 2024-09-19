import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hrm_employee/Services/database_service.dart';
import 'package:hrm_employee/Services/navigation_service.dart';

class AppServices {
  static final instance = GetIt.instance;

  static Future setup() async {
    DatabaseService databaseService = DatabaseService();
    await databaseService.registerAdapter();

    instance.registerFactory<DatabaseService>(() => databaseService);
  }
}
