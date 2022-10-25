import 'package:aghayex/models/disconnected.dart';
import 'package:aghayex/pages/webView/webView.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class flowDetail extends StatefulWidget {
  @override
  _flowDetailState createState() => _flowDetailState();
  String url;
  String title;
  String price;
  String discount;
  flowDetail(this.url, this.title, this.price, this.discount);
}

class _flowDetailState extends State<flowDetail> {
  TextEditingController nameC = TextEditingController();
  TextEditingController getternameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController getterphoneC = TextEditingController();
  TextEditingController getteraddressC = TextEditingController();
  TextEditingController getterDescripC = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool con = true;
  var subscription;

  connected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        con = true;
      });
    } else {
      setState(() {
        con = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    connected();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == 'mobile' || result == 'wifi') {
        setState(() {
          con = true;
        });
      } else
        connected();
    });
  }

  void validator() {
    var media = MediaQuery.of(context).size;
    if (nameC.text.isEmpty ||
        getternameC.text.isEmpty ||
        phoneC.text.isEmpty ||
        getterphoneC.text.isEmpty ||
        getteraddressC.text.isEmpty ||
        getterDescripC.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        new SnackBar(
          backgroundColor: Colors.blue,
          duration: Duration(seconds: 3),
          content: Container(
            height: media.width * .06,
            child: Center(
              child: Text(
                "!از خالی گذاشتن فیلدها خودداری نمایید",
                style: TextStyle(
                    fontSize: media.width * .03,
                    color: Colors.black,
                    fontFamily: 'ir-sans'),
                softWrap: true,
              ),
            ),
          ),
        ),
      );
    } else {
      Navigator.of(context).push(PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) => mamad(
              nameC.text,
              getternameC.text,
              phoneC.text,
              getterphoneC.text,
              getteraddressC.text,
              widget.price,
              widget.title,
              getterDescripC.text)));
    }
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
              color: Colors.black,
              fontSize: media.width * .035,
              fontFamily: 'ir-sans'),
        ),
        iconTheme: IconThemeData.fallback(),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
          child: con
              ? SingleChildScrollView(
                  child: Container(
                      width: media.width,
                      height: media.height,
                      child: ListView(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                width: media.width,
                                height: media.height * .5,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[500],
                                          spreadRadius: 1,
                                          blurRadius: 4)
                                    ],
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15)),
                                    image: DecorationImage(
                                        image: NetworkImage(widget.url),
                                        fit: BoxFit.cover)),
                              ),
                              widget.discount != "0"
                                  ? Positioned(
                                      top: media.width * .03,
                                      right: media.width * .03,
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        child: Text(
                                          widget.discount,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: media.width * .027,
                                              fontFamily: 'ir-sans'),
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                            alignment: Alignment.center,
                            child: Text(
                              widget.title,
                              style: TextStyle(
                                  color: Colors.cyan[700],
                                  fontFamily: 'ir-sans'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                            alignment: Alignment.center,
                            child: Text(
                              widget.price + " تومان",
                              textDirection: TextDirection.rtl,
                              style: TextStyle(fontFamily: 'ir-sans'),
                            ),
                          ),
                          Filler(
                            "نام و نام خانوادگی سفارش دهنده",
                            "نام و نام خانوادگی سفارش دهنده",
                            Icons.text_format,
                            nameC,
                            100,
                            TextInputAction.done,
                            TextInputType.text,
                          ),
                          Filler(
                            "نام و نام خانوادگی گیرنده سفارش",
                            "نام و نام خانوادگی گیرنده سفارش",
                            Icons.text_format,
                            getternameC,
                            100,
                            TextInputAction.done,
                            TextInputType.text,
                          ),
                          Filler(
                            "09123456789",
                            "شماره همراه سفارش دهنده",
                            Icons.plus_one,
                            phoneC,
                            11,
                            TextInputAction.done,
                            TextInputType.number,
                          ),
                          Filler(
                            "09123456789",
                            "شماره همراه سفارش دهنده",
                            Icons.plus_one,
                            getterphoneC,
                            11,
                            TextInputAction.done,
                            TextInputType.number,
                          ),
                          Filler(
                            "مثال : عزیزم روزت مبارک",
                            "متن روی کارت تحویل گیرنده گُل",
                            Icons.card_membership,
                            getterDescripC,
                            200,
                            TextInputAction.done,
                            TextInputType.text,
                          ),
                          Filler(
                            "آدرس تحویل همراه باذکر پلاک و طبقه",
                            "آدرس کامل تحویل",
                            Icons.location_on,
                            getteraddressC,
                            200,
                            TextInputAction.done,
                            TextInputType.text,
                          ),
                          SizedBox(
                            height: media.width * .05,
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  left: media.width * .3,
                                  right: media.width * .3,
                                  bottom: media.width * .1),
                              width: media.width,
                              height: media.width * .1,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.blue[200],
                                        spreadRadius: 2,
                                        blurRadius: 4,
                                        offset: Offset(2, 2)),
                                  ],
                                  borderRadius: BorderRadius.circular(17),
                                  gradient: LinearGradient(colors: [
                                    Colors.cyan[300],
                                    Colors.blue[700],
                                  ])),
                              child: GestureDetector(
                                onTap: () {
                                  validator();
                                },
                                child: Center(
                                  child: Text(
                                    "پرداخت و ثبت",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: media.width * .031,
                                        fontFamily: 'ir-sans'),
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: media.width * .13,
                          ),
                        ],
                      )),
                )
              : disconnected()),
    );
  }

  Widget Filler(
      String hint,
      String label,
      IconData icon,
      TextEditingController controller,
      int length,
      TextInputAction action,
      TextInputType keytype) {
    var media = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: media.width * .08,
        right: media.width * .08,
        top: media.width * .05,
        //bottom: media.width * .05
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          textInputAction: action,
          controller: controller,
          maxLength: length,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                TextStyle(fontSize: media.width * .028, fontFamily: 'ir-sans'),
            labelText: label,
            labelStyle: TextStyle(
                color: Colors.cyan[800],
                fontSize: media.width * .033,
                fontFamily: 'ir-sans'),
            icon: Icon(icon),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.cyan[400],
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15)),
          ),
          cursorColor: Colors.cyan,
          keyboardType: keytype,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

