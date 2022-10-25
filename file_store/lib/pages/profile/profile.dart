import 'package:file_store/pages/profile/bought.dart';
import 'package:file_store/pages/profile/contact.dart';
import 'package:file_store/pages/profile/policy.dart';
import 'package:file_store/pages/signupin/signupin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile>
    with AutomaticKeepAliveClientMixin<profile> {
  var bluGrey = Color(0xFF82ABA1);
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
        child: Center(
          child: Container(
            width: media.width * .8,
            height: media.height * .7,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[300],
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(1, 3)),
                  BoxShadow(
                      color: Colors.yellow.withOpacity(.2),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(2, 3)),
                ],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Container(
                    width: media.width,
                    height: media.width * .25,
                    decoration: BoxDecoration(
                        color: Colors.orange[200],
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/astro.jpeg"))),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: media.height * .104),
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage("assets/images/logo.png"),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(top: media.width * .25),
                    width: media.width * .6,
                    height: media.width * .55,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Role("محصولات خریداری شده", media, 1),
                        Role("تماس با ما", media, 2),
                        Role("قوانین و مقررات", media, 3),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Role(String text, media, int id) {
    return InkWell(
      onTap: () {
        id == 1
            ? Navigator.of(context)
                .push(MaterialPageRoute(builder: (s) => bought()))
            : id == 2
                ? Navigator.of(context)
                    .push(MaterialPageRoute(builder: (s) => contact()))
                : id == 3
                    ? Navigator.of(context)
                        .push(MaterialPageRoute(builder: (s) => policy()))
                    : Container();
      },
      child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: media.width * .03),
          padding: EdgeInsets.symmetric(
            horizontal: media.width * .03,
            vertical: media.width * .007,
          ),
          decoration: BoxDecoration(
              border:
                  Border.all(color: bluGrey /*Colors.orange[200]*/, width: .9),
              borderRadius: BorderRadius.circular(7)),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'ir-sans',
              fontSize: media.width * .028,
            ),
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
