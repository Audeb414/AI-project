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
      height: 50,
      padding: const EdgeInsets.only(right: 5),
      child: Row(
        children: [
          //const Padding(padding: EdgeInsets.all(5)),
          Image.asset(
            'assets/images/eneo.jpeg',
          ),
          /* Container(
            height: 70,
            width: 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/eneo-logo.png'),
              ),
            ),
          ),*/
          const SizedBox(
            width: 5,
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end, //decaler vers la gauche
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
          const Spacer(),

          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/notification');
            },
            child: const Icon(
              Icons.notifications,
              size: 20,
              color: Colors.white,
            ),
          ),
          const Icon(
            Icons.settings,
            size: 20,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
