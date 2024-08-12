import 'package:eneo_ai_page3/animation.dart';
import 'package:eneo_ai_page3/heather.dart';
import 'package:eneo_ai_page3/search.dart';
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
                  height: 30,
                ),
                DelayedAnimation(
                  delay: 3000,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    height: 250,
                    // width: 700,
                    margin: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
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
                              //width: 230,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/eneo-logo.png'),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          const Text(
                            'lorem eprfiefnjifn feikjfpqjfk fozijfjiorijfr nihyufrviuoin hhgèrr-geytudtvug hgfyubtgf bfghdtyif hfiubhh',
                            style: TextStyle(
                              fontSize: 22,
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
                  height: 200,
                ),
                const SearchSection(),
              ],
            ),
          ],
        ),
      ), //scroller du contenu
    ); //home-contenu
  }
}
