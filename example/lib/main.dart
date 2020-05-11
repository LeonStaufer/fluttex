import 'package:flutter/material.dart';
import 'package:fluttex_example/performance.dart';
import 'package:fluttex_example/start_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/start": (context) => StartScreen(),
        "/performance": (context) => PerformanceScreen(),
      },
      initialRoute: "/start",
    );
  }
}
