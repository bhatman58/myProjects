import 'package:file_store/models/acceptPayment.dart';
import 'package:file_store/models/sharedPref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class postDetail extends StatefulWidget {
  String imageUrl;
  String title;
  String price;
  String description;
  int index;
  int pagenum;
  int prodID;
  postDetail(
    this.imageUrl,
    this.title,
    this.price,
    this.description,
    this.index,
    this.pagenum,
    this.prodID,
  );
  @override
  _postDetailState createState() => _postDetailState();
}

class _postDetailState extends State<postDetail> {
  bool scrolling = false;
  String indi = "";
  var bluGrey = Color(0xFF82ABA1);
  String desc = "";

  void removeAllHtmlTags() {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    setState(() {
      desc = widget.description.replaceAll(exp, '');
    });
  }

  @override
  void initState() {
    super.initState();
    indi = widget.index.toString();
    removeAllHtmlTags();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return SafeArea(
      child: Scaffold(
        body: Container(
            width: media.width,
            height: media.height,
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                Hero(
                  tag: widget.pagenum == 1 ? "mamad$indi" : "page2$indi",
                  child: Container(
                    width: media.width,
                    height: media.height * .5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.4),
                            offset: Offset(1, 3),
                            blurRadius: 8,
                            spreadRadius: 1)
                      ],
                    ),
                    child: Image.network(
                      widget.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      left: media.width * .03,
                      top: media.width * .03,
                    ),
                    width: media.width * .08,
                    height: media.width * .08,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.7),
                        borderRadius: BorderRadius.circular(40)),
                    child: Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white70,
                        size: media.width * .05,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: media.width,
                    height: media.height * .55,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.3),
                              blurRadius: 8,
                              spreadRadius: .5,
                              offset: Offset(1, -3))
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60))),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Hero(
                              tag: widget.pagenum == 1
                                  ? "price - ${indi}"
                                  : "page-price$indi",
                              child: Container(
                                constraints:
                                    BoxConstraints(maxWidth: media.width * .4),
                                padding: EdgeInsets.all(media.width * .015),
                                margin: EdgeInsets.only(
                                    top: media.width * .075,
                                    left: media.width * .08),
                                decoration: BoxDecoration(
                                    color: bluGrey, //Colors.green[200],

                                    borderRadius: BorderRadius.circular(12)),
                                child: Text(
                                  widget.price + " تومان",
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      fontSize: media.width * .033,
                                      color: Colors.white,
                                      fontFamily: 'anjomanN'),
                                ),
                              ),
                            ),
                            Container(
                              constraints:
                                  BoxConstraints(maxWidth: media.width * .4),
                              margin: EdgeInsets.only(
                                  top: media.width * .075,
                                  right: media.width * .08),
                              child: Text(
                                widget.title,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontSize: media.width * .037,
                                    fontFamily: 'ir-sans',
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: media.width * .05,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTapDown: (s) {
                              setState(() {
                                scrolling = true;
                                print("$scrolling");
                              });
                            },
                            onTapUp: (p) {
                              setState(() {
                                scrolling = false;
                                print("$scrolling");
                              });
                            },
                            onTapCancel: () {
                              setState(() {
                                scrolling = false;
                                print("$scrolling");
                              });
                            },
                            child: SingleChildScrollView(
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: media.width * .035,
                                    right: media.width * .035),
                                child: Text(
                                  desc,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontFamily: 'ir-sans',
                                    fontSize: media.width * .035,
                                    height: 1.8,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (c) => acceptPayment(
                                prodId: widget.prodID, price: widget.price)));
                      },
                      child: Hero(
                        tag: "item",
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: media.width * .045,
                              left: media.width * .13,
                              right: media.width * .13),
                          width: media.width,
                          height: media.width * .12,
                          decoration: BoxDecoration(
                              color: scrolling
                                  ? Colors.green.withOpacity(.3)
                                  : Colors.green.withOpacity(1),
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Text(
                              "خرید این محصول",
                              style: TextStyle(
                                  fontFamily: 'ir-sans',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: media.width * .03),
                            ),
                          ),
                        ),
                      ),
                    ))
              ],
            )),
      ),
    );
  }
}
