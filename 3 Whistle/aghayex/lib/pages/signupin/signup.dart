import 'package:aghayex/models/sharedPref.dart';
import 'package:aghayex/pages/main_screen/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class signup extends StatefulWidget {
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<signup> {
  TextEditingController nameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController landC = TextEditingController();
  TextEditingController unameC = TextEditingController();
  TextEditingController passC = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final String sign_url = "http://peyk3soot.ir/register.php";
  List result = [];

  void validator() {
    var media = MediaQuery.of(context).size;
    if (nameC.text.isEmpty ||
        phoneC.text.isEmpty ||
        landC.text.isEmpty ||
        unameC.text.isEmpty ||
        passC.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        new SnackBar(
          backgroundColor: Colors.blue,
          duration: Duration(seconds: 3),
          content: Container(
            height: media.width * .06,
            child: Center(
              child: Text(
                "!از خالی گذاشتن فیلدها خودداری نمایید",
                style:
                    TextStyle(fontSize: media.width * .03, color: Colors.black),
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
            duration: Duration(seconds: 3),
            content: Container(
              height: media.width * .06,
              child: Center(
                child: Text(
                  "درحال ثبت اطلاعات",
                  style: TextStyle(
                      fontSize: media.width * .03, color: Colors.black),
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
    var res = await http.post(sign_url, body: {
      "nameNlast": nameC.text,
      "phone": phoneC.text,
      "land": landC.text,
      "username": unameC.text,
      "password": passC.text
    });
    print("Response code: ${res.statusCode}");
    var resBody = json.decode(res.body);
    setState(() {
      result = resBody["content"];
    });
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: Text(
        result[0]['success'] == "true"
            ? "ثبت نام با موفقیت انجام شد"
            : "کاربر بااین مشخصات وجود دارد",
        textAlign: TextAlign.center,
      ),
      backgroundColor:
          result[0]['success'] == "true" ? Colors.green : Colors.red,
    ));
    if (result[0]['success'] == "true") {
      sharedPref().setPrefs("username", unameC.text.toString());
      String resres = await sharedPref().getPrefs("username");

      Future.delayed(Duration(milliseconds: 800)).then((onValue) {
        print("readed: $resres");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (c) => mainScreen()));
      });
    }

    print(result);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: ListView(
          children: <Widget>[
            Filler(
              "نام و نام خانوادگی به فارسی",
              "نام و نام خانوادگی",
              Icons.text_format,
              nameC,
              60,
              TextInputAction.done,
              TextInputType.text,
            ),
            Filler(
              "09123456789",
              "شماره همراه",
              Icons.plus_one,
              phoneC,
              11,
              TextInputAction.done,
              TextInputType.number,
            ),
            Filler(
              "همراه با پیش شماره استان و منطقه",
              "شماره ثابت",
              Icons.plus_one,
              landC,
              11,
              TextInputAction.done,
              TextInputType.number,
            ),
            Filler(
              "ali123",
              "نام کاربری",
              Icons.person_outline,
              unameC,
              30,
              TextInputAction.done,
              TextInputType.text,
            ),
            Filler(
              "کلمه عبور",
              "کلمه عبور",
              Icons.lock_open,
              passC,
              60,
              TextInputAction.done,
              TextInputType.text,
            ),
            Container(
                margin: EdgeInsets.fromLTRB(
                  media.width * .22,
                  media.width * .04,
                  media.width * .22,
                  media.width * .07,
                ),
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
                height: media.width * .1,
                child: InkWell(
                  onTap: () {
                    validator();
                  },
                  child: Center(
                    child: Text(
                      "ثبت نام",
                      style:
                          TextStyle(color: Colors.white, fontFamily: 'ir-sans'),
                    ),
                  ),
                )),
            SizedBox(
              height: media.width * .1,
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
