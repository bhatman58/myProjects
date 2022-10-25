import 'package:aghayex/models/disconnected.dart';
import 'package:aghayex/models/sharedPref.dart';
import 'package:flutter/material.dart';
import 'package:aghayex/pages/buy/buy.dart';
import 'package:aghayex/pages/clean/clean.dart';
import 'package:aghayex/pages/flower/flower.dart';
import 'package:aghayex/pages/account/account.dart';
import 'package:flutter/services.dart';
import 'package:shifting_tabbar/shifting_tabbar.dart';
import 'dart:async';
import 'package:connectivity/connectivity.dart';

class mainScreen extends StatefulWidget {
  @override
  _mainScreenState createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen>
    with SingleTickerProviderStateMixin {
  TabController cont;
  bool visi = true;
  bool con = true;
  var subscription;

  void booler() {
    setState(() {
      visi = !visi;
    });
  }

  connected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        con = true;
      });
    } else {
      setState(() {
        con = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    cont = new TabController(length: 3, vsync: this);
    connected();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == 'mobile' || result == 'wifi') {
        setState(() {
          con = true;
        });
      } else
        connected();
    });
    // Timer.periodic(new Duration(seconds: 3), (timer) {
    //   // print(timer);
    //   booler();
    // });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10, top: 2),
                child: Builder(
                  builder: (context) => InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => account()));
                    },
                    child: AnimatedOpacity(
                      opacity: visi ? 1 : 0,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeIn,
                      child: Icon(
                        Icons.person_outline,
                        color: Colors.blue[400],
                      ),
                    ),
                  ),
                ),
              )
            ],
            backgroundColor: Colors.white,
            elevation: 5,
            centerTitle: true,
            title: Text(
              "سه سوت",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: media.width * .034,
                  fontFamily: 'ir-sans',
                  shadows: [
                    Shadow(
                        color: Colors.grey[400],
                        blurRadius: 4,
                        offset: Offset(3, 2))
                  ]),
            ),
          ),
          bottomNavigationBar: Container(
            height: media.width * .13,
            child: ShiftingTabBar(
              color: Colors.white,
              labelFlex: .53,
              controller: cont,
              labelStyle: TextStyle(
                  color: Colors.black87,
                  fontSize: media.width * .032,
                  fontFamily: 'ir-sans'),
              tabs: [
                ShiftingTab(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.cyan,
                    ),
                    text: "آقای خرید"),
                ShiftingTab(
                    icon: Icon(
                      Icons.card_giftcard,
                      color: Colors.cyan,
                    ),
                    text: "آقای گل"),
                ShiftingTab(
                    icon: Icon(
                      Icons.opacity,
                      color: Colors.cyan,
                    ),
                    text: "آقای بهداشت"),
              ],
            ),
          ),
          body: con
              ? TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: cont,
                  children: <Widget>[
                    buy(),
                    flower(),
                    clean(),
                  ],
                )
              : disconnected()),
    );
  }
}
