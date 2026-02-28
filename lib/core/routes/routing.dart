import 'package:flutter/material.dart';
import 'package:test_2/feat/deaf_user/screen/deaf_scren.dart';
import 'package:test_2/feat/normal_user/screens/normal_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/deafScreen':
        return MaterialPageRoute(builder: (_) => const DeafScreen());
      case '/normalScreen':
        return MaterialPageRoute(builder: (_) => const NormalScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: Text("No route defined for ${settings.name}"),
              ),
            ),
          ),
        );
    }
  }
}
