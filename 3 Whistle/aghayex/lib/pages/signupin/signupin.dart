import 'package:aghayex/models/disconnected.dart';
import 'package:flutter/material.dart';
import 'package:aghayex/pages/signupin/signin.dart';
import 'package:aghayex/pages/signupin/signup.dart';
import 'package:connectivity/connectivity.dart';

class signupin extends StatefulWidget {
  _SignupinState createState() => _SignupinState();
}

class _SignupinState extends State<signupin>
    with SingleTickerProviderStateMixin {
  var color = Color.fromRGBO(252, 82, 73, 1);
  TabController Tcontroller;
  bool con = true;
  var subscription;

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
    Tcontroller = new TabController(vsync: this, length: 2);
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
  }

  @override
  void dispose() {
    Tcontroller.dispose();
    subscription.cancel();
    super.dispose();
  }

  Widget SignupinCard() {
    var media = MediaQuery.of(context).size;
    return ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: media.width * .03),
          width: media.width * .5,
          decoration: BoxDecoration(
              border: Border.all(width: .4, color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(15)),
          child: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: Colors.blueGrey,
            controller: Tcontroller,
            indicatorColor: Colors.cyan[700],
            labelStyle:
                TextStyle(fontFamily: 'ir-sans', fontSize: media.width * .03),
            labelColor: Colors.blue[600],
            tabs: <Widget>[
              new Tab(text: "ورود"),
              new Tab(text: "ثبت نام"),
            ],
          ),
        ),
        Container(
          height: media.height * .87,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          child: TabBarView(
            controller: Tcontroller,
            children: <Widget>[
              new signin(),
              new signup(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
        // resizeToAvoidBottomPadding: false,
        body: SafeArea(
            child: con
                ? SingleChildScrollView(
                    child: Container(
                      width: media.width,
                      height: media.height,
                      child: ListView(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                top: media.width * .1,
                                left: media.width * .15,
                                right: media.width * .15),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: .4, color: Colors.blueGrey),
                                borderRadius: BorderRadius.circular(15)),
                            child: TabBar(
                              indicatorSize: TabBarIndicatorSize.label,
                              unselectedLabelColor: Colors.blueGrey,
                              controller: Tcontroller,
                              indicatorColor: Colors.cyan[700],
                              labelStyle: TextStyle(
                                  fontFamily: 'irSans',
                                  fontSize: media.width * .03),
                              labelColor: Colors.blue[600],
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
                          Container(
                            height: media.height * .87,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15))),
                            child: TabBarView(
                              controller: Tcontroller,
                              children: <Widget>[
                                new signin(),
                                new signup(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : disconnected()));
  }
}
