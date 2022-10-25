import 'package:aghayex/models/sharedPref.dart';
import 'package:aghayex/pages/main_screen/mainScreen.dart';
import 'package:aghayex/pages/onBoard/onBoard.dart';
import 'package:aghayex/pages/signupin/signupin.dart';
import 'package:flutter/material.dart';

class sag extends StatefulWidget {
  @override
  _sagState createState() => _sagState();
}

class _sagState extends State<sag> {
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
              context, MaterialPageRoute(builder: (c) => mainScreen()));
        }
      }
    }

    Future.delayed(Duration(seconds: 5)).then((onValue) => checker());
    var media = MediaQuery.of(context).size;
    return Container(
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
            width: media.width * .4,
            height: media.width * .4,
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
                    image: AssetImage("assets/images/delivery.png"))),
          ),
          Text(
            " سه سوت \n همواره در خدمت",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: media.width * .075,
                fontFamily: 'ir-sans'),
          ),
        ],
      )),
    );
  }
}
