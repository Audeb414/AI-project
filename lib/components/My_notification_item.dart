// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final String profilePicture;
  final String name;
  final String notificationText;

  // ignore: prefer_typing_uninitialized_variables

  const NotificationItem(
      {super.key,
      required this.profilePicture,
      required this.name,
      required this.notificationText});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_typing_uninitialized_variables

    return Scaffold(
      body: Row(
        children: [
          CircleAvatar(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Burnaboy',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text("dont conmplain, dont explain,just believe"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
