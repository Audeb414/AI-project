/* ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import, duplicate_import

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../components/My_button_auth.dart';
import '../components/My_textfield_auth.dart';

class InscriptionPage extends StatelessWidget {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();

  InscriptionPage({super.key});
  void inscription() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),

            //TEXTE D'INSCRIPTION
            Text(
              "INSCRIPTION",
              style: TextStyle(
                color: Color.fromARGB(232, 147, 149, 151),
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 30),
            // texte name

            MyTextField(
              hintText: "Nom",
              obscureText: false,
              controller: _nomController,
            ),
            const SizedBox(height: 15),

            //Texte email

            MyTextField(
              hintText: "email",
              obscureText: false,
              controller: _emailController,
            ),

            const SizedBox(height: 15),

            //Texte telephone
            MyTextField(
              hintText: "Telephone",
              obscureText: false,
              controller: _telephoneController,
            ),

            const SizedBox(height: 50),
            //se connecter
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "vous a deja un compte?",
                  style: TextStyle(color: Color.fromARGB(232, 147, 149, 151)),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text("         se connecter",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 77, 72, 72),
                          fontWeight: FontWeight.w900,
                        ))),
              ],
            ),
            const SizedBox(height: 70),

            //button
            MyButton(
              text: " inscription",
              onTap: () {
                Navigator.pushNamed(context, '/dashboard');
              },
            )
          ],
        ),
      ),
    );
  }
}*/

/* ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import, duplicate_import

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../components/My_button_auth.dart';
import '../components/My_textfield_auth.dart';

class InscriptionPage extends StatelessWidget {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();

  InscriptionPage({super.key});
  void inscription() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),

            //TEXTE D'INSCRIPTION
            Text(
              "INSCRIPTION",
              style: TextStyle(
                color: Color.fromARGB(232, 147, 149, 151),
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 30),
            // texte name

            MyTextField(
              hintText: "Nom",
              obscureText: false,
              controller: _nomController,
            ),
            const SizedBox(height: 15),

            //Texte email

            MyTextField(
              hintText: "email",
              obscureText: false,
              controller: _emailController,
            ),

            const SizedBox(height: 15),

            //Texte telephone
            MyTextField(
              hintText: "Telephone",
              obscureText: false,
              controller: _telephoneController,
            ),

            const SizedBox(height: 50),
            //se connecter
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "vous a deja un compte?",
                  style: TextStyle(color: Color.fromARGB(232, 147, 149, 151)),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text("         se connecter",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 77, 72, 72),
                          fontWeight: FontWeight.w900,
                        ))),
              ],
            ),
            const SizedBox(height: 70),

            //button
            MyButton(
              text: " inscription",
              onTap: () {
                Navigator.pushNamed(context, '/dashboard');
              },
            )
          ],
        ),
      ),
    );
  }
}*/
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import, duplicate_import

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../components/My_button_auth.dart';
import '../components/My_textfield_auth.dart';

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._init();

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('users.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        password TEXT NOT NULL,
        email TEXT NOT NULL,
        phone TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertUser(
      String name, String password, String email, String phone) async {
    final db = await instance.database;
    await db.insert('users',
        {'name': name, 'password': password, 'email': email, 'phone': phone});
  }
}

class InscriptionPage extends StatelessWidget {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();

  InscriptionPage({super.key});

  void inscription(BuildContext context) async {
    String name = _nomController.text;
    String password = _passwordController.text;
    String email = _emailController.text;
    String phone = _telephoneController.text;

    if (name.isNotEmpty &&
        email.isNotEmpty &&
        phone.isNotEmpty &&
        password.isNotEmpty) {
      await DatabaseHelper.instance.insertUser(name, email, phone, password);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Inscription réussie!")),
      );
      Navigator.pushNamed(context, '/dashboard');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Veuillez remplir tous les champs.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Text(
              "INSCRIPTION",
              style: TextStyle(
                color: Color.fromARGB(232, 147, 149, 151),
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 30),
            MyTextField(
              hintText: "Nom",
              obscureText: false,
              controller: _nomController,
            ),
            const SizedBox(height: 15),
            MyTextField(
              hintText: "Mot de passe",
              obscureText: false,
              controller: _passwordController,
            ),
            const SizedBox(height: 15),
            MyTextField(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
            ),
            const SizedBox(height: 15),
            MyTextField(
              hintText: "Téléphone",
              obscureText: false,
              controller: _telephoneController,
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Vous avez déjà un compte?",
                  style: TextStyle(color: Color.fromARGB(232, 147, 149, 151)),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    " Se connecter",
                    style: TextStyle(
                      color: Color.fromARGB(255, 77, 72, 72),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 70),
            MyButton(
              text: "Inscription",
              onTap: () => inscription(context),
            ),
          ],
        ),
      ),
    );
  }
}
