import 'package:digibook/Homepage.dart';
import 'package:digibook/Navbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(
    MaterialApp(
        theme: ThemeData(fontFamily: 'Montserrat', primaryColor: Colors.white),
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
