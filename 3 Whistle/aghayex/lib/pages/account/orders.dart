import 'package:aghayex/models/disconnected.dart';
import 'package:aghayex/pages/account/buyItems.dart';
import 'package:aghayex/pages/account/cleanItems.dart';
import 'package:aghayex/pages/account/flowItems.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class orders extends StatefulWidget {
  @override
  _ordersState createState() => _ordersState();
}

class _ordersState extends State<orders> with SingleTickerProviderStateMixin {
  TabController cont;
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
    cont = new TabController(vsync: this, length: 3);
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
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "سفارش های من",
            style:
                TextStyle(fontSize: media.width * .037, fontFamily: 'ir-sans'),
          ),
          centerTitle: true,
          bottom: TabBar(
            controller: cont,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey[400],
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.shopping_cart),
              ),
              Tab(
                icon: Icon(Icons.card_giftcard),
              ),
              Tab(
                icon: Icon(Icons.opacity),
              ),
            ],
          ),
        ),
        body: con
            ? Container(
                width: media.width,
                height: media.height,
                color: Colors.blueGrey,
                child: TabBarView(
                  controller: cont,
                  children: <Widget>[
                    buyItems(),
                    flowItems(),
                    cleanItems(),
                  ],
                ))
            : disconnected());
  }
}
