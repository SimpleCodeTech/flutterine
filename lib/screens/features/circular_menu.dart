import 'package:flutter/material.dart';
import 'package:flutterine/utils/constants.dart';
import 'package:flutterine/utils/flutterine_menu.dart';
import 'package:flutterine/utils/shared.dart';

class CircularMenu extends StatefulWidget {
  const CircularMenu({super.key});

  @override
  CircularMenuState createState() => CircularMenuState();
}

class CircularMenuState extends State<CircularMenu> {
  String strSelectedMenu = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorPageSimpleCodeTech,
        appBar: appBar(context, "Circular menu", 15, <Widget>[]),
        body: Center(
          child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Text(
                strSelectedMenu,
                style: const TextStyle(
                  color: colorWhite,
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                ),
              )),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FlutterineMenu(
            fabOpenIcon: const Icon(
              Icons.menu_rounded,
              color: colorWhite,
            ),
            fabCloseIcon: const Icon(
              Icons.close_rounded,
              color: colorWhite,
            ),
            fabColor: colorIcon,
            fabOpenColor: colorIcon,
            ringColor: colorIcon,
            ringDiameter: 300,
            ringWidth: 50,
            fabSize: 50,
            children: <Widget>[
              IconButton(
                  icon: const Icon(
                    Icons.view_list_rounded,
                    color: colorWhite,
                  ),
                  onPressed: () {
                    setState(() {
                      strSelectedMenu = "Features menu";
                    });
                    Future.delayed(const Duration(seconds: 1), () {
                      setState(() {
                        strSelectedMenu = "";
                      });
                    });
                  }),
              IconButton(
                  icon: const Icon(
                    Icons.timer_rounded,
                    color: colorWhite,
                  ),
                  onPressed: () {
                    setState(() {
                      strSelectedMenu = "Time menu";
                    });
                    Future.delayed(const Duration(seconds: 1), () {
                      setState(() {
                        strSelectedMenu = "";
                      });
                    });
                  }),
              IconButton(
                  icon: const Icon(
                    Icons.newspaper_rounded,
                    color: colorWhite,
                  ),
                  onPressed: () {
                    setState(() {
                      strSelectedMenu = "News menu";
                    });
                    Future.delayed(const Duration(seconds: 1), () {
                      setState(() {
                        strSelectedMenu = "";
                      });
                    });
                  }),
              IconButton(
                  icon: const Icon(
                    Icons.tips_and_updates_rounded,
                    color: colorWhite,
                  ),
                  onPressed: () {
                    setState(() {
                      strSelectedMenu = "Tips menu";
                    });
                    Future.delayed(const Duration(seconds: 1), () {
                      setState(() {
                        strSelectedMenu = "";
                      });
                    });
                  }),
              IconButton(
                  icon: const Icon(
                    Icons.calendar_today_rounded,
                    color: colorWhite,
                  ),
                  onPressed: () {
                    setState(() {
                      strSelectedMenu = "Calendar menu";
                    });
                    Future.delayed(const Duration(seconds: 1), () {
                      setState(() {
                        strSelectedMenu = "";
                      });
                    });
                  }),
            ]));
  }
}
