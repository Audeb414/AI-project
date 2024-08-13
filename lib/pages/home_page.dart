import 'package:eneo_ai_project/components/My_message_animation.dart';
import 'package:eneo_ai_project/components/My_message_header.dart';
import 'package:eneo_ai_project/components/My_message_input.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                const HeatherSection(),
                const SizedBox(
                  height: 50,
                ),
                DelayedAnimation(
                  delay: 3000,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(right: 20, left: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 27, 118, 187),
                    ),
                    child: DelayedAnimation(
                      delay: 2500,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/images/eneo.jpeg'),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "The following line ensures that the Material Icons font is included with your application, so that you can use the icons in the material ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 370,
                ),
                //const Spacer(),
                const SearchSection(),
              ],
            ),
          ],
        ),
      ), //scroller du contenu
    ); //home-contenu
  }
}
