import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterine/screens/dashboard.dart';
import 'package:flutterine/screens/splash.dart';
import 'package:flutterine/utils/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FlutterineApp());
  HttpOverrides.global = MyHttpOverrides();
}

class FlutterineApp extends StatefulWidget {
  const FlutterineApp({super.key});

  // This widget is the root of your application.
  @override
  FlutterineAppState createState() => FlutterineAppState();
}

class FlutterineAppState extends State<FlutterineApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      color: colorPageBackground,
      theme: ThemeData(
        scaffoldBackgroundColor: colorPageSimpleCodeTech,
        highlightColor: colorHighlight,
        appBarTheme: AppBarTheme(
          color: colorMenuheader,
          elevation: 5,
          shadowColor: colorBlack.withOpacity(0.5),
          centerTitle: true,
          titleSpacing: 4,
          toolbarTextStyle: const TextStyle(
              color: colorWhite,
              fontSize: 20,
              letterSpacing: 1,
              fontWeight: FontWeight.w900),
          titleTextStyle: const TextStyle(
              color: colorWhite,
              fontSize: 20,
              letterSpacing: 1,
              fontWeight: FontWeight.w900),
          iconTheme: const IconThemeData(
            color: colorWhite,
          ),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        textTheme: const TextTheme(bodyText2: TextStyle(color: colorLabel)),
        scrollbarTheme: const ScrollbarThemeData().copyWith(
          interactive: true,
          thumbVisibility: MaterialStateProperty.all(true),
          trackBorderColor:
              MaterialStateProperty.all(colorScroll.withOpacity(0.1)),
          showTrackOnHover: true,
          trackColor: MaterialStateProperty.all(colorScroll.withOpacity(0.5)),
          radius: const Radius.circular(10.0),
          thumbColor: MaterialStateProperty.all(colorScroll),
          thickness: MaterialStateProperty.all(3.0),
          minThumbLength: 100,
        ),
        fontFamily: 'Lato',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => const Splash(),
        '/Dashboard': (context) => const Dashboard()
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
