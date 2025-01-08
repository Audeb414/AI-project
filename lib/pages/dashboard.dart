import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        backgroundColor: Color.fromARGB(255, 140, 198, 64),
        elevation: 0,
        // ignore: prefer_const_constructors
        leading: Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            // ignore: prefer_const_constructors
            SizedBox(width: 5),
            const Text(
              'IA ENEO',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/notification');
            },
            child:
                const Icon(Icons.notifications, size: 20, color: Colors.white),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/parameter');
            },
            child: const Icon(Icons.settings, size: 20, color: Colors.white),
          ),
          // ignore: prefer_const_constructors
          SizedBox(width: 5),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search_rounded),
                  hintText: "rechercher une application...",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/chat');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade200,
                      ),
                      padding: const EdgeInsets.all(16),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Emex',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                      indent: 70,
                      endIndent: 70,
                      thickness: 1.5,
                      color: Color.fromARGB(255, 140, 198, 64)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/chat');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade200,
                      ),
                      padding: const EdgeInsets.all(16),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Jobsite',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    indent: 70,
                    endIndent: 70,
                    thickness: 1.5,
                    color: Color.fromARGB(255, 140, 198, 64),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/chat');
                      Navigator.pushNamed(context, '/parametre');
                      Navigator.pushNamed(context, '/notification_page');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey),
                      padding: const EdgeInsets.all(16),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Stage internship',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    indent: 70,
                    endIndent: 70,
                    thickness: 1.5,
                    color: Color.fromARGB(255, 140, 198, 64),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
