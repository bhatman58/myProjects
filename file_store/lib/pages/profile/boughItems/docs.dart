import 'package:file_store/models/pdfViewer.dart';
import 'package:file_store/models/sharedPref.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class docs extends StatefulWidget {
  @override
  _docsState createState() => _docsState();
}

class _docsState extends State<docs> with AutomaticKeepAliveClientMixin<docs> {
  List<String> pofs = [];

  getData() async {
    List<String> tempi = [];
    tempi = await sharedPref().getList("pundo");
    setState(() {
      pofs = tempi;
    });
    print("pofs LIST : \n");
    // print(pofs.length);
    print(pofs);
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
            child: pofs != null
                ? Container(
                    height: he,
                    child: ListView.builder(
                      itemCount: pofs != null ? pofs.length : 0,
                      itemBuilder: (contex, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (c) => pdfViewer(
                                      pdfPath: pofs[index],
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
                                      basename(pofs[index]),
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
