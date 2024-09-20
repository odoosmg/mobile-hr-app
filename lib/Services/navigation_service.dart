import 'package:flutter/material.dart';

/// To get current context globally

class NavigatorService {
  late GlobalKey<NavigatorState> navigationKey;

  static NavigatorService ns = NavigatorService();

  NavigatorService() {
    navigationKey = GlobalKey<NavigatorState>();
  }

  BuildContext get getCurrentContext => navigationKey.currentContext!;

  // Future<dynamic> pushReplacementNamed(
  //   String routeName, {
  //   Object? arguments,
  //   Object? result,
  // }) {
  //   return navigationKey.currentState!.pushReplacementNamed(
  //     routeName,
  //     arguments: arguments,
  //     result: result,
  //   );
  // }

  // Future<dynamic> pushNamed(
  //   String routeName, {
  //   Object? arguments,
  // }) {
  //   return navigationKey.currentState!
  //       .pushNamed(routeName, arguments: arguments);
  // }

  // Future<dynamic> push(MaterialPageRoute route) {
  //   return navigationKey.currentState!.push(route);
  // }

  // back() {
  //   return navigationKey.currentState!.pop();
  // }
}
