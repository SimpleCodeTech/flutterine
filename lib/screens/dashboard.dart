import 'package:flutter/material.dart';
import 'package:flutterine/screens/features.dart';
import 'package:flutterine/screens/info.dart';
import 'package:flutterine/utils/constants.dart';
import 'package:flutterine/utils/flutterine_web_view.dart';
import 'package:flutterine/utils/responsive.dart';
import 'package:flutterine/utils/shared.dart';
import 'package:package_info/package_info.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  final PanelController _pnlController = PanelController();
  bool isPanelOpened = true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          bool willClose = false;
          if (isPanelOpened) {
            willClose = true;
          } else {
            setState(() {
              _pnlController.open();
            });
          }
          return willClose;
        },
        child: Scaffold(
          backgroundColor: colorPageSimpleCodeTech,
          appBar: appBarForDashboard(
              null,
              (isPanelOpened == true) ? "Dashboard" : "Settings",
              context, <Widget>[]),
          body: SlidingUpPanel(
              controller: _pnlController,
              maxHeight: MediaQuery.of(context).size.height,
              minHeight: 100,
              //isDraggable: false,
              defaultPanelState: PanelState.OPEN,
              color: colorPageBackground,
              onPanelOpened: () {
                setState(() {
                  isPanelOpened = true;
                });
              },
              onPanelClosed: () {
                setState(() {
                  isPanelOpened = false;
                });
              },
              body: settings(),
              panel: Builder(
                builder: (context) {
                  return dashboard();
                },
              )),
        ));
  }

  Widget _addButton(String strText, IconData iconData, bool boolSettings,
      {bool isDisabled = false}) {
    bool isMobile = Responsive.isMobile(context);
    double dblWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () async {
        if (strText == "information" && !isDisabled) {
          PackageInfo packageInfo = await PackageInfo.fromPlatform();
          String strVersion = packageInfo.version;
          if (!mounted) return;
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Info(appVersion: strVersion)),
          );
        } else if (strText == "features" && !isDisabled) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Features()),
          );
        }
      },
      child: Opacity(
          opacity: isDisabled ? 0.5 : 1,
          child: Stack(children: [
            Container(
                width: dblWidth,
                height: 75,
                margin: EdgeInsets.only(
                    left: isMobile ? 11 : 35, right: isMobile ? 11 : 35),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: colorWhite,
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: colorBlack12,
                      blurRadius: 0.5,
                    ),
                  ],
                ),
                padding: EdgeInsets.fromLTRB(isMobile ? 20 : 40, 0, 0, 0),
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.only(top: 0),
                        child: Icon(iconData, color: colorButton, size: 32)),
                    addhorizontalSpacing(isMobile ? 30 : 40),
                    Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          boolSettings
                              ? strText.toUpperCase()
                              : strText.toUpperCase(),
                          style: const TextStyle(
                            color: colorLabel,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                  ],
                )),
            Positioned(
                right: isMobile ? 25 : 50,
                top: 25,
                child: const Icon(Icons.keyboard_arrow_right_rounded,
                    size: 25, color: colorButton))
          ])),
    );
  }

  Widget dashboard() {
    bool isMobile = Responsive.isMobile(context);
    double dblWidth = MediaQuery.of(context).size.width;
    return Stack(children: [
      SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
              color: colorPageBackground,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      addVerticalSpacing(125),
                      _addButton('features', Icons.view_list_rounded, false),
                      addVerticalSpacing(20),
                      _addButton('time', Icons.timer, false, isDisabled: true),
                      addVerticalSpacing(20),
                      _addButton('news', Icons.newspaper_rounded, false,
                          isDisabled: true),
                      addVerticalSpacing(20),
                      _addButton('tips', Icons.tips_and_updates_rounded, false,
                          isDisabled: true),
                      addVerticalSpacing(20),
                      _addButton(
                          'calendar', Icons.calendar_today_rounded, false,
                          isDisabled: true),
                      addVerticalSpacing(isMobile ? 30 : 100),
                    ],
                  ),
                ],
              ))),
      Positioned(
          child: Container(
              color: colorPageSimpleCodeTech,
              height: 100,
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 40),
                width: dblWidth,
                decoration: const BoxDecoration(
                    color: colorPageBackground,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(100))),
                height: 60,
                child: Container(
                    padding: EdgeInsets.fromLTRB(isMobile ? 40 : 80, 0, 10, 5),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 2, color: colorHeadingUnderline))),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                convertToDateTime(DateTime.now().toString(),
                                    displayDashboardDayDateFormat),
                                style: const TextStyle(
                                  color: colorLabel,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ])),
              )))
    ]);
  }

  Widget settings() {
    bool isMobile = Responsive.isMobile(context);
    double dblWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
            color: colorPageSimpleCodeTech,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: 150,
                        color: colorPageSimpleCodeTech,
                        child: Container(
                          alignment: Alignment.center,
                          width: dblWidth,
                          decoration: const BoxDecoration(
                              color: colorPageSimpleCodeTech,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(100))),
                          height: 66,
                          child: Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 2,
                                          color: colorHeadingUnderline))),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.center,
                                          child: GestureDetector(
                                              child: Image.asset(
                                                'assets/images/flutterine.png',
                                                width: 100,
                                              ),
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const FlutterineWebView(
                                                              strURL: "",
                                                              strURLDesc: "")),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                  ])),
                        )),
                    addVerticalSpacing(50),
                    _addButton('my-settings', Icons.person, true,
                        isDisabled: true),
                    addVerticalSpacing(20),
                    _addButton('partner', Icons.support, true,
                        isDisabled: true),
                    addVerticalSpacing(20),
                    _addButton('information', Icons.info, true),
                    addVerticalSpacing(50),
                    Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 2, color: colorHeadingUnderline))),
                        child: Container()),
                    addVerticalSpacing(isMobile ? 30 : 220),
                  ],
                ),
              ],
            )));
  }
}
