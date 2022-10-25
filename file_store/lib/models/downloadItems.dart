import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'package:file_store/pages/profile/bought.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:file_store/models/sharedPref.dart';
import 'package:file_store/env.dart';

class downloadItems extends StatefulWidget {
  int prodID;
  downloadItems({this.prodID});
  @override
  _downloadItemsState createState() => _downloadItemsState();
}

class _downloadItemsState extends State<downloadItems>
    with AutomaticKeepAliveClientMixin<downloadItems> {
  List downloads = [];
  int nums;
  String fileSize = "0";
  String done =
      "درحال دانلود و رمز نگاری فایلها ، لطفا صبور باشید\n و از بستن این صفحه خودداری نمایید.";
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  static String key = env.cons_key;
  static String sec = env.cons_sec;
  static String envUrl = env.url;

  getDownloadables() async {
    var downurl =
        "$envUrl/products/${widget.prodID}?consumer_key=$key&consumer_secret=$sec";

    var res = await http.get(
      downurl,
      headers: {"Content-Type": "application/json"},
    );
    print("Response code: ${res.statusCode}");
    var resBody = json.decode(res.body);

    downloads.add(resBody);
    setState(() {
      downloads = downloads[0]['downloads'];
      nums = downloads.length;
    });

    print("itemmmmmmmmmmms ::::::: /////");
    // print(downloads);
    downloadItems();
  }

  downloadItems() async {
    io.Directory dir = await getApplicationDocumentsDirectory();
    List<String> sundo = await sharedPref().getList("sundo") == null
        ? []
        : await sharedPref().getList("sundo");
    List<String> vundo = await sharedPref().getList("vundo") == null
        ? []
        : await sharedPref().getList("vundo");
    List<String> pundo = await sharedPref().getList("pundo") == null
        ? []
        : await sharedPref().getList("pundo");

    io.sleep(Duration(seconds: 2));

    downloads.forEach((i) async {
      if (i['file'].toLowerCase().endsWith('mp3') ||
          i['file'].toLowerCase().endsWith('aac') ||
          i['file'].toLowerCase().endsWith('amr') ||
          i['file'].toLowerCase().endsWith('m4a') ||
          i['file'].toLowerCase().endsWith('ogg') ||
          i['file'].toLowerCase().endsWith('raw') ||
          i['file'].toLowerCase().endsWith('voc') ||
          i['file'].toLowerCase().endsWith('wav') ||
          i['file'].toLowerCase().endsWith('wma')) {
        print("is a sound");

        if (io.Directory(dir.path + "/.archivo de sonido").existsSync()) {
          // print(dir.path + "/archivo de sonido" + "exists");
          // print("FILE NAME SPLITTED IS : " + fileName);
          io.File(dir.path + "/.archivo de sonido/" + ".nomedia").createSync();
          var res = await http.get(i['file']);

          setState(() {
            fileSize = res.headers['content-length'];
            print(fileSize);
          });

          // String fileName = basename(i['name']).split('.')[0];
          String fileName = i['name'];
          io.File("${dir.path}/.archivo de sonido/$fileName.cficrack")
              .writeAsBytesSync(res.bodyBytes, mode: io.FileMode.write);

          print("converting item ${i['file']}");
          sundo.add("${dir.path}/.archivo de sonido/$fileName.cficrack");
          await sharedPref().setList("sundo", sundo);
          setState(() {
            nums--;
            if (nums == 0) {
              setState(() {
                done = "دانلود به اتمام رسید ، درحال انتقال به صفحه اصلی";
              });
              io.sleep(Duration(milliseconds: 1800));
              navigatorKey.currentState
                  .pushReplacement(MaterialPageRoute(builder: (b) => bought()));
            }
          });
        } else {
          // print(dir.path + "/archivo de sonido" + "doesnt exist");
          io.Directory(dir.path + "/.archivo de sonido").createSync();
          print("created sounds Directory");
          io.File(dir.path + "/.archivo de sonido/" + ".nomedia").createSync();

          var res = await http.get(i['file']);

          setState(() {
            fileSize = res.headers['content-length'];
            print(fileSize);
          });

          // String fileName = basename(i['name']).split('.')[0];
          String fileName = i['name'];
          io.File("${dir.path}/.archivo de sonido/$fileName.cficrack")
              .writeAsBytesSync(res.bodyBytes, mode: io.FileMode.write);

          print("converting item ${i['file']}");
          sundo.add("${dir.path}/.archivo de sonido/$fileName.cficrack");
          await sharedPref().setList("sundo", sundo);
          setState(() {
            nums--;
            if (nums == 0) {
              setState(() {
                done = "دانلود به اتمام رسید ، درحال انتقال به صفحه اصلی";
              });
              io.sleep(Duration(milliseconds: 1800));
              navigatorKey.currentState
                  .pushReplacement(MaterialPageRoute(builder: (b) => bought()));
            }
          });
        }
      } else if (i['file'].toLowerCase().endsWith('webm') ||
          i['file'].toLowerCase().endsWith('mkv') ||
          i['file'].toLowerCase().endsWith('flv') ||
          i['file'].toLowerCase().endsWith('mp4') ||
          i['file'].toLowerCase().endsWith('avi') ||
          i['file'].toLowerCase().endsWith('mov') ||
          i['file'].toLowerCase().endsWith('mpeg') ||
          i['file'].toLowerCase().endsWith('wmv')) {
        print("is a vid");

        if (io.Directory(dir.path + "/.archivo de pelicula").existsSync()) {
          // print(dir.path + "/archivo de pelicula" + "exists");
          io.File(dir.path + "/.archivo de pelicula/" + ".nomedia").createSync();
          var res = await http.get(i['file']);

          setState(() {
            fileSize = res.headers['content-length'];
            print(fileSize);
          });

          // String fileName = basename(i['name']).split('.')[0];
          String fileName = i['name'];
          io.File("${dir.path}/.archivo de pelicula/$fileName.cficrack")
              .writeAsBytesSync(res.bodyBytes, mode: io.FileMode.write);

          print("converting item ${i['file']}");
          vundo.add("${dir.path}/.archivo de pelicula/$fileName.cficrack");
          await sharedPref().setList("vundo", vundo);
          setState(() {
            nums--;
            if (nums == 0) {
              setState(() {
                done = "دانلود به اتمام رسید ، درحال انتقال به صفحه اصلی";
              });
              io.sleep(Duration(milliseconds: 1800));
              navigatorKey.currentState
                  .pushReplacement(MaterialPageRoute(builder: (b) => bought()));
            }
          });
        } else {
          // print(dir.path + "/archivo de pelicula" + "doesnt exist");
          io.Directory(dir.path + "/.archivo de pelicula").createSync();
          print("created video Directory");
          io.File(dir.path + "/.archivo de pelicula/" + ".nomedia").createSync();

          var res = await http.get(i['file']);

          setState(() {
            fileSize = res.headers['content-length'];
            print(fileSize);
          });

          // String fileName = basename(i['name']).split('.')[0];
          String fileName = i['name'];
          io.File("${dir.path}/.archivo de pelicula/$fileName.cficrack")
              .writeAsBytesSync(res.bodyBytes, mode: io.FileMode.write);

          print("converting item ${i['file']}");
          vundo.add("${dir.path}/.archivo de pelicula/$fileName.cficrack");
          await sharedPref().setList("vundo", vundo);
          setState(() {
            nums--;
            if (nums == 0) {
              setState(() {
                done = "دانلود به اتمام رسید ، درحال انتقال به صفحه اصلی";
              });
              io.sleep(Duration(milliseconds: 1800));
              navigatorKey.currentState
                  .pushReplacement(MaterialPageRoute(builder: (b) => bought()));
            }
          });
        }
        // var res = await http.get(i['file']);
      } else if (i['file'].toLowerCase().endsWith('pdf')) {
        print("is a pdf");

        if (io.Directory(dir.path + "/.archivo extra").existsSync()) {
          // print(dir.path + "/archivo extra " + "exists");
          io.File(dir.path + "/.archivo extra/" + ".nomedia").createSync();

          var res = await http.get(i['file']);

          setState(() {
            fileSize = res.headers['content-length'];
            print(fileSize);
          });

          // String fileName = basename(i['name']).split('.')[0];
          String fileName = i['name'];
          io.File("${dir.path}/.archivo extra/$fileName.cficrack")
              .writeAsBytesSync(res.bodyBytes, mode: io.FileMode.write);

          print("converting item ${i['file']}");
          pundo.add("${dir.path}/.archivo extra/$fileName.cficrack");
          await sharedPref().setList("pundo", pundo);
          setState(() {
            nums--;
            if (nums == 0) {
              setState(() {
                done = "دانلود به اتمام رسید ، درحال انتقال به صفحه اصلی";
              });
              io.sleep(Duration(milliseconds: 1800));
              navigatorKey.currentState
                  .pushReplacement(MaterialPageRoute(builder: (b) => bought()));
            }
          });
        } else {
          // print(dir.path + "/archivo extra " + "doesnt exist");
          io.Directory(dir.path + "/.archivo extra").createSync();
          print("created pdf Directory");
          io.File(dir.path + "/.archivo extra/" + ".nomedia").createSync();

          var res = await http.get(i['file']);

          setState(() {
            fileSize = res.headers['content-length'];
            print(fileSize);
          });

          // String fileName = basename(i['name']).split('.')[0];
          String fileName = i['name'];
          io.File("${dir.path}/.archivo extra/$fileName.cficrack")
              .writeAsBytesSync(res.bodyBytes, mode: io.FileMode.write);

          print("converting item ${i['file']}");
          pundo.add("${dir.path}/.archivo extra/$fileName.cficrack");
          await sharedPref().setList("pundo", pundo);
          setState(() {
            nums--;
            if (nums == 0) {
              setState(() {
                done = "دانلود به اتمام رسید ، درحال انتقال به صفحه اصلی";
              });
              io.sleep(Duration(milliseconds: 1800));
              navigatorKey.currentState
                  .pushReplacement(MaterialPageRoute(builder: (b) => bought()));
            }
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getDownloadables();
  }

  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            width: wi,
            height: he,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                      "تعداد فایلهای درحال دانلود : \n ${nums == null ? 0 : nums}",
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'ir-sans',
                        fontSize: wi * .03,
                      )),
                ),
                SizedBox(
                  height: wi * .05,
                ),
                Container(
                  child: Text("حجم این فایل : \n $fileSize",
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'ir-sans',
                        fontSize: wi * .03,
                      )),
                ),
                SizedBox(
                  height: he * .14,
                ),
                Container(
                  child: Text(
                    done,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        color: nums == 0
                            ? Colors.green
                            : nums == null ? Colors.red : Colors.red,
                        fontFamily: 'ir-sans',
                        fontSize: wi * .03,
                        fontWeight: FontWeight.bold),
                  ),
                )
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
