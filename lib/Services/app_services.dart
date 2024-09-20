import 'package:get_it/get_it.dart';
import 'package:hrm_employee/Services/database_service.dart';
import 'package:hrm_employee/Services/navigation_service.dart';

class AppServices {
  static final instance = GetIt.instance;

  static Future setup() async {
    DatabaseService databaseService = DatabaseService();
    NavigatorService navigatorService = NavigatorService();

    /// Register adapter
    await databaseService.registerAdapter();

    instance.registerFactory<DatabaseService>(() => databaseService);
    instance.registerFactory<NavigatorService>(() => navigatorService);
  }
}
