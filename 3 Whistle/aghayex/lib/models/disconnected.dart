import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class disconnected extends StatefulWidget {
  @override
  _disconnectedState createState() => _disconnectedState();
}

class _disconnectedState extends State<disconnected> {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: media.width * .35,
              height: media.width * .35,
              child: Image.asset("assets/images/dis.png"),
            ),
            Container(
              child: Text(
                "به اینرتنت متصل نیستید... لطفا ارتباط را چک کنید",
                style: TextStyle(
                    fontSize: media.width * .04, fontFamily: 'ir-sans'),
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.all(media.width * .02),
              child: Text(
                ":برای تماس شماره را فشار دهید",
                style: TextStyle(fontFamily: 'ir-sans'),
              ),
            ),
            InkWell(
              onTap: () {
                _launchCall("02156792440");
              },
              child: Container(
                margin: EdgeInsets.all(media.width * .02),
                child: Text(
                  "02156792440",
                  style: TextStyle(fontFamily: 'ir-sans'),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _launchCall("02156792465");
              },
              child: Container(
                margin: EdgeInsets.all(media.width * .02),
                child: Text(
                  "02156792465",
                  style: TextStyle(fontFamily: 'ir-sans'),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _launchCall("09909361400");
              },
              child: Container(
                margin: EdgeInsets.all(media.width * .02),
                child: Text(
                  "09909361400",
                  style: TextStyle(fontFamily: 'ir-sans'),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _launchCall("09909361401");
              },
              child: Container(
                margin: EdgeInsets.all(media.width * .02),
                child: Text(
                  "09909361401",
                  style: TextStyle(fontFamily: 'ir-sans'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
