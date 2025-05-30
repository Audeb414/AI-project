// ignore_for_file: camel_case_types, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_import

import 'package:eneo_ai_project/pages/dashboard.dart';
import 'package:flutter/material.dart';

class notification extends StatefulWidget {
  const notification({super.key});

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {
  List notifications = [
    {
      'image': 'assets/profile.png',
      'title': 'AI Eneo',
      'message': '@user12345 see notifications...',
      'time': '10 mins ago',
    },
    {
      'image': 'assets/profile.png',
      'title': 'AI Eneo',
      'message': '@user12345 see notifications...',
      'time': '10 mins ago',
    },
    {
      'image': 'assets/profile.png',
      'title': 'AI Eneo',
      'message': '@user12345 see notifications...',
      'time': '10 mins ago',
    },
    {
      'image': 'assets/profile.png',
      'title': 'AI Eneo',
      'message': '@user12345 see notifications...',
      'time': '10 mins ago',
    },
    {
      'image': 'assets/profile.png',
      'title': 'AI Eneo',
      'message': '@user12345 see notifications...',
      'time': '10 mins ago',
    },
    {
      'image': 'assets/profile.png',
      'title': 'AI Eneo',
      'message': '@user12345 see notifications...',
      'time': '10 mins ago',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {'/dashboard': (context) => Dashboard()},
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.chevron_left, color: Colors.black),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Dashboard()),
                        );
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      "assets/images/eneo.jpeg",
                      height: 50,
                    ),
                    SizedBox(
                      width: 150,
                    ),
                    Icon(Icons.notification_add_outlined),
                  ],
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search_rounded),
                      hintText: "search...",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200),
                    child: Text(
                      "JOBSITE",
                      style: TextStyle(color: Colors.black),
                    )),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200),
                    child: Text(
                      "STAGE",
                      style: TextStyle(color: Colors.black),
                    ))
              ]),
              Expanded(
                child: ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notif = notifications[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(notif['image']),
                      ),
                      title: Text(notif['title']),
                      subtitle: Text('${notif['message']} -${notif['time']}'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
