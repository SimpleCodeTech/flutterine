import 'package:flutter/material.dart';
import 'package:flutterine/main.dart';
import 'dart:convert';
import 'package:package_info/package_info.dart';
import 'package:flutterine/screens/info.dart';
import 'package:flutterine/utils/constants.dart';
import 'package:flutterine/utils/secure_storage.dart';
import 'package:flutterine/utils/shared.dart';

class AppDrawer extends StatefulWidget {
  final GlobalKey<ScaffoldState> keyVal;
  const AppDrawer({super.key, required this.keyVal});

  @override
  AppDrawerState createState() => AppDrawerState();
}

class AppDrawerState extends State<AppDrawer> {
  final SecureStorage storage = SecureStorage();

  String? strUserName;
  String? strUserEmail;
  String? strUserImage;

  void _getUserProfile() async {
    strUserName = "Flutterine SimpleCodeTech";
    strUserEmail = "flutterine@simplecodetech.com";
    strUserImage = "";

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: colorMenuheader,
            ),
            accountName: Text(strUserName ?? ''),
            accountEmail: Text(strUserEmail ?? ''),
            otherAccountsPicturesSize: const Size.square(72),
            otherAccountsPictures: [
              CircleAvatar(
                  radius: 30,
                  backgroundColor: colorWhite,
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: Image.asset(
                      'assets/images/flutterine.png',
                      width: 72,
                    ).image,
                    backgroundColor: Colors.transparent,
                  ))
            ],
            currentAccountPicture: (strUserImage ?? '') == ''
                ? CircleAvatar(
                    backgroundColor:
                        Theme.of(context).platform == TargetPlatform.iOS
                            ? colorMenuheader
                            : colorPage,
                    child: Text(
                      getInitials(strUserName ?? ''),
                      style: const TextStyle(fontSize: 40.0),
                    ),
                  )
                : CircleAvatar(
                    radius: 30,
                    backgroundColor: colorWhite,
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: Image.memory(const Base64Decoder()
                              .convert(strUserImage!
                                  .replaceAll(r"//r//n", "")
                                  .replaceAll('//r////n', '')))
                          .image,
                      backgroundColor: Colors.transparent,
                    )),
          ),
          ListTile(
            leading: const Icon(Icons.info_rounded),
            title: const Text('Information'),
            onTap: () async {
              PackageInfo packageInfo = await PackageInfo.fromPlatform();
              String strVersion = packageInfo.version;
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Info(appVersion: strVersion)),
              );
            },
          ),
          addLine(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () async {
              /*showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Settings();
                },
              );
              //widget.refresh();
              setState(() {});*/
            },
          ),
          addLine(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              setState(() {});
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => const FlutterineApp(),
                ),
                (route) => false,
              );
            },
          ),
          addLine(),
        ],
      ),
    );
  }
}

String getInitials(String strUserName) => strUserName.trim().isNotEmpty
    ? strUserName
        .trim()
        .split(' ')
        .where((s) => s.isNotEmpty)
        .toList()
        .map((l) => l[0])
        .take(2)
        .join()
        .trim()
    : 'AB';
