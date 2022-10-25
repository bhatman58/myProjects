import 'package:aghayex/pages/main_screen/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:aghayex/pages/signupin/signupin.dart';
import 'package:aghayex/pages/onBoard/onBoard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/sharedPref.dart';
import 'package:aghayex/pages/sag.dart';

void main() async => runApp(Main());

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: built(),
      ),
    );
  }
}

class built extends StatefulWidget {
  @override
  _builtState createState() => _builtState();
}

class _builtState extends State<built> {
  @override
  Widget build(BuildContext context) {
    return sag();
  }
}
