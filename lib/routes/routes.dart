// routes/routes.dart
import 'package:flutter/material.dart';
import '../pages/auth/login_page.dart';
import '../pages/onboarding/onboarding_page.dart';

class Routes {
  static final List<Map<String, dynamic>> _routeDefinitions = [
    {'name': '/login', 'widget': const LoginPage()},
    {'name': '/onboarding', 'widget': const OnboardingPage()},
  ];

  static Map<String, Widget Function(BuildContext)> routes = {
    for (var route in _routeDefinitions)
      route['name']: (context) => route['widget'] as Widget,
  };
}
