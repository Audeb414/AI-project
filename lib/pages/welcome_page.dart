// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
      child: Scaffold(
        backgroundColor: Color.fromARGB(0, 140, 198, 64),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Stack(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //here we have the logo section and it's properties
                //so i started here by creating a column you know the
                //history with the children[] no need to recall
                //then after i inserted the image using the
                //Image.asset("path of the image", height: 240),
                //and i gave the height of 240 pixel as ytou can see
                //then i wrapped my column in a center and my image in a padding
                Positioned(
                  top: 10,
                  left: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox.fromSize(
                      child: Image.asset(
                        "assets/images/eneo.jpeg",
                        height: 70,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: 280,
                    width: 280,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 20, 105, 158),
                        width: 5,
                      ),
                      color: Color.fromARGB(185, 244, 67, 54),
                      borderRadius: BorderRadius.circular(360),
                    ),
                  ),
                ),

                Center(
                  child: Image.asset(
                    "assets/icons/ai.png",
                    height: 250,
                  ),
                ),

                //title and
                Positioned(
                  left: 30,
                  bottom: 90,
                  child: Center(
                    child: Text(
                      "Bienvenue dans notre application",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          fontSize: 15),
                    ),
                  ),
                ),

                SizedBox(height: 30),

                Positioned(
                  left: 55,
                  bottom: 10,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Container(
                      width: 200,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 28, 28, 27),
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(164, 35, 39, 41),
                                offset: Offset(4, 1),
                                blurRadius: 15,
                                spreadRadius: 1.25),
                            BoxShadow(
                                color: Color.fromARGB(255, 140, 198, 64),
                                offset: Offset(-1, -1),
                                blurRadius: 10,
                                spreadRadius: 2.0),
                          ]),
                      child: Center(
                        child: Row(
                          children: [
                            SizedBox(width: 60),
                            Text(
                              "SUIVANT",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15),
                            ),
                            SizedBox(width: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 19.0),
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                                size: 22,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
