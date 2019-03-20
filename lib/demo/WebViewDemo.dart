import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewDemo extends StatefulWidget {
  @override
  _WebViewDemoState createState() => _WebViewDemoState();
}

class _WebViewDemoState extends State<WebViewDemo> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      routes: {
        "/": (_) => new WebviewScaffold(
          url: "https://www.baidu.com",
          appBar: new AppBar(
            title: new Text("Widget webview"),
          ),
        )
      },
    );
  }
}
