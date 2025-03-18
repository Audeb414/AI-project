import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:eneo_ai_project/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Importation du package url_launcher

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
  final StreamController<List<Message>> _streamController = StreamController();
  bool _isLoading = false;
  String? _error;

  final String apiKey =
      "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";
  final String apiUrl = "https://openrouter.ai/api/v1/chat/completions";

  // Message d'introduction au début pour ne pas répondre directement
  String systemMessage =
      "Tu es un assistant virtuel d'ENEO Cameroun. Comment puis-je t'aider aujourd'hui ? Pose ta question et je ferai de mon mieux pour y répondre.";

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
      _streamController.add(_messages);
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
            {
              "role": "system",
              "content": systemMessage,
            },
            {"role": "user", "content": userMessage}
          ]
        }),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
        String botResponse = jsonResponse["choices"][0]["message"]["content"];

        // Logique pour vérifier si la réponse contient un lien
        bool containsLink = botResponse.contains("https");

        setState(() {
          _messages.add(Message(text: botResponse, isUser: false));
          _streamController.add(_messages);
        });

        // Si l'IA n'a pas donné de réponse utile, proposer un lien
        if (!containsLink) {
          setState(() {
            _messages.add(
              Message(
                text:
                    "Pour plus d'informations, tu peux consulter le site officiel d'ENEO : https://eneocameroon.cm",
                isUser: false,
              ),
            );
          });
        }
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

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 27, 118, 187),
        elevation: 0,
        title: Text('IA ENEO'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: _streamController.stream,
              initialData: [],
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return _buildMessageBubble(snapshot.data![index]);
                  },
                );
              },
            ),
          ),
          if (_error != null)
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                _error!,
                style: TextStyle(color: Colors.red),
              ),
            ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Entrer un message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: _isLoading
                      ? CircularProgressIndicator()
                      : Icon(Icons.send, color: Colors.blue),
                  onPressed: _isLoading ? null : _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Message message) {
    return Align(
      alignment: message.isUser ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: message.isUser ? Colors.blue[200] : Colors.grey[300],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: TextStyle(
                  color: message.isUser ? Colors.white : Colors.black),
            ),
            if (!message.isUser && message.text.contains("https"))
              GestureDetector(
                onTap: () async {
                  final url =
                      message.text.contains("https") ? message.text : '';
                  if (await canLaunch(url)) {
                    await launch(url); // Ouvre l'URL dans le navigateur
                  } else {
                    setState(() {
                      _error = "Impossible d'ouvrir le lien.";
                    });
                  }
                },
                child: Text(
                  "Ouvrir le site officiel",
                  style: TextStyle(
                      color: Colors.blue, decoration: TextDecoration.underline),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class Message {
  final String text;
  final bool isUser;

  Message({required this.text, required this.isUser});
}

//bp_pat_XBjyeyOY5ELucoKS2lIaBYPvuW1kRUPmISGs
//https://webhook.botpress.cloud/381db053-0999-4c68-8d4f-a51f5f029c8d
//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
