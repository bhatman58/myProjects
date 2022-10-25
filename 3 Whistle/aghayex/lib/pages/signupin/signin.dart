import 'package:aghayex/models/sharedPref.dart';
import 'package:aghayex/pages/main_screen/mainScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class signin extends StatefulWidget {
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<signin> {
  TextEditingController nameC = TextEditingController();
  TextEditingController passC = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final String sign_url = "http://peyk3soot.ir/login.php";
  List result = [];

  void validator() {
    var media = MediaQuery.of(context).size;
    if (nameC.text.isEmpty || passC.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        new SnackBar(
          backgroundColor: Colors.blue,
          duration: Duration(seconds: 3),
          content: Container(
            height: media.width * .06,
            child: Center(
              child: Text(
                "!از خالی گذاشتن فیلدها خودداری نمایید",
                style: TextStyle(
                    fontSize: media.width * .03,
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
        signUp();
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
                      fontSize: media.width * .03,
                      color: Colors.black,
                      fontFamily: 'ir-sans'),
                  softWrap: true,
                ),
              ),
            ),
          ),
        );
      } else if (result[0]['success'] == 'false') {
        signUp();
      }
    }
  }

  signUp() async {
    var res = await http
        .post(sign_url, body: {"username": nameC.text, "password": passC.text});
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
        style: TextStyle(fontFamily: 'ir-sans'),
      ),
      backgroundColor:
          result[0]['success'] == "true" ? Colors.green : Colors.red,
    ));
    if (result[0]['success'] == "true") {
      sharedPref().setPrefs("username", nameC.text.toString());
      String resres = await sharedPref().getPrefs("username");
      print(resres);
      Future.delayed(Duration(milliseconds: 1000)).then((onValue) =>
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (c) => mainScreen())));
    }

    print(result);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
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
              height: media.width * .05,
            ),
            InkWell(
              onTap: () {
                validator();
              },
              child: Container(
                width: media.width * .4,
                height: media.width * .1,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.cyan[300],
                      Colors.blue[500],
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
        //bottom: media.width * .05
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
                TextStyle(fontSize: media.width * .033, fontFamily: 'ir-sans'),
            labelText: label,
            labelStyle: TextStyle(
                color: Colors.cyan[800],
                fontSize: media.width * .035,
                fontFamily: 'ir-sans'),
            icon: Icon(icon),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.cyan[400],
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15)),
          ),
          cursorColor: Colors.cyan,
          keyboardType: keytype,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
