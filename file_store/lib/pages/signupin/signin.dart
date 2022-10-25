import 'dart:convert';
import 'package:file_store/env.dart';
import 'package:file_store/models/sharedPref.dart';
import 'package:file_store/pages/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class signin extends StatefulWidget {
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<signin> {
  TextEditingController nameC = TextEditingController();
  TextEditingController passC = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final String SIGNURL = env.signURL;
  List result = [];

  void validator() {
    var media = MediaQuery.of(context).size;
    if (nameC.text.isEmpty || passC.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        new SnackBar(
          backgroundColor: Colors.orange[300],
          duration: Duration(seconds: 3),
          content: Container(
            height: media.width * .06,
            child: Center(
              child: Text(
                "!از خالی گذاشتن فیلدها خودداری نمایید",
                style: TextStyle(
                    fontSize: media.width * .027,
                    color: Colors.black,
                    fontFamily: 'ir-sans'),
                softWrap: true,
              ),
            ),
          ),
        ),
      );
    } else {
      if (result.length == 0) {
        signIn();
        _scaffoldKey.currentState.showSnackBar(
          new SnackBar(
            backgroundColor: Colors.blue,
            duration: Duration(seconds: 2),
            content: Container(
              height: media.width * .06,
              child: Center(
                child: Text(
                  "درحال بررسی اطلاعات",
                  style: TextStyle(
                      fontSize: media.width * .024,
                      color: Colors.black,
                      fontFamily: 'ir-sans'),
                  softWrap: true,
                ),
              ),
            ),
          ),
        );
      } else if (result[0]['success'] == 'false') {
        signIn();
      }
    }
  }

  signIn() async {
    var media = MediaQuery.of(context).size;
    var res = await http
        .post(SIGNURL, body: {"username": nameC.text, "password": passC.text});
    print("Response code: ${res.statusCode}");
    var resBody = json.decode(res.body);
    setState(() {
      result = resBody["content"];
    });
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: Text(
        result[0]['success'] == "true"
            ? "خوش آمدید"
            : "کاربر بااین مشخصات یافت نشد",
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: 'ir-sans', fontSize: media.width * .024),
      ),
      backgroundColor:
          result[0]['success'] == "true" ? Colors.green : Colors.red,
    ));
    if (result[0]['success'] == "true") {
      sharedPref().setPrefs("username", nameC.text.toString());
      String resres = await sharedPref().getPrefs("username");
      print("readed : " + resres);
      Future.delayed(Duration(milliseconds: 1000)).then((onValue) =>
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (c) => main_screen())));
    }

    print(result);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Filler(
                "نام کاربری",
                "نام کاربری",
                Icons.person_outline,
                nameC,
                30,
                TextInputAction.done,
                TextInputType.text,
              ),
            ),
            Container(
              child: Filler(
                "کلمه عبور",
                "کلمه عبور",
                Icons.lock_open,
                passC,
                100,
                TextInputAction.done,
                TextInputType.text,
              ),
            ),
            SizedBox(
              height: media.width * .08,
            ),
            InkWell(
              onTap: () {
                validator();
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Container(
                width: media.width * .4,
                height: media.width * .1,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.orange[200],
                      Colors.orange[700],
                    ]),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.2),
                          blurRadius: 7,
                          spreadRadius: 2)
                    ]),
                child: Center(
                  child: Text(
                    "ورود",
                    style: TextStyle(
                        fontFamily: 'ir-sans',
                        fontSize: media.width * .03,
                        color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget Filler(
      String hint,
      String label,
      IconData icon,
      TextEditingController controller,
      int length,
      TextInputAction action,
      TextInputType keytype) {
    var media = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: media.width * .08,
        right: media.width * .08,
        top: media.width * .05,
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          textInputAction: action,
          controller: controller,
          maxLength: length,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                TextStyle(fontSize: media.width * .031, fontFamily: 'ir-sans'),
            labelText: label,
            labelStyle: TextStyle(
                color: Colors.black,
                fontSize: media.width * .03,
                fontFamily: 'ir-sans'),
            icon: Icon(
              icon,
              color: Colors.orange[200],
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15)),
          ),
          cursorColor: Colors.white,
          keyboardType: keytype,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
