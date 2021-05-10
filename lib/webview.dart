import 'dart:io';


import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  final String id;


  WebPage({Key key , this.id}) : super(key: key);

  @override
  WebViewExampleState createState() => WebViewExampleState(id);
}

class WebViewExampleState extends State<WebPage> {
  String id;

  WebViewController _controller;

  WebViewExampleState(this.id);

  @override
  void initState() {
    super.initState();
    print("setstate");
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }



  @override
  Widget build(BuildContext context) {
    print("setstate3");

    return WebView(

      initialUrl: "https://www.rosacontactlens.com/item-info/"+widget.id.toString() ,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (controller) {
        print("create");
        _controller = controller;

      },

      onPageFinished: (controller) {


      },
      navigationDelegate: (request) {
        print("444444444444444444444444444444");
        print(request.url);
        print("workimg");
        print(_controller.currentUrl());



      //  print(_controller);
        if (request.url.contains('resultIndicator')) {

          print("hello");
          // TODO when api success
        } else if (request.url.contains('connect-fail')) {
          // TODO when api fail
        }
        return NavigationDecision.navigate;
      },
    );
  }
}