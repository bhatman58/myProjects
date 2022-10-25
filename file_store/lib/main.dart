import 'package:file_store/models/onBoard.dart';
import 'package:file_store/pages/main_screen/main_screen.dart';
import 'package:file_store/pages/signUpIn/signUpIn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_info/device_info.dart';
import 'package:file_store/models/sharedPref.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: home());
  }
}

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  String firstTime = "yes";
  String username = "";

  user() async {
    String resres = await sharedPref().getPrefs("username");
    String first = await sharedPref().getPrefs("firstTime");
    setState(() {
      firstTime = first;
      username = resres;
    });
    debugPrint("username" + username.toString());
    debugPrint("first" + firstTime.toString());
  }

  @override
  void initState() {
    super.initState();
    user();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    checker() {
      if (firstTime == "yes" || firstTime == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (c) => onBoard()));
      } else if (firstTime == "no") {
        if (username == "" || username == null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (c) => signupin()));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (c) => main_screen()));
        }
      }
    }

    Future.delayed(Duration(seconds: 6)).then((onValue) => checker());

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.pink[200],
          Colors.blue[600],
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: media.width * .45,
              height: media.width * .45,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.2),
                        spreadRadius: 4,
                        blurRadius: 4,
                        offset: Offset(4, 4))
                  ],
                  border: Border.all(width: 1, color: Colors.cyan),
                  image: DecorationImage(
                      image: AssetImage("assets/images/logo.png"))),
            ),
          ],
        )),
      ),
    );
  }
}
