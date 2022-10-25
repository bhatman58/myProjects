import 'package:flutter/material.dart';
import 'package:aghayex/pages/order/order.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_swiper/flutter_swiper.dart';

class clean extends StatefulWidget {
  @override
  _cleanState createState() => _cleanState();
  clean({Key key}) : super(key: key);
}

class _cleanState extends State<clean>
    with AutomaticKeepAliveClientMixin<clean> {
  final String clean_url = "http://peyk3soot.ir/cleanItems.php";
  List clean_items = [];
  List<String> images = [
    "assets/images/condomi.png",
    "assets/images/pad.png",
    "assets/images/drugs.png",
    "assets/images/spray.png",
  ];
  bool visi = false;

  getcleanData() async {
    var res = await http.post(clean_url);
    print("Response code: ${res.statusCode}");
    var resBody = json.decode(res.body);

    setState(() {
      clean_items = resBody["content"];
      visi = true;
    });
    print("itemmmmmmmmmmms ::::::: /////");
    print(clean_items);
  }

  @override
  void initState() {
    super.initState();
    getcleanData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var media = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnimatedOpacity(
        opacity: visi ? 1 : 0,
        duration: Duration(milliseconds: 1500),
        curve: Curves.easeIn,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[400],
                        spreadRadius: 2,
                        offset: Offset(2, 2),
                        blurRadius: 4)
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: media.width * .25,
                    height: media.width * .3,
                    child: Image.asset(images[index]),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        clean_items[index]['itemName'],
                        style: TextStyle(
                            fontSize: media.width * .033,
                            fontFamily: 'ir-sans'),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
          itemWidth: media.height * .5,
          itemHeight: media.height * .53,
          layout: SwiperLayout.STACK,
          itemCount: clean_items.length,
          loop: false,
          onTap: (s) {
            print(s);
            Navigator.push(
                context, MaterialPageRoute(builder: (c) => order("2")));
          },
        ),
      ),
    );
  }

  Widget row(int index, String path) {
    var media = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (c) => order("1")));
      },
      child: Container(
        height: media.height * .25,
        width: media.width * .38,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[400],
                  spreadRadius: 2,
                  offset: Offset(2, 2),
                  blurRadius: 4)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: media.width * .15,
              height: media.width * .2,
              child: Image.asset(path),
            ),
            Container(
              child: Center(
                child: Text(
                  clean_items[index]['itemName'],
                  style: TextStyle(fontSize: media.width * .033),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
