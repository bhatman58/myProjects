import 'package:file_store/pages/search/search.dart';
import 'package:file_store/pages/prods/prods.dart';
import 'package:file_store/pages/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shifting_tabbar/shifting_tabbar.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: main_screen());
  }
}

class main_screen extends StatefulWidget {
  @override
  _main_screenState createState() => _main_screenState();
}

class _main_screenState extends State<main_screen>
    with SingleTickerProviderStateMixin<main_screen> {
  TabController cont;

  @override
  void initState() {
    super.initState();
    cont = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    var media = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Container(
          height: media.width * .13,
          child: ShiftingTabBar(
            color: Colors.white,
            labelFlex: .43,
            controller: cont,
            labelStyle: TextStyle(
                color: Colors.black87,
                fontSize: media.width * .026,
                fontFamily: 'ir-sans'),
            tabs: [
              ShiftingTab(
                  icon: Icon(
                    Icons.shop_two,
                    color: Colors.blueGrey,
                  ),
                  text: "محصولات"),
              ShiftingTab(
                  icon: Icon(
                    Icons.search,
                    color: Colors.blueGrey,
                  ),
                  text: "جستجو"),
              ShiftingTab(
                  icon: Icon(
                    Icons.person_outline,
                    color: Colors.blueGrey,
                  ),
                  text: "پروفایل"),
            ],
          ),
        ),
        body: TabBarView(
          controller: cont,
          children: <Widget>[
            prods(),
            search(),
            profile(),
          ],
        ));
  }
}
