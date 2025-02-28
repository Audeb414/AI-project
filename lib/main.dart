// ignore_for_file: prefer_const_constructors, unused_import
import 'dart:io';
import 'package:eneo_ai_project/pages/chatPage.dart';
import 'package:eneo_ai_project/pages/connexion_page.dart';
import 'package:eneo_ai_project/pages/dashboard.dart';
import 'package:eneo_ai_project/pages/notification_page.dart';
import 'package:eneo_ai_project/pages/parametre%20.dart';
import 'package:eneo_ai_project/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'pages/inscription_page.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Nécessaire pour exécuter du code asynchrone dans `main`

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // Assure-toi que ce fichier existe
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingScreen(),
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
