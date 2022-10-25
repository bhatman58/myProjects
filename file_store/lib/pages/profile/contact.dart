import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class contact extends StatefulWidget {
  @override
  _contactState createState() => _contactState();
}

class _contactState extends State<contact> {
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
    var wi = media.width;
    var he = media.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(
            child: Container(
                width: media.width,
                height: he,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: wi * .1),
                        child: Text(
                          "کاربر / دانش پذیر محترم جهت ارتباط با گروه آموزشی میتوانید با تلفن های تماس زیر ارتباط داشته باشید\n (برای تماس بر روی شماره تاچ کنید).",
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'ir-sans'),
                        )),
                    SizedBox(
                      height: he * .05,
                    ),
                    InkWell(
                        onTap: () {
                          _launchCall("02128428420");
                        },
                        child: Container(
                          margin: EdgeInsets.all(media.width * .04),
                          padding: EdgeInsets.all(media.width * .03),
                          decoration: BoxDecoration(
                              color: Colors.green[400],
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                width: 1,
                                color: Colors.green,
                              )),
                          child: Text(
                            "02128428420",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: 'ir-sans'),
                          ),
                        )),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
