import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class chatPage extends StatefulWidget {
  @override
  _chatPageState createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    /*if (WebViewPlatform.instance == null) {
      WebViewPlatform.instance ??= SurfaceAndroidWebview();
    }*/

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(
          "https://cdn.botpress.cloud/webchat/v2.3/shareable.html?configUrl=https://files.bpcontent.cloud/2024/10/29/00/20241029004814-CIXSAA6L.json")); // Remplace TON_BOT_ID
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chatbot")),
      body: WebViewWidget(controller: controller),
    );
  }
}
