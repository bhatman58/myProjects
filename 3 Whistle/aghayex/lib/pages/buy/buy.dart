import 'package:flutter/material.dart';
import 'package:aghayex/pages/order/order.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:aghayex/models/sharedPref.dart';

class buy extends StatefulWidget {
  @override
  _buyState createState() => _buyState();
  buy({Key key}) : super(key: key);
}

class _buyState extends State<buy> with AutomaticKeepAliveClientMixin<buy> {
  final String buy_url = "http://peyk3soot.ir/buyItems.php";
  List buy_items = [];
  List<String> images = [
    "assets/images/oil.png",
    "assets/images/cheese.png",
    "assets/images/diet.png",
    "assets/images/apple.png",
    "assets/images/cake.png",
    "assets/images/medicine.png",
    "assets/images/toast.png",
    "assets/images/makeup.png",
    "assets/images/tools.png",
    "assets/images/fish.png",
    "assets/images/fertilizer.png",
    "assets/images/meat.png",
    "assets/images/burger.png",
    "assets/images/basket.png",
  ];
  bool visi = false;

  getBuyData() async {
    var res = await http.post(buy_url);
    print("Response code: ${res.statusCode}");
    var resBody = json.decode(res.body);

    setState(() {
      buy_items = resBody["content"];
      visi = true;
    });
    print("itemmmmmmmmmmms ::::::: /////");
    print(buy_items);
    setState(() {
      visi = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getBuyData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var media = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
              width: media.width,
              height: media.height,
              child: AnimatedOpacity(
                opacity: visi ? 1 : 0,
                curve: Curves.easeIn,
                duration: Duration(milliseconds: 1500),
                child: GridView.builder(
                  itemCount: buy_items.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.all(media.width * .025),
                      child: row(index, images[index]),
                    );
                  },
                ),
              )),
        ));
  }

  Widget row(int index, String path) {
    var media = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (c) => order("1")));
      },
      child: Container(
        height: media.height * .25,
        width: media.width * .38,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[400],
                  spreadRadius: 2,
                  offset: Offset(2, 2),
                  blurRadius: 4)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: media.width * .15,
              height: media.width * .2,
              child: Image.asset(path),
            ),
            Container(
              child: Center(
                child: Text(
                  buy_items[index]['itemName'],
                  style: TextStyle(
                      fontSize: media.width * .033, fontFamily: 'ir-sans'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

// return Scaffold(
//         resizeToAvoidBottomPadding: false,
//         body: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Container(
//             width: media.width,
//             height: media.height,
//             child: Column(
//               children: <Widget>[
//                 Container(
//                   margin: EdgeInsets.only(top: 15),
//                   width: media.width * .85,
//                   height: media.width * .61,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.only(
//                           topRight: Radius.circular(25),
//                           bottomLeft: Radius.circular(25)),
//                       boxShadow: [
//                         BoxShadow(
//                             color: Colors.blue[200],
//                             blurRadius: 10,
//                             spreadRadius: 4,
//                             offset: Offset(3, 4))
//                       ]),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Container(
//                         padding: EdgeInsets.all(media.width * .04),
//                         child: Directionality(
//                           textDirection: TextDirection.rtl,
//                           child: TextField(
//                             controller: orderCont,
//                             decoration: InputDecoration(
//                                 hintText:
//                                     "!نام ، تعداد و مشخصات محصول خود را وارد کنید"),
//                             cursorColor: Colors.cyan,
//                             keyboardType: TextInputType.text,
//                             textInputAction: TextInputAction.newline,
//                             maxLines: 2,
//                             style: TextStyle(color: Colors.black),
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => order(orderCont.text,"1")));
//                         },
//                         child: Container(
//                           margin: EdgeInsets.only(top: 10),
//                           width: media.width * .65,
//                           height: media.width * .085,
//                           decoration: BoxDecoration(
//                               boxShadow: [
//                                 BoxShadow(
//                                     color: Colors.grey[400],
//                                     blurRadius: 12,
//                                     spreadRadius: 1,
//                                     offset: Offset(1, 1))
//                               ],
//                               gradient: LinearGradient(colors: [
//                                 Colors.cyan[300],
//                                 Colors.blue[500],
//                               ]),
//                               borderRadius: BorderRadius.circular(20)),
//                           child: Center(
//                             child: Text(
//                               "مرحله بعد",
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(
//                       top: media.width * .08,
//                       left: media.width * .28,
//                       right: media.width * .28),
//                   padding: EdgeInsets.only(
//                     top: media.width * .013,
//                     bottom: media.width * .013,
//                   ),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(40),
//                       gradient: LinearGradient(
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                           colors: [
//                             Colors.blue[200],
//                             Colors.purple[100],
//                             // Colors.blue[100],
//                           ])),
//                   child: Center(
//                     child: Text(
//                       "محصولات قابل سفارش",
//                       style: TextStyle(
//                           fontSize: media.width * .028,
//                           fontWeight: FontWeight.w600,
//                           shadows: [
//                             Shadow(
//                                 color: Colors.grey[600],
//                                 blurRadius: 2,
//                                 offset: Offset(2, 2.5))
//                           ]),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Container(
//                     width: media.width,
//                     height: media.height * .4,
//                     margin: EdgeInsets.only(
//                       right: media.width * .069,
//                       top: media.width * .06,
//                     ),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius:
//                             BorderRadius.only(topRight: Radius.circular(35)),
//                         boxShadow: [
//                           BoxShadow(
//                               color: Colors.blue[300],
//                               blurRadius: 10,
//                               spreadRadius: 4,
//                               offset: Offset(3, 4))
//                         ]),
//                     child: AnimatedOpacity(
//                       opacity: visi ? 1 : 0,
//                       duration: Duration(seconds: 2),
//                       curve: Curves.easeIn,
//                       child: Container(
//                           width: media.width,
//                           height: media.height * .37,
//                           constraints:
//                               BoxConstraints(maxHeight: media.height * .39),
//                           margin: EdgeInsets.only(
//                               right: media.width * .088,
//                               left: media.width * .15,
//                               top: media.width * .05),
//                           child: buy_items.length != 0
//                               ? ListView.builder(
//                                   addAutomaticKeepAlives: true,
//                                   itemBuilder: (context, index) {
//                                     return Container(
//                                       margin:
//                                           EdgeInsets.only(top: 10, bottom: 10),
//                                       padding:
//                                           EdgeInsets.only(top: 13, bottom: 13),
//                                       child: Center(
//                                         child: Text(
//                                             buy_items[index]['itemName'],
//                                             style: TextStyle(
//                                                 fontSize: media.width * .03)),
//                                       ),
//                                       decoration: BoxDecoration(
//                                           gradient: LinearGradient(colors: [
//                                             Colors.cyan[300],
//                                             Colors.blue[500],
//                                           ]),
//                                           borderRadius:
//                                               BorderRadius.circular(30),
//                                           boxShadow: [
//                                             BoxShadow(
//                                                 color: Colors.grey,
//                                                 offset: Offset(.5, 3),
//                                                 blurRadius: 3,
//                                                 spreadRadius: 1)
//                                           ],
//                                           border: Border.all(width: .1)),
//                                     );
//                                   },
//                                   itemCount: buy_items.length,
//                                 )
//                               : Container(
//                                   alignment: Alignment.center,
//                                   child: Text("درحال دریافت اطلاعات"),
//                                 )),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ));
