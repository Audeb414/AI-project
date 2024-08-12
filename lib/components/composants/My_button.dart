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
            color: Colors.black, borderRadius: BorderRadius.circular(30)),
        padding: EdgeInsets.all(25.0),
        margin: const EdgeInsets.symmetric(horizontal: 70),
        child: Center(
          child: Text(
            "connexion",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}
