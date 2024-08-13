// ignore_for_file: prefer_const_constructors, unused_import

import 'package:eneo_ai_project/pages/home_page.dart';
import 'package:eneo_ai_project/pages/notification_page.dart';
import 'package:eneo_ai_project/pages/welcome_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/home': (contetx) => HomePage(),
        '/notification': (contetx) => notification(),
      },
    );
  }
}
