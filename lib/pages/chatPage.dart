import 'dart:convert'; // Pour utiliser Encoding
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class chatPage extends StatefulWidget {
  @override
  _chatPageState createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Assurer que WebView est bien initialisé
    WidgetsFlutterBinding.ensureInitialized();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);

    // Charger l'iframe avec la page HTML
    _controller.loadRequest(
      Uri.dataFromString('''<html>
            <body>
                <iframe src="https://eneo-chat.web.app" width="100%" height="600px" frameborder="0"></iframe>
            </body>
        </html>''',
          mimeType: 'text/html', encoding: Encoding.getByName('utf-8')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chatbot")),
      body: WebViewWidget(controller: _controller),
    );
  }
}
