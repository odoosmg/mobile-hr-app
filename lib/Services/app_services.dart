import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hrm_employee/Services/database_service.dart';
import 'package:hrm_employee/Services/navigation_service.dart';

final appServices = GetIt.instance;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future setup() async {
  debugPrint("setup is called");

  DatabaseService databaseService = DatabaseService();
  await databaseService.registerAdapter();

  appServices.registerFactory<DatabaseService>(() => databaseService);
}
