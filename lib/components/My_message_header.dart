// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class HeatherSection extends StatefulWidget {
  const HeatherSection({super.key});

  @override
  State<HeatherSection> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HeatherSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      color: const Color.fromARGB(255, 27, 118, 187),
      height: 60,
      padding: const EdgeInsets.only(right: 5),
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/dashboard');
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Image.asset(
              'assets/images/eneo.jpeg',
            ),
            const SizedBox(
              width: 5,
            ),
            const Column(
              crossAxisAlignment:
                  CrossAxisAlignment.end, //decaler vers la gauche
              children: [
                Padding(padding: EdgeInsets.only(top: 10)),
                Text(
                  'IA ENEO',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'writing...',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color.fromARGB(255, 140, 198, 64),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
