import 'package:flutter/material.dart';
import 'package:real_time_tracking_project/tracking_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Real Time Vehicle Tracking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TrackingScreen(),
    );
  }
}
