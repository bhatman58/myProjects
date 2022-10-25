import 'dart:io' as io;
import 'package:file_store/models/audioPlay.dart';
import 'package:file_store/models/sharedPref.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class pods extends StatefulWidget {
  @override
  _podsState createState() => _podsState();
}

class _podsState extends State<pods> with AutomaticKeepAliveClientMixin<pods> {
  List<String> pods = [];

  getData() async {
    List<String> tempi = [];
    tempi = await sharedPref().getList("sundo");
    setState(() {
      pods = tempi;
    });
    print("PODS LIST : \n");
    print(pods.length);
    print(pods);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
            width: wi,
            height: he,
            child: pods != null
                ? Container(
                    height: he,
                    child: ListView.builder(
                      itemCount: pods == null ? 0 : pods.length,
                      itemBuilder: (contex, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (c) => audioPlay(
                                      audioPath: pods[index],
                                      audioName: basename(pods[index]),
                                    )));
                          },
                          child: Container(
                            width: wi,
                            height: he * .2,
                            margin: EdgeInsets.all(wi * .02),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(.4),
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                      offset: Offset(1, 3))
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  child: Icon(
                                    Icons.play_circle_filled,
                                    size: wi * .1,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    child: Text(
                                      basename(pods[index]),
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          fontFamily: 'ir-sans',
                                          fontWeight: FontWeight.bold,
                                          fontSize: wi * .025),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Container(
                    child: Center(
                      child: Text(
                        "محصولی برای نمایش موجود نیست",
                        style: TextStyle(
                          fontFamily: 'ir-sans',
                          fontSize: wi * .03,
                        ),
                      ),
                    ),
                  )),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
