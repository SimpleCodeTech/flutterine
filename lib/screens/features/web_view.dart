import 'package:flutter/material.dart';
import 'package:flutterine/utils/constants.dart';
import 'package:flutterine/utils/flutterine_web_view.dart';
import 'package:flutterine/utils/responsive.dart';
import 'package:flutterine/utils/shared.dart';

class WebView extends StatefulWidget {
  const WebView({super.key});

  @override
  WebViewState createState() => WebViewState();
}

class WebViewState extends State<WebView> {
  @override
  Widget build(BuildContext context) {
    double dblwidth = MediaQuery.of(context).size.width;
    bool isMobile = Responsive.isMobile(context);
    return Scaffold(
      backgroundColor: colorPageBackground,
      appBar: appBar(context, "Flutterine Web View", 15, <Widget>[]),
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  child: ListTile(
                contentPadding:
                    EdgeInsets.fromLTRB(isMobile ? 20 : 40, 0, 0, 0),
                leading: const Icon(Icons.language_rounded, color: colorIcon),
                title: const Text('Simple Code Technologies',
                    style: TextStyle(
                        color: colorLabel,
                        decoration: TextDecoration.underline)),
                onTap: () async {
                  try {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FlutterineWebView(
                              strURL: dataPrivacyUrl,
                              strURLDesc: 'Simple Code Technologies')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Error')));
                  }
                },
              )),
              addLineWithMargin(1, dblwidth * 0.95, isMobile),
              SizedBox(
                  width: dblwidth * 0.85,
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.fromLTRB(isMobile ? 20 : 40, 0, 0, 0),
                    leading:
                        const Icon(Icons.language_rounded, color: colorIcon),
                    title: const Text('Flutter',
                        style: TextStyle(
                            color: colorLabel,
                            decoration: TextDecoration.underline)),
                    onTap: () async {
                      try {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FlutterineWebView(
                                  strURL: flutterUrl, strURLDesc: 'Flutter')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Error')));
                      }
                    },
                  )),
            ]),
      ),
    );
  }
}
