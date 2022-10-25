import 'package:file_store/env.dart';
import 'package:file_store/models/downloadItems.dart';
import 'package:file_store/models/sharedPref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class webview extends StatefulWidget {
  int prodID;
  String price;
  webview({this.prodID, this.price});
  @override
  _webviewState createState() => _webviewState();
}

class _webviewState extends State<webview> {
  List result = [];
  String url;
  bool visi = false;
  static String PAYURL = env.payURL;
  static String CALLBURL = env.callBack;
  final fl = new FlutterWebviewPlugin();

  sendPayData() async {
    print(await sharedPref().getPrefs("username"));
    var res = await http.post(
      PAYURL,
      body: {
        'amount': widget.price + "0",
        'ownerName': await sharedPref().getPrefs("username")
      },
      //  headers: {
      //   'Content-Type': 'application/json'
      // }
    );
    print("Response code: ${res.statusCode}");
    print("Response BODY: ${res.body}");
    var resBody = json.decode(res.body);

    setState(() {
      result = resBody["content"];
      visi = true;
    });
    print("itemmmmmmmmmmms ::::::: /////");
    print(result[0]);
    if (result[0]['success'] == "true") {
      setState(() {
        visi = true;
        url = result[0]['url'];
        fl.cleanCookies();
        fl.launch(url);
      });
      fl.onUrlChanged.listen((String urli) {
        if (urli.contains(CALLBURL)) {
          Future.delayed(Duration(seconds: 3)).then((onValue) {
            fl.close();
            fl.dispose();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (c) => downloadItems(
                      prodID: widget.prodID,
                    )));
          });
        }
      });
    } else {
      print(result[0]['message']);
    }
  }

  @override
  void initState() {
    super.initState();
    print("///////////////////////// product ID : " + widget.prodID.toString());
    sendPayData();
  }

  @override
  void dispose() {
    super.dispose();
    fl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: wi,
        height: he,
        color: Colors.blueAccent,
        child: visi
            ? WebviewScaffold(
                url: url,
                scrollBar: false,
                withJavascript: true,
              )
            : Container(
                child: Center(
                  child: Text(
                    "در حال پردازش \nلطفا شکیبا باشید...",
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    softWrap: true,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'ir-sans',
                        fontSize: wi * .04),
                  ),
                ),
              ),
      ),
    );
  }
}
