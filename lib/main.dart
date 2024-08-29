// ignore_for_file: prefer_const_constructors, unused_import

import 'package:eneo_ai_project/pages/chatPage.dart';
import 'package:eneo_ai_project/pages/connexion_page.dart';
import 'package:eneo_ai_project/pages/dashboard.dart';
import 'package:eneo_ai_project/pages/notification_page.dart';
import 'package:eneo_ai_project/pages/parametre%20.dart';
import 'package:eneo_ai_project/pages/welcome_page.dart';
import 'package:flutter/material.dart';

import 'pages/inscription_page.dart';

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
      home: WelcomePage(),
      routes: {
        '/chat': (context) => chatPage(),
        '/notification': (context) => notification(),
        '/login': (context) => connexionPage(),
        '/register': (context) => InscriptionPage(),
        '/dashboard': (context) => Dashboard(),
        '/parameter': (context) => Parametre(),
      },
    );
  }
}
