import 'package:flutter/material.dart';
import 'package:prayer_times/Prayer.dart';
import 'package:prayer_times/nav.dart';

void main() {
  runApp(MaterialApp(
    title: 'Prayer Times Ariq',
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prayer Times',
      debugShowCheckedModeBanner: false,
      home: Nav(),
    );
  }
}