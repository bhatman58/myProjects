import 'package:file_store/models/back2.dart';
import 'package:file_store/models/postDetail.dart';
import 'package:file_store/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class search extends StatefulWidget {
  @override
  _searchState createState() => _searchState();
}

class _searchState extends State<search>
    with AutomaticKeepAliveClientMixin<search> {
  TextEditingController scont = TextEditingController();
  var green = Color(0xFF94FBAB);
  var bluGrey = Color(0xFF82ABA1);
  List prods = [];
  static String key = env.cons_key;
  static String sec = env.cons_sec;
  static String envUrl = env.url;
  String loadingtex = "برای یافتن محصولی خاص ، جستجو کنید.";

  getProdData() async {
    String searchTex = scont.text;
    setState(() {
      loadingtex = "درحال جستجوی محصول شما";
    });
    var searchurl =
        "$envUrl/products?search=$searchTex&consumer_key=$key&consumer_secret=$sec";

    var res = await http.get(
      searchurl,
      headers: {"Content-Type": "application/json"},
    );
    print("Response code: ${res.statusCode}");
    var resBody = json.decode(res.body);
    prods = resBody;
    if (prods.length == 0) {
      setState(() {
        loadingtex = "محصولی یافت نشد";
      });
    } else {
      setState(() {
        prods = resBody;
        // prodVisi = true;
      });
    }

    print("itemmmmmmmmmmms ::::::: /////");
    print(prods);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    var media = MediaQuery.of(context).size;
    var width = media.width;
    var height = media.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            width: width,
            height: height,
            child: Stack(
              children: <Widget>[
                back2(),
                Container(
                  margin: EdgeInsets.only(
                    top: media.width * .1,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          left: media.width * .1,
                          right: media.width * .1,
                        ),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextField(
                            controller: scont,
                            cursorColor: Colors.blueGrey,
                            keyboardType: TextInputType.text,
                            maxLength: 50,
                            maxLines: 1,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                counterStyle: TextStyle(
                                    fontFamily: 'anjomanN', letterSpacing: 1.5),
                                labelText: "محصول مورد نظرت رو جستجو کن",
                                hintText: "مثال : دوره موفقیت فردی",
                                hintStyle: TextStyle(
                                    color: Colors.black54,
                                    fontSize: media.width * .028,
                                    fontFamily: 'anjoman'),
                                labelStyle: TextStyle(
                                    color: bluGrey, //Colors.yellow[800],
                                    fontSize: media.width * .028,
                                    fontFamily: 'anjoman'),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey[600], width: .6),
                                    borderRadius: BorderRadius.circular(12))),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: media.width * .3,
                          top: media.width * .05,
                          right: media.width * .3,
                        ),
                        child: RaisedButton(
                          onPressed: () {
                            if (scont.text.isEmpty) {
                              print("is empty");
                            } else
                              getProdData();
                          },
                          color: bluGrey, //Colors.blueGrey,
                          elevation: 5,
                          highlightColor: Colors.green[700],
                          highlightElevation: 20,
                          child: Center(
                            child: Text(
                              "جستجو",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'ir-sans',
                                  fontSize: media.width * .028),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                prods.length != 0
                    ? Positioned(
                        bottom: media.height * .1,
                        right: 0,
                        left: 0,
                        child: Container(
                          width: media.width,
                          height: media.height * .5,
                          child: ListView.builder(
                            itemCount: prods.length,
                            addAutomaticKeepAlives: true,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (eidz) => postDetail(
                                                prods[index]['images'][0]
                                                    ['src'],
                                                prods[index]['name'],
                                                prods[index]['price'],
                                                prods[index]['description'],
                                                index,
                                                2,
                                                prods[index]['id'])));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(
                                        media.width * .07,
                                        media.width * .02,
                                        media.width * .07,
                                        media.width * .02),
                                    width: media.width,
                                    constraints: BoxConstraints(
                                        minHeight: media.height * .28,
                                        maxHeight: media.height * .28),
                                    decoration: BoxDecoration(
                                        //Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(.4),
                                              blurRadius: 5,
                                              spreadRadius: .7,
                                              offset: Offset(1, 3))
                                        ]),
                                    child: Stack(
                                      children: <Widget>[
                                        Hero(
                                          tag: "page2$index",
                                          child: Container(
                                            width: media.width,
                                            height: media.height,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        prods[index]['images']
                                                            [0]['src']))),
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              width: width,
                                              padding: EdgeInsets.only(
                                                  top: width * .015,
                                                  bottom: width * .015),
                                              decoration: BoxDecoration(
                                                  color: bluGrey,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  20),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  20))),
                                              child: Hero(
                                                tag: "page-price$index",
                                                child: Text(
                                                  prods[index]['price'] +
                                                      "  تومان",
                                                  textAlign: TextAlign.center,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                      letterSpacing: 1,
                                                      color: Colors.white,
                                                      fontFamily: 'anjomanN',
                                                      fontSize:
                                                          media.width * .03),
                                                ),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ));
                            },
                          ),
                        ),
                      )
                    : prods == null || prods.length == 0
                        ? Positioned(
                            bottom: media.height * .3,
                            right: 0,
                            left: 0,
                            child: Container(
                              width: media.width,
                              child: Text(
                                loadingtex,
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontFamily: 'ir-sans',
                                    fontSize: media.width * .03,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
