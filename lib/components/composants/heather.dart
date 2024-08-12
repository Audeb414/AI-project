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
      color: const Color.fromARGB(255, 27, 118, 187),
      height: 70,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 25,
        right: 25,
      ),
      child: Row(
        children: [
          const Padding(padding: EdgeInsets.all(5)),
          Container(
            height: 50,
            width: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/eneo-logo.png'),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end, //decaler vers la gauche
            children: [
              Text(
                'IA ENEO',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ), //créer un conteneur avec une taille donnée
              Text(
                'writing...',
                style: TextStyle(
                  fontSize: 19,
                  color: Color.fromARGB(255, 140, 198, 64),
                ),
              ),
            ],
          ),
          const Spacer(),
          const Row(
            children: [
              Icon(
                Icons.notifications_active_outlined,
                size: 35,
                color: Colors.white,
              ),
              Icon(
                Icons.settings,
                size: 35,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/*class HeatherSection extends StatelessWidget {
  const HeatherSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      
         
         
    );
  }
}*/
