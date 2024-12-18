import 'package:firebase_core/firebase_core.dart';
import 'package:hrm_employee/Firebase/Dev/firebase_options.dart';
// import 'package:hrm_employee/Firebase/Prod/firebase_options.dart';

///***
/// Generate firebase and copy to eviroment
/// Noted*: current only use dev env
/// */

class FirebaseInit {
  static Future firebaseOptions() async {
    const String env = String.fromEnvironment("env");

    switch (env) {
      /// Prod
      case 'prod':
        return await Firebase.initializeApp(
            options: FirebaseOptionsDev.currentPlatform);

      /// Dev
      default:
        return await Firebase.initializeApp(
            options: FirebaseOptionsDev.currentPlatform);
    }
  }
}
