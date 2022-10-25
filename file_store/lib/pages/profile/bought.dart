import 'package:file_store/pages/profile/boughItems/docs.dart';
import 'package:file_store/pages/profile/boughItems/movies.dart';
import 'package:file_store/pages/profile/boughItems/pods.dart';
import 'package:flutter/material.dart';

class bought extends StatefulWidget {
  @override
  _boughtState createState() => _boughtState();
}

class _boughtState extends State<bought>
    with SingleTickerProviderStateMixin<bought> {
  TabController cont;
  Color hexi = Color(0xff2dab2e);
  Color hexi2 = Color(0xff3e9743);

  @override
  void initState() {
    super.initState();
    cont = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              title: Text(
                "محصولات خریداری شده",
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'ir-sans',
                  fontSize: media.width * .032,
                  fontWeight: FontWeight.w700,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 10,
              bottom: TabBar(
                indicatorColor: hexi, //Colors.green[400],
                indicatorSize: TabBarIndicatorSize.label,
                controller: cont,
                labelColor: hexi2, //Colors.blueGrey,
                unselectedLabelColor: Colors.grey[400],
                labelStyle: TextStyle(
                    fontFamily: 'ir-sans', fontSize: media.width * .028),
                tabs: <Widget>[
                  Tab(
                    icon: Icon(
                      Icons.subscriptions,
                    ),
                    text: "فیلم ها",
                  ),
                  Tab(
                    icon: Icon(
                      Icons.music_note,
                    ),
                    text: "پادکست",
                  ),
                  Tab(
                    icon: Icon(
                      Icons.insert_drive_file,
                    ),
                    text: "داکیومنت",
                  ),
                ],
              )),
          body: TabBarView(
            controller: cont,
            children: <Widget>[
              movies(),
              pods(),
              docs(),
            ],
          )),
    );
  }
}
