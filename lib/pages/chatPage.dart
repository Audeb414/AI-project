// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:eneo_ai_project/pages/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(chatPage());
}

// ignore: camel_case_types, use_key_in_widget_constructors
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

// ignore: use_key_in_widget_constructors
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final StreamController<List<Message>> _streamController = StreamController();

  // ignore: unused_element
  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      String userMessage = _controller.text;
      setState(() {
        _messages.add(Message(text: userMessage, isUser: true));
        _streamController.add(_messages);
        _controller.clear();
      });

      // Simuler une réponse de l'IA après un délai
      Future.delayed(const Duration(seconds: 1), () {
        String aiResponse = _generateResponse(userMessage);
        setState(() {
          _messages.add(Message(text: aiResponse, isUser: false));
          _streamController.add(_messages);
        });
      });
    }
  }

  String _generateResponse(String userMessage) {
    return 'Welcome in our application !';
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_typing_uninitialized_variables
    var sendMessage;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 27, 118, 187),
        elevation: 0,
        leading: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/dashboard');
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
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
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: _streamController.stream,
              // ignore: prefer_const_literals_to_create_immutables
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 140, 198, 64),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: _controller,
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
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  // ignore: prefer_const_constructors
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 140, 198, 64),
                  ),
                  child: IconButton(
                    // ignore: prefer_const_constructors
                    icon: Icon(
                      Icons.mic,
                      color: Colors.white,
                      size: 23,
                    ),
                    onPressed: () {
                      //logique pour enregistrer un sms vocal
                      // ignore: avoid_print
                      print(
                          "Enregistrement vocal"); // Remplacer par votre logique
                    },
                  ),
                ),
                // ignore: prefer_const_constructors
                SizedBox(width: 20),
                Container(
                  // ignore: prefer_const_constructors
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 140, 198, 64),
                  ),
                  child: IconButton(
                    // ignore: prefer_const_constructors
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 23,
                    ),

                    onPressed: sendMessage,
                  ),
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
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: message.isUser ? Colors.blue[200] : Colors.grey[300],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          message.text,
          style: TextStyle(color: message.isUser ? Colors.white : Colors.black),
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
