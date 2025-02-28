import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/My_button_auth.dart';
import '../components/My_textfield_auth.dart';

class DatabaseHelper {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // 🔹 Inscription avec Firebase Authentication et ajout dans Firestore
  Future<void> inscrireUtilisateur(
      String name, String email, String password, String phone) async {
    try {
      // 1️⃣ Création de l'utilisateur dans Firebase Authentication
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid; // Récupération du UID FirebaseAuth

      // 2️⃣ Stocker les infos de l'utilisateur dans Firestore
      await _db.collection("users").doc(uid).set({
        'name': name,
        'email': email,
        'phone': phone,
        'createdAt': FieldValue.serverTimestamp(),
      });

      print("✅ Utilisateur inscrit avec succès : UID = $uid");
    } catch (e) {
      print("❌ Erreur lors de l'inscription : $e");
      throw Exception("Erreur lors de l'inscription.");
    }
  }

  // 🔹 Connexion utilisateur (FirebaseAuth)
  Future<bool> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print("✅ Connexion réussie : ${_auth.currentUser?.email}");
      return true;
    } catch (e) {
      print("❌ Erreur de connexion : $e");
      return false;
    }
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
        const SnackBar(content: Text("Veuillez remplir tous les champs.")),
      );
      return;
    }

    if (!isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez entrer un email valide.")),
      );
      return;
    }

    try {
      await DatabaseHelper().inscrireUtilisateur(name, email, password, phone);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Inscription réussie!")),
      );
      Navigator.pushNamed(context, '/dashboard');
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
              const Text(
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
                  const Text(
                    "Vous avez déjà un compte?",
                    style: TextStyle(color: Color.fromARGB(232, 147, 149, 151)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text(
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
