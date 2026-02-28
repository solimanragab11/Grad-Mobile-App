import 'package:flutter/material.dart';
import 'package:test_2/core/routes/routes.dart';
import 'package:test_2/core/routes/routing.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Arial",
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.blueGrey[50],
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: Routes.deafScreen,
    );
  }
}
