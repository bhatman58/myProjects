import 'package:aghayex/pages/account/orders.dart';
import 'package:aghayex/pages/account/policy.dart';
import 'package:aghayex/pages/account/story.dart';
import 'package:aghayex/pages/account/support.dart';
import 'package:flutter/material.dart';

class account extends StatefulWidget {
  @override
  _accountState createState() => _accountState();
}

class _accountState extends State<account> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: media.width,
          height: media.height,
          margin: EdgeInsets.all(media.width * .022),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.blue[200],
                  blurRadius: 5,
                  spreadRadius: 4,
                )
              ],
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              item("سفارش های من", Icons.shopping_cart, 1),
              item("قوانین و مقررات", Icons.security, 2),
              item("تماس با ما", Icons.phone_in_talk, 3),
              item("درباره ما", Icons.border_color, 4),
            ],
          ),
        ),
      ),
    );
  }

  void validator(int id) {
    if (id == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (c) => orders()));
    } else if (id == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (c) => policy()));
    } else if (id == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (c) => support()));
    } else if (id == 4) {
      Navigator.push(context, MaterialPageRoute(builder: (c) => story()));
    }
  }

  Widget item(String title, IconData icon, int id) {
    var media = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        print(id);
        validator(id);
      },
      child: Container(
        margin: EdgeInsets.only(top: media.width * .02),
        padding:
            EdgeInsets.only(left: media.width * .02, right: media.width * .02),
        width: media.width * .75,
        height: media.width * .15,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.cyan[300],
            Colors.blue[600],
          ]),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              icon,
              size: media.width * .06,
              color: Colors.white,
            ),
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: media.width * .035,
                  fontFamily: 'ir-sans'),
            ),
          ],
        ),
      ),
    );
  }
}
