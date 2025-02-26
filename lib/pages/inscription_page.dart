import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../components/My_button_auth.dart';
import '../components/My_textfield_auth.dart';

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._init();

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    // Stocker la base sur le Bureau
    String path = "/home/aude/Bureau/ma_base.db";
    print("📂 Chemin de la base de données : $path");

    return await databaseFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          print("📌 Création de la table 'users'...");
          await _createTables(db);
        },
        onConfigure: (db) async {
          await db.execute("PRAGMA foreign_keys = ON;");
        },
        onOpen: (db) async {
          print("✅ Base de données ouverte.");

          // Vérification des tables existantes
          var tables = await db
              .rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
          print("📋 Tables existantes après ouverture : $tables");

          // Création de la table si elle n'existe pas encore
          if (!tables.any((table) => table['name'] == 'users')) {
            print("⚠️ La table 'users' n'existe pas, création en cours...");
            await _createTables(db);
          }
        },
      ),
    );
  }

  Future<void> _createTables(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        password TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        phone TEXT NOT NULL
      )
    ''');
    print("✅ Table 'users' créée ou déjà existante.");
  }

  Future<int> insertUser(
      String name, String password, String email, String phone) async {
    final db = await database;

    try {
      int id = await db.insert('users',
          {'name': name, 'password': password, 'email': email, 'phone': phone});
      print("👤 Utilisateur ajouté avec ID : $id");
      return id;
    } catch (e) {
      print("❌ Erreur lors de l'insertion : $e");
      throw Exception("Erreur lors de l'insertion de l'utilisateur.");
    }
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.query('users');
  }

  // ✅ Ajout de la fonction pour vérifier l'email et le mot de passe
  Future<bool> loginUser(String email, String password) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    return result.isNotEmpty; // Retourne vrai si l'utilisateur existe
  }
}

class InscriptionPage extends StatelessWidget {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();

  InscriptionPage({super.key});

  bool isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(email);
  }

  void inscription(BuildContext context) async {
    String name = _nomController.text.trim();
    String password = _passwordController.text.trim();
    String email = _emailController.text.trim();
    String phone = _telephoneController.text.trim();

    if (name.isEmpty || password.isEmpty || email.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Veuillez remplir tous les champs.")),
      );
      return;
    }

    if (!isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Veuillez entrer un email valide.")),
      );
      return;
    }

    try {
      await DatabaseHelper.instance.insertUser(name, password, email, phone);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Inscription réussie!")),
      );
      Navigator.pushNamed(context, '/dashboard');

      List<Map<String, dynamic>> users =
          await DatabaseHelper.instance.getUsers();
      print("✅ Utilisateurs enregistrés : $users");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Erreur lors de l'inscription : ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
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
                obscureText: true,
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
      ),
    );
  }
}
