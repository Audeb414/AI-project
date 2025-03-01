import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/My_button_auth.dart';
import '../components/My_textfield_auth.dart';

class connexionPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  connexionPage({super.key});

  Future<void> connexion(BuildContext context) async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez remplir tous les champs.")),
      );
      return;
    }

    try {
      // 🔥 Authentification avec Firebase
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Connexion réussie !")),
      );
      Navigator.pushNamed(context, '/dashboard');
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = "Aucun utilisateur trouvé avec cet e-mail.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Mot de passe incorrect.";
      } else {
        errorMessage =
            "Une erreur s'est produite lors de la connexion. Veuillez réessayer.";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
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

            // Titre
            const Text(
              "CONNEXION",
              style: TextStyle(
                color: Color.fromARGB(232, 147, 149, 151),
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 30),

            // Champ Email
            MyTextField(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
            ),
            const SizedBox(height: 15),

            // Champ Mot de passe
            MyTextField(
              hintText: "Mot de passe",
              obscureText: true,
              controller: _passwordController,
            ),

            const SizedBox(height: 50),

            // Lien d'inscription
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Vous n'avez pas de compte ?",
                  style: TextStyle(color: Color.fromARGB(232, 147, 149, 151)),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text(
                    " S'inscrire",
                    style: TextStyle(
                      color: Color.fromARGB(255, 73, 72, 72),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 70),

            // Bouton de connexion
            MyButton(
              text: "Connexion",
              onTap: () => connexion(context),
            ),
          ],
        ),
      ),
    );
  }
}
