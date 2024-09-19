import 'package:flutter/material.dart';

/// use this for use route state anywhere
/// example : when expired from api,we logout. but we cannot access current state

class NavigationService {
  late GlobalKey<NavigatorState> navigationKey;

  static NavigationService instance = NavigationService();

  NavigationService() {
    navigationKey = GlobalKey<NavigatorState>();
  }

  Future<dynamic> pushReplacementNamed(
    String routeName, {
    Object? arguments,
    Object? result,
  }) {
    return navigationKey.currentState!.pushReplacementNamed(
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  Future<dynamic> pushNamed(
    String routeName, {
    Object? arguments,
  }) {
    return navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> push(MaterialPageRoute route) {
    return navigationKey.currentState!.push(route);
  }

  back() {
    return navigationKey.currentState!.pop();
  }
}
