// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.text,
    required this.onTap,
  });
  final void Function()? onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 140, 198, 64),
            borderRadius: BorderRadius.circular(30)),
        padding: EdgeInsets.all(25.0),
        margin: const EdgeInsets.symmetric(horizontal: 70),
        child: Center(
          child: Text(
            "connexion",
            style: TextStyle(
                color: const Color.fromARGB(255, 139, 132, 132),
                fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}
