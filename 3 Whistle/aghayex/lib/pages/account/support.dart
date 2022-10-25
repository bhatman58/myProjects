import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:url_launcher/url_launcher.dart';

class support extends StatefulWidget {
  @override
  _supportState createState() => _supportState();
}

class _supportState extends State<support> {
  final String phone_url = "http://peyk3soot.ir/phones.php";
  List phone_items = [];
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

  getData() async {
    var res = await http.post(phone_url);
    print("Response code: ${res.statusCode}");
    var resBody = json.decode(res.body);

    setState(() {
      phone_items = resBody["content"];
    });
    print("itemmmmmmmmmmms ::::::: /////");
    print(phone_items);
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
    getData();
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  _launchCall(String phone) async {
    if (await canLaunch("tel:" + phone)) {
      await launch("tel:" + phone);
    } else {
      throw 'Could not launch tel';
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          width: media.width,
          height: media.height,
          child: phone_items.length != 0
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          child: Text(
                        ":برای تماس ، شماره را فشار دهید",
                        style: TextStyle(fontFamily: 'ir-sans'),
                      )),
                      InkWell(
                        onTap: () {
                          _launchCall(phone_items[0]['phone1']);
                        },
                        child: Container(
                          margin: EdgeInsets.all(media.width * .04),
                          padding: EdgeInsets.all(media.width * .03),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.cyan[200], Colors.blue[600]]),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                width: 1,
                                color: Colors.cyan,
                              )),
                          child: Text(
                            phone_items[0]['phone1'],
                            style: TextStyle(fontFamily: 'ir-sans'),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _launchCall(phone_items[0]['phone2']);
                        },
                        child: Container(
                          margin: EdgeInsets.all(media.width * .04),
                          padding: EdgeInsets.all(media.width * .03),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.cyan[200], Colors.blue[600]]),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                width: 1,
                                color: Colors.cyan,
                              )),
                          child: Text(
                            phone_items[0]['phone2'],
                            style: TextStyle(fontFamily: 'ir-sans'),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _launchCall(phone_items[0]['phone3']);
                        },
                        child: Container(
                          margin: EdgeInsets.all(media.width * .04),
                          padding: EdgeInsets.all(media.width * .03),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.cyan[200], Colors.blue[600]]),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                width: 1,
                                color: Colors.cyan,
                              )),
                          child: Text(
                            phone_items[0]['phone3'],
                            style: TextStyle(fontFamily: 'ir-sans'),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _launchCall(phone_items[0]['phone4']);
                        },
                        child: Container(
                          margin: EdgeInsets.all(media.width * .04),
                          padding: EdgeInsets.all(media.width * .03),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.cyan[200], Colors.blue[600]]),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                width: 1,
                                color: Colors.cyan,
                              )),
                          child: Text(
                            phone_items[0]['phone4'],
                            style: TextStyle(fontFamily: 'ir-sans'),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Text(
                    "درحال دریافت اطلاعات",
                    style: TextStyle(fontFamily: 'ir-sans'),
                  ),
                )),
    );
  }
}
