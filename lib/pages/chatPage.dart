import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:eneo_ai_project/pages/dashboard.dart';

class chatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatScreen(),
      routes: {
        // ignore: prefer_const_constructors
        '/dashboard': (context) => Dashboard(),
        '/chat': (context) => chatPage(),
      },
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  double _uploadProgress = 0.0;
  String? _error;

  final String apiKey =
      "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"; // Remplacez par votre clé API
  final String apiUrl = "https://openrouter.ai/api/v1/chat/completions";
  final String systemMessage = "Vous êtes un assistant virtuel d'ENEO Cameroun."
      "Tu dois repondre aux questions de l'utilisateur par rapport à l'entreprise en te basant sur leur site officiel https://eneocameroon.cm/ ";

  final CloudinaryPublic cloudinary =
      CloudinaryPublic('dbjqlkk4r', 'documents');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 27, 118, 187),
        elevation: 0,
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
            const SizedBox(
              width: 10,
            ),
            Image.asset(
              'assets/images/eneo.jpeg',
            ),
            const SizedBox(
              width: 5,
            ),
            const Column(
              crossAxisAlignment:
                  CrossAxisAlignment.end, //decaler vers la gauche
              children: [
                Padding(padding: EdgeInsets.only(top: 10)),
                Text(
                  'ENEO CHAT',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),
          if (_error != null) _buildErrorMessage(_error!),
          if (_uploadProgress > 0 && _uploadProgress < 1)
            Padding(
              padding: EdgeInsets.all(8.0),
              child: LinearProgressIndicator(value: _uploadProgress),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 180, // Largeur égale pour les boutons
                height: 50, // Hauteur uniforme
                child: ElevatedButton(
                  onPressed: () async {
                    await _showJobApplicationDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color.fromARGB(255, 140, 198, 64), // Couleur du bouton
                    foregroundColor: Colors.white, // Couleur du texte
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Coins arrondis
                    ),
                  ),
                  child: Text(
                    "Postuler pour un emploi",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(width: 20), // Espacement entre les boutons
              SizedBox(
                width: 180,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    await _showApplicationDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 140, 198,
                        64), // Couleur différente pour l'autre bouton
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Postuler pour un stage",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (_) => _sendMessage(),
                      decoration: InputDecoration(
                        hintText: "      entrer un message...",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: _sendMessage,
                        ),
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }

  Widget _buildErrorMessage(String error) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(error, style: TextStyle(color: Colors.red)),
    );
  }

  Future<void> _sendMessage() async {
    if (_controller.text.isEmpty) return;
    setState(() {
      _isLoading = true;
      _error = null;
    });

    String userMessage = _controller.text;
    _controller.clear();
    setState(() {
      _messages.add(Message(text: userMessage, isUser: true));
    });

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          "model": "mistralai/mistral-7b-instruct",
          "messages": [
            {"role": "system", "content": systemMessage},
            {"role": "user", "content": userMessage}
          ]
        }),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
        String botResponse = jsonResponse["choices"][0]["message"]["content"];

        setState(() {
          _messages.add(Message(text: botResponse, isUser: false));
        });
      } else {
        _handleError(response);
      }
    } catch (e) {
      _handleError(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleError(dynamic error) {
    String errorMessage;
    if (error is http.Response) {
      errorMessage = "Erreur ${error.statusCode}: ${error.body}";
    } else {
      errorMessage = "Erreur de connexion: $error";
    }
    setState(() {
      _error = errorMessage;
    });
  }

  Widget _buildMessageBubble(Message message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Material(
          color: message.isUser ? Colors.blue[100]! : Colors.grey[300]!,
          borderRadius: BorderRadius.circular(8.0),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(message.text),
          ),
        ),
      ),
    );
  }

  Future<void> _showJobApplicationDialog() async {
    String? jobPosition;

    bool? isCanceled = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Étapes du processus de candidature pour un emploi"),
          content: Text(
            "1. Sélectionner le poste souhaité.\n"
            "2. Fournir les documents nécessaires (CV, lettre de motivation, dernier diplôme).\n"
            "3. Soumettre votre candidature.\n\n"
            "Cliquez sur le bouton 'OK' pour continuer.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(
                    false); // Retourne false pour indiquer que ce n'est pas annulé
              },
              child: Text("OK"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(true); // Retourne true pour indiquer l'annulation
              },
              child: Text("Annuler"),
            ),
          ],
        );
      },
    );

    // Vérifiez si l'utilisateur a annulé
    if (isCanceled == true) {
      return; // Ne pas continuer si annulé
    }

    jobPosition = await _askUserJobPosition();
    if (jobPosition != null) {
      await _askUserForJobDocuments(jobPosition);
    }
  }

  Future<String?> _askUserJobPosition() async {
    return await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Quel poste souhaitez-vous ?"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("Développeur Flutter"),
                onTap: () => Navigator.pop(context, "Développeur Flutter"),
              ),
              ListTile(
                title: Text("Ingénieur logiciel"),
                onTap: () => Navigator.pop(context, "Ingénieur logiciel"),
              ),
              // Ajoutez d'autres postes ici
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Ferme le dialogue sans faire d'action
              },
              child: Text("Annuler"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _askUserForJobDocuments(String jobPosition) async {
    User? user = FirebaseAuth.instance.currentUser;
    String userId = user?.uid ?? "inconnu";

    // Demande le CV
    String? cvPath = await _pickFile("Veuillez télécharger votre CV (PDF)");
    if (cvPath == null) return;

    String? cvUrl = await _uploadToCloudinary(cvPath);
    if (cvUrl == null) return;

    // Afficher le message de confirmation pour le CV
    await _showConfirmationDialog(
        "Téléversement réussi", "Le CV a été téléversé avec succès !");

    // Demande la lettre de motivation
    String? coverLetterPath = await _pickFile(
        "Veuillez télécharger votre lettre de motivation (PDF)");
    if (coverLetterPath == null) return;

    String? coverLetterUrl = await _uploadToCloudinary(coverLetterPath);
    if (coverLetterUrl == null) return;

    // Afficher le message de confirmation pour la lettre de motivation
    await _showConfirmationDialog("Téléversement réussi",
        "La lettre de motivation a été téléversée avec succès !");

    // Demande le dernier diplôme
    String? diplomaPath =
        await _pickFile("Veuillez télécharger votre dernier diplôme (PDF)");
    if (diplomaPath == null) return;

    String? diplomaUrl = await _uploadToCloudinary(diplomaPath);
    if (diplomaUrl == null) return;

    // Afficher le message de confirmation pour le dernier diplome
    await _showConfirmationDialog(
        "Téléversement réussi", "Le diplome a été téléversée avec succès !");

    // Soumet la candidature
    await _submitJobApplication(
        userId, jobPosition, cvUrl, coverLetterUrl, diplomaUrl);
  }

  Future<void> _submitJobApplication(String userId, String jobPosition,
      String cvUrl, String coverLetterUrl, String diplomaUrl) async {
    // Soumettre les informations à la collection des candidatures pour un emploi
    await FirebaseFirestore.instance.collection("job").add({
      "userId": userId,
      "jobPosition": jobPosition,
      "cvUrl": cvUrl,
      "coverLetterUrl": coverLetterUrl,
      "diplomaUrl": diplomaUrl,
      "timestamp": FieldValue.serverTimestamp(),
    });
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Candidature pour un emploi soumise"),
          content: Text(
              "✅ Votre candidature pour le poste de $jobPosition a été soumise avec succès ! Un recruteur vous contactera si votre dossier est retenu."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showApplicationDialog() async {
    String? stageType;

    bool? isCanceled = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Étapes du processus de candidature"),
          content: Text(
            "1. Sélectionner le type de stage.\n"
            "2. Fournir les documents nécessaires (CV, lettre de motivation, etc.).\n"
            "3. Soumettre votre candidature.\n\n"
            "Cliquez sur le bouton 'OK' pour continuer.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(
                    false); // Retourne false pour indiquer que ce n'est pas annulé
              },
              child: Text("OK"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(true); // Retourne true pour indiquer l'annulation
              },
              child: Text("Annuler"),
            ),
          ],
        );
      },
    );

    // Vérifiez si l'utilisateur a annulé
    if (isCanceled == true) {
      return; // Ne pas continuer si annulé
    }

    stageType = await _askUserStageType();
    if (stageType != null) {
      await _askUserForDocuments(stageType);
    }
  }

  Future<String?> _askUserStageType() async {
    return await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Quel type de stage souhaitez-vous ?"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("Stage académique"),
                onTap: () => Navigator.pop(context, "Stage académique"),
              ),
              ListTile(
                title: Text("Stage de recherche"),
                onTap: () => Navigator.pop(context, "Stage de recherche"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Ferme le dialogue sans faire d'action
              },
              child: Text("Annuler"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _askUserForDocuments(String stageType) async {
    User? user = FirebaseAuth.instance.currentUser;
    String userId = user?.uid ?? "inconnu";

    // Demande le CV
    String? cvPath = await _pickFile("Veuillez télécharger votre CV (PDF)");
    if (cvPath == null) return;

    String? cvUrl = await _uploadToCloudinary(cvPath);
    if (cvUrl == null) return;

    // Afficher le message de confirmation pour le CV
    await _showConfirmationDialog(
        "Téléversement réussi", "Le CV a été téléversé avec succès !");

    // Demande la lettre de motivation
    String? letterPath = await _pickFile(
        "Veuillez télécharger votre lettre de motivation (PDF)");
    if (letterPath == null) return;

    String? letterUrl = await _uploadToCloudinary(letterPath);
    if (letterUrl == null) return;

    // Afficher le message de confirmation pour la lettre de motivation
    await _showConfirmationDialog("Téléversement réussi",
        "La lettre de motivation a été téléversée avec succès !");

    // Documents supplémentaires en fonction du type de stage
    String? additionalDocPath;
    String? additionalDocUrl;

    if (stageType == "Stage académique") {
      additionalDocPath = await _pickFile(
          "Veuillez télécharger votre certificat de scolarité (PDF)");
    } else if (stageType == "Stage de recherche") {
      additionalDocPath =
          await _pickFile("Veuillez télécharger votre dernier diplôme (PDF)");
    }

    if (additionalDocPath != null) {
      additionalDocUrl = await _uploadToCloudinary(additionalDocPath);
      if (additionalDocUrl != null) {
        // Afficher le message de confirmation pour le document supplémentaire
        await _showConfirmationDialog("Téléversement réussi",
            "Le document supplémentaire a été téléversé avec succès !");
      } else {
        print("Échec du téléversement du document supplémentaire."); // Débogage
      }
    } else {
      additionalDocUrl = ""; // Aucun document supplémentaire
    }

    // Soumet la candidature
    await _submitApplication(
        userId, stageType, cvUrl, letterUrl, additionalDocUrl ?? "");
  }

  Future<String?> _pickFile(String message) async {
    return await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
          content: Text(
              "Appuyez sur le bouton ci-dessous pour sélectionner un fichier PDF."),
          actions: [
            TextButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf'],
                );
                if (result != null && result.files.isNotEmpty) {
                  Navigator.pop(context, result.files.single.path);
                } else {
                  Navigator.pop(context,
                      null); // Retourne null si aucun fichier n'est sélectionné
                }
              },
              child: Text("Choisir un PDF"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Ferme le dialogue sans faire d'action
              },
              child: Text("Annuler"),
            ),
          ],
        );
      },
    );
  }

  Future<String?> _uploadToCloudinary(String filePath) async {
    try {
      setState(() {
        _uploadProgress = 0.1;
      });

      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(filePath,
            resourceType: CloudinaryResourceType.Raw),
        onProgress: (count, total) {
          setState(() {
            _uploadProgress = count / total;
          });
        },
      );

      setState(() {
        _uploadProgress = 1.0;
      });
      await Future.delayed(
          Duration(seconds: 1)); // Pour que la barre soit visible
      setState(() {
        _uploadProgress = 0.0;
      });

      return response.secureUrl;
    } catch (e) {
      setState(() {
        _error = "Erreur lors du téléversement : $e";
        _uploadProgress = 0.0;
      });
      return null;
    }
  }

  Future<void> _showConfirmationDialog(String title, String message) async {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _submitApplication(String userId, String stageType, String cvUrl,
      String letterUrl, String additionalDocUrl) async {
    String collectionName =
        stageType == "Stage académique" ? "acStage" : "rechStage";

    try {
      await FirebaseFirestore.instance.collection(collectionName).add({
        "userId": userId,
        "stageType": stageType,
        "cvUrl": cvUrl,
        "letterUrl": letterUrl,
        "additionalDocUrl": additionalDocUrl,
        "timestamp": FieldValue.serverTimestamp(),
      });

      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Candidature soumise"),
            content: Text(
                "✅ Votre candidature a été soumise avec succès ! Un recruteur vous contactera si votre dossier est retenu."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } catch (e) {
      setState(() {
        _error = "Erreur lors de la soumission : $e";
      });
    }
  }
}

class Message {
  final String text;
  final bool isUser;
  Message({required this.text, required this.isUser});
}

//cloud name: dbjqlkk4r
//API key: 184846136368251
//API secret: jT13LPzypdJVp10EoVkO307GidA
//API env variable: CLOUDINARY_URL=cloudinary://184846136368251:jT13LPzypdJVp10EoVkO307GidA@dbjqlkk4r
//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
