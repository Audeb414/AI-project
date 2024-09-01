// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BlurredBackgroundIcon extends StatelessWidget {
  const BlurredBackgroundIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/help.png'), // Replace with your icon
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
