import 'dart:io' as io;
import 'dart:typed_data';
import 'package:file_store/models/postDetail.dart';
import 'package:file_store/models/sharedPref.dart';
import 'package:file_store/env.dart';
import 'package:flutter/material.dart';
import 'package:file_store/models/back1.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class prods extends StatefulWidget {
  @override
  _prodsState createState() => _prodsState();
}

class _prodsState extends State<prods>
    with AutomaticKeepAliveClientMixin<prods> {
  var green = Color(0xFF94FBAB);
  var bluGrey = Color(0xFF82ABA1);
  var _current_cat = 0;
  List cats, prods = [];
  bool catVisi, prodVisi = false;
  String progText = "درحال دریافت اطلاعات";
  static String key = env.cons_key;
  static String sec = env.cons_sec;
  static String envUrl = env.url;
  var caturl =
      "$envUrl/products/categories?consumer_key=$key&consumer_secret=$sec";

  getCatData() async {
    var res =
        await http.get(caturl, headers: {"Content-Type": "application/json"});
    print("Response code: ${res.statusCode}");
    var resBody = json.decode(res.body);
    print("//////");
    setState(() {
      cats = resBody;
      catVisi = true;
      getProdData(cats[0]['id']);
    });

    print("itemmmmmmmmmmms ::::::: /////");
    print(cats);
  }

  getProdData(int catInd) async {
    var produrl =
        "$envUrl/products?per_page=100&category=$catInd&consumer_key=$key&consumer_secret=$sec";
    var res =
        await http.get(produrl, headers: {"Content-Type": "application/json"});
    print("Response code: ${res.statusCode}");
    var resBody = json.decode(res.body);
    prods = resBody;

    if (prods.length == 0) {
      setState(() {
        progText = "محصولی یافت نشد";
      });
    } else {
      setState(() {
        prods = resBody;
        prodVisi = true;
      });
    }
    print("itemmmmmmmmmmms ::::::: /////");
    print(prods);
  }

  getCustProd(int catNum) async {
    prods.clear();
    prods = [];
    setState(() {
      progText = "درحال دریافت اطلاعات";
    });
    var url =
        "$envUrl/products?per_page=100&category=$catNum&consumer_key=$key&consumer_secret=$sec";

    var res =
        await http.get(url, headers: {"Content-Type": "application/json"});
    print("Response code: ${res.statusCode}");
    var resBody = json.decode(res.body);
    prods = resBody;
    if (prods.length == 0) {
      setState(() {
        progText = "محصولی یافت نشد";
      });
    } else {
      setState(() {
        prods = resBody;
        prodVisi = true;
      });
    }

    print("NEEEEEEEW itemmmmmmmmmmms ::::::: /////");
    print(prods);
  }

  @override
  void initState() {
    super.initState();
    getCatData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    var media = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        width: media.width,
        height: media.height,
        child: Stack(
          children: <Widget>[
            back1(),
            Align(
              alignment: Alignment.topCenter,
              // right: 10, //media.width * .2,
              // top: media.width * .07, //media.width * .2,
              child: Container(
                width: 80,
                height: 80,
                margin: EdgeInsets.only(top: 20),
                // padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  // color: Colors.yellow,
                  borderRadius: BorderRadius.circular(18),
                  //color: Colors.lime[100]
                ),
                child: Image.asset('assets/images/logo1.png'),
              ),
            ),
            Positioned(
              top: media.width * .35,
              child: Container(
                width: media.width,
                height: media.width * .15,
                child: AnimatedOpacity(
                  duration: Duration(seconds: 2),
                  curve: Curves.easeIn,
                  opacity: catVisi == true ? 1 : 0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    addAutomaticKeepAlives: true,
                    reverse: true,
                    itemBuilder: (con, ind) {
                      return InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.yellow[100],
                        borderRadius: BorderRadius.circular(55),
                        onTap: () {
                          setState(() {
                            _current_cat = ind;
                          });
                          getCustProd(cats[ind]['id']);
                          // print("index : $ind");
                          // print("current : $_current_cat");
                        },
                        child: Container(
                          constraints:
                              BoxConstraints(minWidth: media.width * .17),
                          margin: EdgeInsets.all(media.width * .02),
                          padding: EdgeInsets.all(media.width * .025),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(.2),
                                    blurRadius: 4,
                                    spreadRadius: .2)
                              ],
                              color: _current_cat == ind
                                  ? bluGrey //Colors.yellow[700]
                                  : Colors.grey[200]),
                          child: Center(
                              child: Text(
                            cats != null ? cats[ind]['name'] : "",
                            style: TextStyle(
                                fontFamily: 'ir-sans',
                                color: _current_cat == ind
                                    ? Colors.white
                                    : Colors.black87,
                                fontSize: media.width * .025,
                                fontWeight: FontWeight.w700),
                          )),
                        ),
                      );
                    },
                    itemCount: cats != null ? cats.length : 0,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                  height: media.height * .57,
                  padding: EdgeInsets.only(
                      left: media.width * .01,
                      right: media.width * .01,
                      top: media.width * .01),
                  margin: EdgeInsets.only(
                    left: media.width * .02,
                    right: media.width * .02,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.white,
                  ),
                  child: AnimatedOpacity(
                      duration: Duration(seconds: 2),
                      curve: Curves.easeIn,
                      opacity: prodVisi == true ? 1 : 0,
                      child: prods.length != 0
                          ? GridView.builder(
                              itemCount: prods == null ? 0 : prods.length,
                              addAutomaticKeepAlives: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
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
                                                1,
                                                prods[index]['id'])));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(.2),
                                              blurRadius: 4,
                                              spreadRadius: .5,
                                              offset: Offset(4, 1))
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Stack(
                                      children: <Widget>[
                                        Hero(
                                          tag: "mamad$index",
                                          child: Container(
                                            width: media.width,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        prods[index]['images']
                                                            [0]['src'])),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            foregroundDecoration: BoxDecoration(
                                                // color: Colors.white
                                                //     .withOpacity(.4),
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Hero(
                                            tag: "price - ${index}",
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  top: media.width * .012,
                                                  bottom: media.width * .012),
                                              width: media.width,
                                              decoration: BoxDecoration(
                                                  color: bluGrey,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  20),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  20))),
                                              child: Text(
                                                prods[index]['price'] +
                                                    " تومان",
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: TextStyle(
                                                    fontFamily: 'anjomanN',
                                                    color: Colors.white),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              })
                          : Container(
                              child: Center(
                                child: Text(
                                  progText,
                                  style: TextStyle(
                                      fontFamily: 'ir-sans',
                                      fontSize: media.width * .03),
                                ),
                              ),
                            ))),
            ),
            prodVisi != true && catVisi != true
                ? Container(
                    color: Colors.grey.withOpacity(.3),
                    alignment: Alignment.center,
                    child: Text(
                      "درحال دریافت اطلاعات جدید از سرور",
                      style: TextStyle(
                        fontFamily: 'ir-sans',
                        fontSize: media.width * .03,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
