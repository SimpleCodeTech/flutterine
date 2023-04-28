import 'package:flutter/material.dart';
import 'package:flutterine/utils/app_drawer.dart';
import 'package:flutterine/utils/constants.dart';
import 'package:flutterine/utils/shared.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  SideBarState createState() => SideBarState();
}

class SideBarState extends State<SideBar> {
  final GlobalKey<ScaffoldState> keyVal = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: keyVal,
        backgroundColor: colorPageBackground,
        appBar: appBarForDashboard(
            IconButton(
                icon: const Icon(
                  Icons.menu_rounded,
                  size: 32,
                ),
                onPressed: () {
                  // ignore: avoid_single_cascade_in_expression_statements
                  keyVal.currentState!.openDrawer();
                }),
            "Sidebar",
            context,
            <Widget>[]),
        drawer: AppDrawer(keyVal: keyVal),
        body: const Center(
          child: CircularProgressIndicator(color: colorButton),
        ));
  }
}
