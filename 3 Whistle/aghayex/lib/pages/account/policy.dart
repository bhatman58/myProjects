import 'package:aghayex/models/disconnected.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectivity/connectivity.dart';

class policy extends StatefulWidget {
  @override
  _policyState createState() => _policyState();
}

class _policyState extends State<policy> {
  final String policy_url = "http://peyk3soot.ir/policy.php";
  List policy_items = [];
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

  getPolicyData() async {
    var res = await http.post(policy_url);
    print("Response code: ${res.statusCode}");
    var resBody = json.decode(res.body);

    setState(() {
      policy_items = resBody["content"];
      //visi = true;
    });
    print("itemmmmmmmmmmms ::::::: /////");
    print(policy_items);
  }

  @override
  void initState() {
    super.initState();
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
    getPolicyData();
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
      body: SafeArea(
          child: con
              ? Container(
                  width: media.width,
                  height: media.height,
                  child: Container(
                    margin: EdgeInsets.all(media.width * .04),
                    padding: EdgeInsets.all(media.width * .02),
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: .7,
                          color: Colors.cyan,
                        ),
                        borderRadius: BorderRadius.circular(14)),
                    child: SingleChildScrollView(
                      child: (Text(
                        policy_items.length == 0
                            ? "درحال دریافت اطلاعات جدید"
                            : policy_items[0]['policy'],
                        textAlign: TextAlign.right,
                        style: TextStyle(fontFamily: 'ir-sans'),
                      )),
                    ),
                  ),
                )
              : disconnected()),
    );
  }
}
