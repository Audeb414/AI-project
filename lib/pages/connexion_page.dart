// ignore_for_file: unnecessary_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, unused_field, duplicate_import

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../components/My_button_auth.dart';
import '../components/My_textfield_auth.dart';

class connexionPage extends StatelessWidget {
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _matriculeController = TextEditingController();

  connexionPage({super.key});
  void inscription() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 140, 198, 64),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),

            //TEXTE INSCRIPTION
            Text(
              "CONNEXION",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 30),
            // texte numero

            MyTextField(
              hintText: "Numero",
              obscureText: false,
              controller: _numeroController,
            ),
            const SizedBox(height: 15),

            //Texte matricule

            MyTextField(
              hintText: "matricule",
              obscureText: false,
              controller: _matriculeController,
            ),

            const SizedBox(height: 50),
            //se connecter
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "vous n'avez pas de compte?",
                  style: TextStyle(color: Colors.white),
                ),
                GestureDetector(
                   onTap: () {
                      Navigator.pushNamed(context, '/register');
                    },
                  child: Text("        s'incrire",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    )),)
              ],
            ),
            const SizedBox(height: 70),

            //button
            MyButton(
              text: "connexion",
              onTap: () {
                      Navigator.pushNamed(context, '/home');
                    },
            )
          ],
        ),
      ),
    );
  }
}
