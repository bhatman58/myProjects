import 'package:device_info/device_info.dart';
import 'package:file_store/models/sharedPref.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:file_store/pages/signupin/signupin.dart';

class onBoard extends StatefulWidget {
  @override
  _onBoardState createState() => _onBoardState();
}

class _onBoardState extends State<onBoard> {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  bool isPhys = false;

  device() async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (androidInfo.isPhysicalDevice) {
      isPhys = true;
      print("isssssssssssssssssssssssss PHYSICALLLLLLLLLLLLL");
    } else {
      Navigator.of(context).pop();
      print("isssssssssssssssssssssssss NOOOOOOOOOOOT PHYSICALLLLLLLLLLLLL");
    }
  }

  @override
  void initState() {
    super.initState();
    device();
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
              pageColor: Colors.blue[300],
              bubbleBackgroundColor: Colors.white,
              body: Text(
                'رمز نگاری و کدگذاری پیشرفته فایل ها',
                style: TextStyle(
                    fontSize: media.width * .033, fontFamily: 'ir-sans'),
              ),
              title: Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  'امنیت بالا',
                  style: TextStyle(
                      fontSize: media.width * .055, fontFamily: 'ir-sans'),
                ),
              ),
              mainImage: Image.asset(
                'assets/images/lock.png',
                height: media.width * .33,
                width: media.width * .33,
              ),
              textStyle: TextStyle(color: Colors.white, fontSize: 17),
            ),
            PageViewModel(
              pageColor: Colors.teal[200],
              bubbleBackgroundColor: Colors.white,
              body: Text(
                "بازگشت تضمینی وجه درصورت عدم رضایت از دوره",
                style: TextStyle(
                    fontSize: media.width * .033, fontFamily: 'ir-sans'),
              ),
              title: Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  'بازگشت وجه',
                  style: TextStyle(
                      fontSize: media.width * .055, fontFamily: 'ir-sans'),
                ),
              ),
              mainImage: Image.asset(
                'assets/images/transfer.png',
                height: media.width * .33,
                width: media.width * .33,
              ),
              textStyle: TextStyle(color: Colors.white, fontSize: 15),
            ),
            PageViewModel(
              pageColor: Colors.green[200],
              iconColor: null,
              bubbleBackgroundColor: Colors.white,
              body: Text(
                'امکان فروش آنلاین فایلهای \n صوتی ، تصویری ، pdf',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    fontSize: media.width * .033, fontFamily: 'ir-sans'),
              ),
              title: Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  'درگاه پرداخت',
                  style: TextStyle(
                      fontSize: media.width * .055, fontFamily: 'ir-sans'),
                ),
              ),
              mainImage: Image.asset(
                "assets/images/pay.png",
                width: media.width * .33,
                height: media.width * .33,
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
