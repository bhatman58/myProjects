import 'package:aghayex/models/sharedPref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class webView extends StatefulWidget {
  String name;
  String getternName;
  String phone;
  String getterPhone;
  String getterAddres;
  String price;
  String prodName;
  String giftDescription;
  webView(
    this.name,
    this.getternName,
    this.phone,
    this.getterPhone,
    this.getterAddres,
    this.price,
    this.prodName,
    this.giftDescription,
  );
  @override
  _webViewState createState() => _webViewState();
}

class _webViewState extends State<webView> {
  final String send_url = "http://peyk3soot.ir/pay.php";
  List result = [];
  String url;
  bool visi = false;
  String username = "";
  final fl = new FlutterWebviewPlugin();

  sendPayData() async {
    var res = await http.post(send_url, body: {
      "amount": widget.price,
      "ownerName": widget.name,
      "getterName": widget.getternName,
      "phone": widget.phone,
      "getterPhone": widget.getterPhone,
      "getterAddress": widget.getterAddres,
      "prodName": widget.prodName,
      "username": await sharedPref().getPrefs("username"),
      "giftDesc": widget.giftDescription,
    });
    print("Response code: ${res.statusCode}");
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
        fl.launch(url);
      });
      fl.onUrlChanged.listen((String urli) {
        if (urli.contains("http://peyk3soot.ir/callback.php")) {
          Future.delayed(Duration(seconds: 3)).then((onValue) {
            fl.close();
            fl.dispose();
            Navigator.pop(context);
          });
        }
      });
    } else {
      print(result[0]['message']);
    }
  }

  @override
  void dispose() {
    super.dispose();
    fl.dispose();
  }

  @override
  void initState() {
    super.initState();
    sendPayData();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: media.width,
        height: media.height,
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
                    "در حال پردازش \nلطفا شکیبا باشید",
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),
              ),
      ),
    );
  }
}
