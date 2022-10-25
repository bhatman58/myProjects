import 'package:file_store/models/signInBack.dart';
import 'package:file_store/models/signUpBack.dart';
import 'package:file_store/pages/signupin/signin.dart';
import 'package:file_store/pages/signupin/signup.dart';
import 'package:flutter/material.dart';

class signupin extends StatefulWidget {
  _SignupinState createState() => _SignupinState();
}

class _SignupinState extends State<signupin>
    with SingleTickerProviderStateMixin {
  var color = Color.fromRGBO(252, 82, 73, 1);
  TabController Tcontroller;
  bool con = true;
  var subscription;

  @override
  void initState() {
    super.initState();
    Tcontroller = new TabController(vsync: this, length: 2);
    // connected();
    // subscription = Connectivity()
    //     .onConnectivityChanged
    //     .listen((ConnectivityResult result) {
    //   if (result == 'mobile' || result == 'wifi') {
    //     setState(() {
    //       con = true;
    //     });
    //   } else
    //     connected();
    // });
  }

  @override
  void dispose() {
    Tcontroller.dispose();
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: media.width,
            height: media.height,
            child: Stack(
              children: <Widget>[
                Container(
                  height: media.height,
                  child: TabBarView(
                    controller: Tcontroller,
                    children: <Widget>[
                      Stack(children: <Widget>[
                        signInBack(),
                        signin(),
                      ]),
                      Stack(children: <Widget>[
                        signUpBack(),
                        Container(
                            margin: EdgeInsets.only(top: media.height * .2),
                            child: signup())
                      ]),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: media.width * .15,
                      left: media.width * .15,
                      right: media.width * .15),
                  decoration: BoxDecoration(
                      border: Border.all(width: .6, color: Colors.white),
                      borderRadius: BorderRadius.circular(18)),
                  child: TabBar(
                    controller: Tcontroller,
                    indicatorSize: TabBarIndicatorSize.label,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.orange,
                    labelStyle: TextStyle(
                        fontFamily: 'ir-Sans', fontSize: media.width * .03),
                    labelColor: Colors.white,
                    tabs: <Widget>[
                      new Tab(
                        text: "ورود",
                      ),
                      new Tab(
                        text: "ثبت نام",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // : disconnected(),
      ),
    );
  }
}
