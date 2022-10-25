import 'package:aghayex/models/disconnected.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectivity/connectivity.dart';

class story extends StatefulWidget {
  @override
  _storyState createState() => _storyState();
}

class _storyState extends State<story> {
  final String story_url = "http://peyk3soot.ir/story.php";
  List story_items = [];
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

  getStoryData() async {
    var res = await http.post(story_url);
    print("Response code: ${res.statusCode}");
    var resBody = json.decode(res.body);

    setState(() {
      story_items = resBody["content"];
      //visi = true;
    });
    print("itemmmmmmmmmmms ::::::: /////");
    print(story_items);
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
    getStoryData();
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
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[400],
                              spreadRadius: 2,
                              blurRadius: 8),
                          BoxShadow(
                              color: Colors.cyan[100],
                              spreadRadius: 1,
                              blurRadius: 8,
                              offset: Offset(4, 2))
                        ],
                        border: Border.all(
                          width: .7,
                          color: Colors.cyan,
                        ),
                        borderRadius: BorderRadius.circular(14)),
                    child: SingleChildScrollView(
                      child: (Text(
                        story_items.length == 0
                            ? "درحال دریافت اطلاعات جدید"
                            : story_items[0]['story'],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: 'ir-sans'),
                      )),
                    ),
                  ),
                )
              : disconnected()),
    );
  }
}
