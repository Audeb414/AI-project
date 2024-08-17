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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 102, 151, 38),
                    Color.fromARGB(255, 91, 156, 6),
                    Color.fromARGB(255, 102, 151, 38),
                    Color.fromARGB(255, 91, 156, 6),
                  ]),
            ),
            child: Row(
              children: [
                const Text(
                  'IA ENEO',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/notification');
                  },
                  child: const Icon(Icons.notifications,
                      size: 20, color: Colors.white),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/parameter');
                  },
                  child:
                      const Icon(Icons.settings, size: 20, color: Colors.white),
                ),
              ],
            ),
          ),
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
                    Navigator.pushNamed(context, '/home');
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
                    Navigator.pushNamed(context, '/home');
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
                    Navigator.pushNamed(context, '/home');
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
    );
  }
}
