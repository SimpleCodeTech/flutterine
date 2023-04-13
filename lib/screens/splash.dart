import 'package:flutter/material.dart';
import 'package:flutterine/utils/constants.dart';
import 'dart:async';

import 'package:flutterine/utils/shared.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPageSimpleCodeTech,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const CircularProgressIndicator(
                value: null,
                valueColor: AlwaysStoppedAnimation<Color>(colorButton),
              ),
              addVerticalSpacing(20),
              const Text(
                'Loading',
                style: TextStyle(
                  fontSize: 21,
                  color: colorButton,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, _startApp);
  }

  Future<void> _startApp() async {
    Navigator.pushReplacementNamed(context, '/Dashboard');
  }
}
