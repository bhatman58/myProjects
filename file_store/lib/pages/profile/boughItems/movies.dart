import 'package:file_store/models/sharedPref.dart';
import 'package:file_store/models/videoPlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

class movies extends StatefulWidget {
  @override
  _moviesState createState() => _moviesState();
}

class _moviesState extends State<movies>
    with AutomaticKeepAliveClientMixin<movies> {
  List<String> movs = [];

  getData() async {
    List<String> tempi = [];
    tempi = await sharedPref().getList("vundo");
    setState(() {
      movs = tempi;
    });
    print("movs LIST : \n");
    print(movs.length);
    print(movs);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      body: SafeArea(
        child: Container(
            width: wi,
            height: he,
            child: movs != null
                ? Container(
                    height: he,
                    child: ListView.builder(
                      itemCount: movs == null ? 0 : movs.length,
                      itemBuilder: (contex, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (c) => videoPlay(
                                      vidPath: movs[index],
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
                                  // margin: EdgeInsets.only(left: wi * .1),
                                  child: Icon(
                                    Icons.play_circle_filled,
                                    size: wi * .1,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    child: Text(
                                      basename(movs[index]),
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
