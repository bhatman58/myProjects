import 'package:file_store/models/downloadItems.dart';
import 'package:file_store/models/webview.dart';
import 'package:flutter/material.dart';

class acceptPayment extends StatefulWidget {
  int prodId;
  String price;
  acceptPayment({this.prodId, this.price});
  @override
  _acceptPaymentState createState() => _acceptPaymentState();
}

class _acceptPaymentState extends State<acceptPayment> {
  String deltext = "";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200)).then((v) {
      setState(() {
        deltext =
            "توجه داشته باشید که پس از پرداخت وجه ، \n فایلها بصورت خوردکار دانلود شده و به دلایل امنیتی امکان \n متوقف کردن آنها نمیباشد.\n درصورت اتصال به wifi یا اینترنت با حجم بالا برای ادامه روند پرداخت اقدام کنید";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Hero(
        tag: "item",
        child: Container(
          width: wi,
          height: he,
          color: Colors.green,
          child: Stack(
            children: <Widget>[
              Center(
                child: Container(
                  child: Text(
                    deltext,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'ir-sans',
                        fontSize: wi * .04,
                        shadows: [
                          Shadow(
                              color: Colors.black.withOpacity(.4),
                              blurRadius: 4,
                              offset: Offset(1, 1))
                        ]),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    margin: EdgeInsets.only(bottom: wi * .1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.redAccent,
                          elevation: 15,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "باشه ، فعلا نه",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'ir-sans',
                                fontSize: wi * .03),
                          ),
                        ),
                        RaisedButton(
                          color: Colors.green[800],
                          elevation: 15,
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (c) =>
                                        webview(prodID: widget.prodId,price:widget.price)));
                          },
                          child: Text(
                            "آماده ام ، بریم",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'ir-sans',
                                fontSize: wi * .03),
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
