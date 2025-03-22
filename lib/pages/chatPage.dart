import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

class chatPage extends StatefulWidget {
  @override
  _chatPageState createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {
  final List<Message> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  String? _error;

  final String apiKey =
      "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";
  final String apiUrl = "https://openrouter.ai/api/v1/chat/completions";
  final String systemMessage =
      "Tu es un assistant virtuel d'ENEO Cameroun. Réponds aux questions des utilisateurs en te basant sur le site officiel.";

  final CloudinaryPublic cloudinary =
      CloudinaryPublic('dbjqlkk4r', 'documents');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('IA ENEO')),
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
          if (_error != null)
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(_error!, style: TextStyle(color: Colors.red)),
            ),
          ElevatedButton(
            onPressed: () async {
              await _showApplicationDialog();
            },
            child: Text("Postuler"),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : TextField(
                    controller: _controller,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: InputDecoration(
                      hintText: "Posez votre question...",
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: _sendMessage,
                      ),
                    ),
                  ),
          ),
        ],
      ),
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
        setState(() {
          _error = "Erreur ${response.statusCode}: ${response.body}";
        });
      }
    } catch (e) {
      setState(() {
        _error = "Erreur de connexion: $e";
      });
    }

    setState(() {
      _isLoading = false;
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

  Future<void> _showApplicationDialog() async {
    String? stageType;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Étapes du processus de candidature"),
          content: Text(
            "1. Sélectionner le type de stage.\n"
            "2. Fournir les documents nécessaires (CV, dernier diplôme, etc.).\n"
            "3. Soumettre votre candidature.\n\n"
            "Cliquez sur le bouton 'OK' pour continuer.",
          ),
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

    // Demande le dernier diplôme
    String? diplomaPath =
        await _pickFile("Veuillez télécharger votre dernier diplôme (PDF)");
    if (diplomaPath == null) return;

    String? diplomaUrl = await _uploadToCloudinary(diplomaPath);
    if (diplomaUrl == null) return;

    // Soumet la candidature
    await _submitApplication(userId, stageType, cvUrl, diplomaUrl);
  }

  Future<String?> _pickFile(String message) async {
    // Affiche un dialogue pour demander à l'utilisateur de choisir un fichier
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
          ],
        );
      },
    );
  }

  Future<String?> _uploadToCloudinary(String filePath) async {
    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(filePath,
            resourceType: CloudinaryResourceType.Raw),
      );
      return response.secureUrl;
    } catch (e) {
      setState(() {
        _error = "Erreur lors du téléversement : $e";
      });
      return null;
    }
  }

  Future<void> _submitApplication(
      String userId, String stageType, String cvUrl, String diplomaUrl) async {
    String collectionName =
        stageType == "Stage académique" ? "acStage" : "rechStage";

    await FirebaseFirestore.instance.collection(collectionName).add({
      "userId": userId,
      "stageType": stageType,
      "cvUrl": cvUrl,
      "diplomaUrl": diplomaUrl,
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
