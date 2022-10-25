import 'package:flutter/material.dart';
import 'package:aghayex/pages/flower/flowDetail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class flower extends StatefulWidget {
  @override
  _flowerState createState() => _flowerState();
  flower({Key key}) : super(key: key);
}

class _flowerState extends State<flower>
    with AutomaticKeepAliveClientMixin<flower> {
  final String flow_url = "http://peyk3soot.ir/flowItems.php";
  List flowItems = [];
  bool visi = false;

  PageController controller =
      PageController(viewportFraction: .75, keepPage: true);
  int current = 0;

  getflowData() async {
    var res = await http.post(flow_url);
    print("Response code: ${res.statusCode}");
    var resBody = json.decode(res.body);

    setState(() {
      flowItems = resBody["content"];
    });
    print("itemmmmmmmmmmms ::::::: /////");
    print(flowItems);
    setState(() {
      visi = true;
    });
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      int next = controller.page.round();

      if (current != next) {
        setState(() {
          current = next;
        });
      }
    });
    getflowData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        child: Center(
          child: AnimatedOpacity(
            opacity: visi ? 1 : 0,
            duration: Duration(milliseconds: 1200),
            curve: Curves.easeIn,
            child: PageView.builder(
                controller: controller,
                itemCount: flowItems.length,
                itemBuilder: (context, int index) {
                  bool active = index == current;
                  return buildPage(active, index);
                }),
          ),
        ),
      ),
    );
  }

  buildPage(bool active, int indexi) {
    var media = MediaQuery.of(context).size;
    final double blur = active ? 30 : 5;
    final double offset = active ? 10 : 4;
    final double top = active ? 100 : 200;
    final double rness = active ? .15 : .35;
    final double fSize = active ? media.width * .062 : 18;
    final Color shadow = active ? Colors.blue[300] : Colors.black;

    return AnimatedContainer(
        width: 150,
        height: 200,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
        margin: EdgeInsets.only(top: top, bottom: 50, left: 15, right: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: shadow,
                  blurRadius: blur,
                  offset: Offset(offset, offset))
            ]),
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => flowDetail(
                          flowItems[indexi]['flowImage'],
                          flowItems[indexi]['flowName'],
                          flowItems[indexi]['flowPrice'],
                          flowItems[indexi]['flowDiscount'],
                        )));
          },
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  foregroundDecoration:
                      BoxDecoration(color: Colors.black.withOpacity(rness)),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(flowItems[indexi]['flowImage']),
                          fit: BoxFit.cover)),
                ),
              ),
              flowItems[indexi]['flowDiscount'] != "0"
                  ? Positioned(
                      top: media.width * .03,
                      right: media.width * .03,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        child: Text(
                          flowItems[indexi]['flowDiscount'],
                          style: TextStyle(
                              fontSize: media.width * .027,
                              color: Colors.white,
                              fontFamily: 'ir-sans'),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                      ),
                    )
                  : Container(),
              Container(
                alignment: Alignment.bottomCenter,
                width: media.width,
                padding: EdgeInsets.only(bottom: media.width * .38),
                child: Text(
                  flowItems[indexi]['flowName'],
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: fSize,
                      fontFamily: 'ir-sans'),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                width: media.width,
                padding: EdgeInsets.only(bottom: media.width * .2),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    flowItems[indexi]['flowPrice'] + "تومان",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: fSize,
                        fontFamily: 'ir-sans'),
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(bottom: media.width * .045),
                  child: Container(
                    width: media.width * .2,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: LinearGradient(colors: [
                          Colors.cyan[400],
                          Colors.blue[800],
                        ])),
                    child: Text(
                      "خرید",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: media.width * .03,
                          fontFamily: 'ir-sans'),
                      textAlign: TextAlign.center,
                    ),
                  ))
            ],
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
