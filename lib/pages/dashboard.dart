import 'package:eneo_ai_project/pages/chatPage.dart';
import 'package:eneo_ai_project/pages/notification_page.dart';
import 'package:eneo_ai_project/pages/parametre%20.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/notification': (context) => notification(),
        '/parameter': (context) => Parametre(),
        '/chat': (context) => chatPage(),
      },
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 140, 198, 64),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => notification()),
              );
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.settings, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Parametre()),
                );
              },
            ),
            const SizedBox(width: 5),
          ],
        ),
        body: Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Espacement entre les éléments
          children: [
            // Partie supérieure avec le logo
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/eneo.png',
                    height: 110,
                  ),
                  SizedBox(height: 20), // Espacement entre le logo et le texte
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20), // Marge latérale
                    child: Text(
                      "Bienvenue sur le Chatbot ENEO Cameroun ! ⚡\n\n"
                      "ENEO Cameroun est le principal fournisseur d'électricité au Cameroun, engagé à offrir une énergie fiable et accessible pour accompagner le développement du pays. Avec une vision axée sur l'innovation et la satisfaction des clients, ENEO œuvre chaque jour pour améliorer la qualité de ses services.\n\n"
                      "Que vous soyez à la recherche d'un emploi, d'un stage ou simplement d'informations sur l'entreprise, ce chatbot est là pour vous guider ! Sélectionnez une option et laissez-vous accompagner. 🔍⚡",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bouton en bas centré
            Padding(
              padding: EdgeInsets.only(bottom: 40), // Marge en bas
              child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => chatPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 140, 198, 64),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  ),
                  child: Text(
                    "Accéder au Chatbot",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
