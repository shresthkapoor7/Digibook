import 'package:device_preview/device_preview.dart';
import 'package:digibook/Homepage.dart';
import 'package:digibook/Navbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:passcode_screen/passcode_screen.dart';

Future<void> main() async {
  runApp(
    MaterialApp(
        theme: ThemeData(
            textTheme: TextTheme(
                    bodyText1: TextStyle(color: Colors.black),
                    bodyText2: TextStyle(color: Colors.black))
                .apply(bodyColor: Colors.black, displayColor: Colors.black)),
        home: NavBar()),
  );
}

class Passcode extends StatefulWidget {
  @override
  _PasscodeState createState() => _PasscodeState();
}

class _PasscodeState extends State<Passcode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