class mamad extends StatefulWidget {
  String name,
      getterName,
      phone,
      getterPhone,
      getterAddress,
      price,
      prodName,
      description;
  mamad(
    this.name,
    this.getterName,
    this.phone,
    this.getterPhone,
    this.getterAddress,
    this.price,
    this.prodName,
    this.description,
  );
  @override
  _mamadState createState() => _mamadState();
}

class _mamadState extends State<mamad> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(.6),
        body: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Text(
                "آیا از صحت اطلاعات وارد شده اطمینان دارید؟",
                style: TextStyle(
                    fontSize: media.width * .033, fontFamily: 'ir-sans'),
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.only(
                    right: media.width * .3, bottom: media.width * .1),
                child: FloatingActionButton(
                  heroTag: "mamad",
                  foregroundColor: Colors.white,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => webView(
                                widget.name,
                                widget.getterName,
                                widget.phone,
                                widget.getterPhone,
                                widget.getterAddress,
                                widget.price,
                                widget.prodName,
                                widget.description)));
                  },
                  child: Icon(Icons.done),
                  backgroundColor: Colors.cyan[600],
                  elevation: 11,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: EdgeInsets.only(
                    left: media.width * .3, bottom: media.width * .1),
                child: FloatingActionButton(
                  heroTag: "sag",
                  foregroundColor: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.clear),
                  backgroundColor: Colors.red[600],
                  elevation: 11,
                ),
              ),
            )
          ],
        ));
  }
}
