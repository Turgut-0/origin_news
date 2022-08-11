import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Article_Views extends StatefulWidget {
  final String url;


  Article_Views(this.url);

  @override
  State<Article_Views> createState() => _Article_ViewsState();
}

class _Article_ViewsState extends State<Article_Views> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Haberler',
          style:
          TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        child: WebView(
          initialUrl: widget.url,
          onWebViewCreated: ((WebViewController webviewcontroller){
            _controller.complete(webviewcontroller);
          }),
        ),
      ),
    );
  }
}
