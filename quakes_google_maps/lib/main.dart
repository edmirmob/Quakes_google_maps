import 'package:flutter/material.dart';
import 'package:quakes_google_maps/maps/google_maps/quakes_map.dart';
import 'package:quakes_google_maps/maps/google_maps/show_map.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuakesMap(),
    );
  }
}


