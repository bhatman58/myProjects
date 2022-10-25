import 'package:aghayex/models/disconnected.dart';
import 'package:aghayex/models/sharedPref.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectivity/connectivity.dart';

class order extends StatefulWidget {
  String code;
  @override
  _orderState createState() => _orderState();
  order(this.code);
}

class _orderState extends State<order> {
  TextEditingController prodC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController getternameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController getterphoneC = TextEditingController();
  TextEditingController getteraddressC = TextEditingController();
  var uh = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool con = true;
  var subscription;

  baller(context) {
    var media = MediaQuery.of(context).size;
    uh == 0
        ? Future.delayed(Duration(seconds: 3)).then((onValue) {
            _scaffoldKey.currentState.showSnackBar(
              new SnackBar(
                backgroundColor: Colors.blue,
                duration: Duration(seconds: 3),
                content: Container(
                  height: media.width * .06,
                  child: Center(
                    child: Text(
                      "تعداد ، نوع ، نام و مشخصات محصولات درخواستی را کامل شرح دهید",
                      style: TextStyle(
                          fontSize: media.width * .028,
                          color: Colors.black,
                          fontFamily: 'ir-sans'),
                      softWrap: true,
                    ),
                  ),
                ),
              ),
            );
            setState(() {
              uh = 1;
            });
          })
        : Container();
  }

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

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  void validator() {
    var media = MediaQuery.of(context).size;
    if (prodC.text.isEmpty ||
        nameC.text.isEmpty ||
        getternameC.text.isEmpty ||
        phoneC.text.isEmpty ||
        getterphoneC.text.isEmpty ||
        getteraddressC.text.isEmpty) {
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
              prodC.text,
              nameC.text,
              getternameC.text,
              phoneC.text,
              getterphoneC.text,
              getteraddressC.text,
              widget.code)));
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    baller(context);
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
          child: con
              ? SingleChildScrollView(
                  child: Container(
                      width: media.width,
                      height: media.height,
                      child: ListView(
                        children: <Widget>[
                          SizedBox(
                            height: media.width * .08,
                          ),
                          Filler(
                            "نام ، تعداد و مشخصات محصولات",
                            "نام و تعداد محصولات مورد نیاز",
                            Icons.text_format,
                            prodC,
                            1000,
                            TextInputAction.done,
                            TextInputType.text,
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
                            "شماره همراه گیرنده سفارش",
                            Icons.plus_one,
                            getterphoneC,
                            11,
                            TextInputAction.done,
                            TextInputType.number,
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
                                    "ثبت سفارش",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'ir-sans'),
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: media.width * .05,
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
                TextStyle(fontSize: media.width * .033, fontFamily: 'ir-sans'),
            labelText: label,
            labelStyle: TextStyle(
                color: Colors.cyan[800],
                fontSize: media.width * .035,
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
          style: TextStyle(color: Colors.black, fontFamily: 'ir-sans'),
        ),
      ),
    );
  }
}

class mamad extends StatefulWidget {
  String prodDesc, name, getterName, phone, getterPhone, getterAddress, code;
  mamad(
    this.prodDesc,
    this.name,
    this.getterName,
    this.phone,
    this.getterPhone,
    this.getterAddress,
    this.code,
  );
  @override
  _mamadState createState() => _mamadState();
}

class _mamadState extends State<mamad> {
  final String ord_url = "http://peyk3soot.ir/placeOrder.php";
  List result = [];
  final GlobalKey<ScaffoldState> _scccaffoldKey =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    sendOrdData() async {
      var res = await http.post(ord_url, body: {
        "order_desc": widget.prodDesc,
        "order_owner": widget.name,
        "getter_owner": widget.getterName,
        "owner_phone": widget.phone,
        "getter_phone": widget.getterPhone,
        "address": widget.getterAddress,
        "username": await sharedPref().getPrefs("username"),
        "code": widget.code
      });
      print("Response code: ${res.statusCode}");
      var resBody = json.decode(res.body);
      setState(() {
        result = resBody["content"];
      });
      _scccaffoldKey.currentState.showSnackBar(new SnackBar(
        content: Text(
          result[0]['success'] == "true"
              ? "با موفقیت ثبت شد"
              : "خطایی در ثبت به وجود آمد...مجددا تلاش کنید",
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'ir-sans'),
        ),
        backgroundColor:
            result[0]['success'] == "true" ? Colors.green : Colors.red,
      ));
      Future.delayed(Duration(milliseconds: 800))
          .then((onValue) => Navigator.of(context).pop());

      print(result);
    }

    var media = MediaQuery.of(context).size;
    return Scaffold(
        key: _scccaffoldKey,
        backgroundColor: Colors.white.withOpacity(.7),
        body: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Text(
                "آیا از صحت اطلاعات وارد شده اطمینان دارید؟\nدرصورت ارسال اطلاعات اشتباه ، محصولات به دست شما نخواهد رسید.\nپس از ثبت درخواست درصورت نیاز باشما \n تماس حاصل میشود",
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    fontSize: media.width * .033, fontFamily: 'ir-sans'),
                softWrap: true,
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
                    sendOrdData();
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
