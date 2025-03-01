// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:eneo_ai_project/pages/dashboard.dart';
import 'package:flutter/material.dart';

class Parametre extends StatefulWidget {
  const Parametre({super.key});

  @override
  State<Parametre> createState() => _ParametreState();
}

class _ParametreState extends State<Parametre> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {'/dashboard': (context) => Dashboard()},
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 140, 198, 64),
          elevation: 0,
          /*flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 65, 123, 170),
                Color.fromARGB(255, 53, 245, 59),
              ], transform: GradientRotation(10)),
            ),
          ),*/
          leading: Row(
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
                width: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 18, 21, 56),
                ),
                height: 40,
                width: 40,
                child: Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 15, 88, 148),
                ),
              ),
              SizedBox(
                width: 25,
              ),
              Column(
                children: [
                  Text(
                    "User Name",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "id:38387372",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 35,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                color: const Color.fromARGB(255, 233, 227, 227),
                child: Column(
                  children: <Widget>[
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 230, 235, 238),
                          child: Icon(
                            Icons.add_call,
                            color: Color.fromARGB(176, 156, 148, 148),
                          ),
                        ),
                        title: Text('change phone number'),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {},
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 180, 189, 197),
                          child: Icon(
                            Icons.mark_email_read_sharp,
                            color: Color.fromARGB(255, 7, 50, 116),
                          ),
                        ),
                        title: Text('Change email'),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {},
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 230, 233, 236),
                          child: Icon(Icons.perm_device_info_rounded),
                        ),
                        title: Text('About us'),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {},
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 36, 131, 68),
                          child: Icon(Icons.remove_red_eye_outlined),
                        ),
                        title: Text('confidentialiter'),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {},
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 112, 15, 131),
                          child: Icon(
                            Icons.verified_user_outlined,
                            color: Color.fromARGB(251, 0, 0, 0),
                          ),
                        ),
                        title: Text('Condition utilisation'),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {},
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 180, 243, 33),
                          child: Icon(Icons.my_library_add_outlined),
                        ),
                        title: Text('Changer de theme'),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {},
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 145, 120, 12),
                          child: Icon(Icons.output_rounded),
                        ),
                        title: Text('Se deconnecter'),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {},
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 89, 109, 126),
                          child: Icon(Icons.contact_page_outlined),
                        ),
                        title: Text('change phone number'),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Notification Settings',
                style: TextStyle(fontSize: 25, color: Colors.indigo),
              ),
              SwitchListTile(
                activeColor: Colors.blue,
                contentPadding: const EdgeInsets.all(0),
                value: true,
                title: Text('Receive Notification'),
                onChanged: (val) {},
              ),
              SwitchListTile(
                activeColor: Colors.blue,
                contentPadding: const EdgeInsets.all(0),
                value: true,
                title: Text('Receive newsletter'),
                onChanged: null,
              ),
              SwitchListTile(
                activeColor: Colors.blue,
                contentPadding: const EdgeInsets.all(0),
                value: false,
                title: Text('Automatic updates'),
                onChanged: (val) {},
              ),
              SwitchListTile(
                activeColor: Colors.blue,
                contentPadding: const EdgeInsets.all(0),
                value: false,
                title: Text('Receive offer notification'),
                onChanged: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
