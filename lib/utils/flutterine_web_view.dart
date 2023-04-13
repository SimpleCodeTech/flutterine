import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterine/utils/constants.dart';
import 'package:flutterine/utils/shared.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FlutterineWebView extends StatefulWidget {
  final String strURL;
  final String strURLDesc;
  const FlutterineWebView(
      {super.key, required this.strURL, required this.strURLDesc});
  @override
  FlutterineWebViewState createState() => FlutterineWebViewState();
}

class FlutterineWebViewState extends State<FlutterineWebView> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context, widget.strURLDesc, 20, <Widget>[]),
        body: Stack(
          children: <Widget>[
            WebView(
                initialUrl: widget.strURL,
                javascriptMode: JavascriptMode.unrestricted,
                allowsInlineMediaPlayback: true,
                onPageFinished: (finish) {
                  setState(() {
                    isLoading = false;
                  });
                }),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(color: colorButton),
              )
          ],
        ));
  }
}
