import 'package:aghayex/models/sharedPref.dart';
import 'package:aghayex/pages/main_screen/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:aghayex/pages/signupin/signupin.dart';

class onBoard extends StatefulWidget {
  @override
  _onBoardState createState() => _onBoardState();
}

class _onBoardState extends State<onBoard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setF() async {
      sharedPref().setPrefs("firstTime", "no");
      String resres = await sharedPref().getPrefs("firstTime");
      print(resres);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (c) => signupin()));
    }

    var media = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Builder(
        builder: (contex) => IntroViewsFlutter(
          [
            PageViewModel(
              pageColor: Colors.deepPurpleAccent,
              bubbleBackgroundColor: Colors.grey,
              body: Text(
                'خرید داری؟\nنمیتونی انجام بدی؟\nحالشو نداری؟\nآنلاین خرید کن،درب منزل تحویل بگیر',
                style: TextStyle(
                    fontSize: media.width * .033, fontFamily: 'ir-sans'),
              ),
              title: Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  'آقای خرید',
                  style: TextStyle(
                      fontSize: media.width * .055, fontFamily: 'ir-sans'),
                ),
              ),
              mainImage: Image.asset(
                'assets/images/groceries.png',
                height: 150,
                width: 150,
              ),
              textStyle: TextStyle(color: Colors.white, fontSize: 15),
            ),
            PageViewModel(
              pageColor: Colors.orangeAccent,
              bubbleBackgroundColor: Colors.grey,
              body: Text(
                'دوست داری سورپرایزش کنی؟\nبا آقای گل، آنلاین واسش گل بفرست',
                style: TextStyle(
                    fontSize: media.width * .033, fontFamily: 'ir-sans'),
              ),
              title: Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  'آقای گُل',
                  style: TextStyle(
                      fontSize: media.width * .055, fontFamily: 'ir-sans'),
                ),
              ),
              mainImage: Image.asset(
                'assets/images/tribute.png',
                height: 150,
                width: 150,
              ),
              textStyle: TextStyle(color: Colors.white, fontSize: 17),
            ),
            PageViewModel(
              pageColor: Colors.cyan,
              iconColor: null,
              bubbleBackgroundColor: Colors.grey,
              body: Text(
                'سفارش آنلاین محصولات زناشویی',
                style: TextStyle(
                    fontSize: media.width * .033, fontFamily: 'ir-sans'),
              ),
              title: Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  'آقای بهداشت',
                  style: TextStyle(
                      fontSize: media.width * .055, fontFamily: 'ir-sans'),
                ),
              ),
              mainImage: Image.asset(
                'assets/images/condom.png',
                height: 150,
                width: 150,
              ),
              textStyle: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ],
          onTapDoneButton: () {
            setF();
          },
          columnMainAxisAlignment: MainAxisAlignment.center,
          showSkipButton: false,
          doneText: Text(
            "فهمیدم",
            style: TextStyle(fontFamily: 'ir-sans'),
          ),
          pageButtonTextStyles: new TextStyle(
              color: Colors.white, fontSize: 18.0, fontFamily: 'ir-sans'),
        ),
      )),
    );
  }
}
