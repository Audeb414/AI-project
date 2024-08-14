// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import, duplicate_import

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
      backgroundColor: Color.fromARGB(255, 140, 198, 64),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),

            //TEXTE D'INSCRIPTION
            Text(
              "INSCRIPTION",
              style: TextStyle(
                color: Colors.white,
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
                  style: TextStyle(color: Colors.white),
                ),
                GestureDetector(
                onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                child:Text("         se connecter",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ))
                ),
              ],
            ),
            const SizedBox(height: 70),

            //button
            MyButton(
              text: " inscription",
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
