import 'package:flutter/material.dart';
import 'package:flutterine/utils/constants.dart';
import 'package:flutterine/utils/flutterine_web_view.dart';
import 'package:flutterine/utils/responsive.dart';
import 'package:flutterine/utils/shared.dart';

class Info extends StatefulWidget {
  final String appVersion;
  const Info({super.key, required this.appVersion});

  @override
  InfoState createState() => InfoState();
}

class InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    double dblwidth = MediaQuery.of(context).size.width;
    bool isMobile = Responsive.isMobile(context);
    return Scaffold(
      appBar: appBar(context, 'information', 20, <Widget>[]),
      body: Builder(
        builder: (context) {
          return Scrollbar(
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                      width: dblwidth - (isMobile ? 20 : 40),
                      margin:
                          EdgeInsets.only(top: 20, left: (isMobile ? 10 : 20)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 0, color: colorBlack38.withOpacity(0.1)),
                        color: colorWhite,
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: colorBlack12,
                            blurRadius: 0.5,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.fromLTRB(0, 15, 20, 20),
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                _headingText('Law'),
                                SizedBox(
                                    width: dblwidth * 0.85,
                                    child: ListTile(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          isMobile ? 20 : 40, 0, 0, 0),
                                      leading: const Icon(
                                          Icons.language_rounded,
                                          color: colorIcon),
                                      title: const Text('Privacy',
                                          style: TextStyle(
                                              color: colorLabel,
                                              decoration:
                                                  TextDecoration.underline)),
                                      onTap: () async {
                                        try {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const FlutterineWebView(
                                                        strURL: dataPrivacyUrl,
                                                        strURLDesc: 'Privacy')),
                                          );
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text('Error')));
                                        }
                                      },
                                    )),
                                addLineWithMargin(1, dblwidth * 0.85, isMobile),
                                SizedBox(
                                    width: dblwidth * 0.85,
                                    child: ListTile(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          isMobile ? 20 : 40, 0, 0, 0),
                                      leading: const Icon(
                                          Icons.language_rounded,
                                          color: colorIcon),
                                      title: const Text('AGB',
                                          style: TextStyle(
                                              color: colorLabel,
                                              decoration:
                                                  TextDecoration.underline)),
                                      onTap: () async {
                                        try {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const FlutterineWebView(
                                                        strURL: aGBUrl,
                                                        strURLDesc: 'AGB')),
                                          );
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text('Error')));
                                        }
                                      },
                                    )),
                                addLineWithMargin(1, dblwidth * 0.85, isMobile),
                                /*SizedBox(
                                    width: dblwidth * 0.85,
                                    child: ListTile(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          isMobile ? 20 : 40, 0, 0, 0),
                                      leading: Icon(Icons.language_rounded),
                                      title: Text('Cache',
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline)),
                                      onTap: () async {
                                        try {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ListAllFiles()),
                                          );
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(translate(
                                                      'utils.error'))));
                                        }
                                      },
                                    )),
                                addLineWithMargin(1, dblwidth * 0.85, isMobile),*/
                                addVerticalSpacing(20),
                                _headingText("Flutterine"),
                                SizedBox(
                                  width: dblwidth * 0.85,
                                  child: ListTile(
                                    contentPadding: EdgeInsets.fromLTRB(
                                        isMobile ? 20 : 40, 0, 0, 0),
                                    leading: const Icon(Icons.info_rounded,
                                        color: colorIcon),
                                    title: Text(
                                      'Version ${widget.appVersion}',
                                      style: const TextStyle(color: colorLabel),
                                    ),
                                  ),
                                ),
                              ])))));
        },
      ),
    );
  }

  Widget _headingText(String strText) {
    double dblwidth = MediaQuery.of(context).size.width;
    bool isMobile = Responsive.isMobile(context);
    return Container(
      padding: EdgeInsets.fromLTRB(isMobile ? 20 : 40, 0, 0, 8),
      width: dblwidth * 0.85,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 2, color: colorHeadingUnderline))),
      child: Text(
        strText,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
