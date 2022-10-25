import 'package:aghayex/models/sharedPref.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class flowItems extends StatefulWidget {
  @override
  _flowItemsState createState() => _flowItemsState();
}

class _flowItemsState extends State<flowItems>
    with AutomaticKeepAliveClientMixin<flowItems> {
  final String cust_url = "http://peyk3soot.ir/custItems.php";
  List cust_items = [];
  String text = "در حال دریافت اطلاعات از سرور";

  getCustData() async {
    var res = await http.post(cust_url, body: {
      "username": await sharedPref().getPrefs("username"),
      "code": "2"
    });
    print("Response code: ${res.statusCode}");
    var resBody = json.decode(res.body);

    setState(() {
      cust_items = resBody["content"];
      //visi = true;
    });
    print("itemmmmmmmmmmms ::::::: /////");
    print(cust_items);
    if (cust_items.isEmpty) {
      setState(() {
        text = "شما تا به حال سفارشی ثبت نکرده اید";
      });
    }
    // setState(() {
    //   visi = true;
    // });
  }

  @override
  void initState() {
    super.initState();
    getCustData();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          width: media.width,
          height: media.height,
          child: cust_items.length != 0
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(media.width * .02),
                      width: media.width,
                      constraints:
                          BoxConstraints(minHeight: media.height * .25),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5,
                                spreadRadius: 2,
                                color: Colors.grey[400])
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: media.width * .02),
                            padding: EdgeInsets.all(media.width * .01),
                            decoration: BoxDecoration(
                                color: Colors.cyan,
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              cust_items[index]['done'],
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'ir-sans'),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: media.width * .04,
                                  right: media.width * .04,
                                  bottom: media.width * .04,
                                  left: media.width * .04),
                              child: Text(
                                cust_items[index]['price'] + "تومان",
                                // "نمی‌توان زمان‌بندی دقیقی برای توقف خط تولید پراید اعلام کرد اما براساس برنامه‌های موجود باید خط تولید این خودرو متوقف شود." +
                                //     "رحمانی درباره اقدامات این وزارتخانه در بهبود وضعیت بازار اظهار داشت:" +
                                //     " اقدامات انجام گرفته و کسب سیاست‌های مناسب منجر به آرامش بازار شده است و شرایط بهتر نیز می‌شود، در واقع در حال حاضر شوک ناشی از تحریم تخلیه شده و بازار به ثبات نسبی رسیده است؛ وضعیت بازار بهتر از شرایط کنونی می‌شو" +
                                //     "وزیر صنعت، معدن و تجارت افزود:" +
                                //     " حفظ تولید موجود و افزایش میزان آن و در نتیجه عرضه بیشتر خودرو به بازار، شرایط را بهبود می‌بخشد.",

                                softWrap: true,
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(fontFamily: 'ir-sans'),
                                //overflow: TextOverflow.fade,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: media.width * .04,
                                  right: media.width * .04,
                                  bottom: media.width * .04,
                                  left: media.width * .04),
                              child: Text(
                                cust_items[index]['prodName'],
                                // "نمی‌توان زمان‌بندی دقیقی برای توقف خط تولید پراید اعلام کرد اما براساس برنامه‌های موجود باید خط تولید این خودرو متوقف شود." +
                                //     "رحمانی درباره اقدامات این وزارتخانه در بهبود وضعیت بازار اظهار داشت:" +
                                //     " اقدامات انجام گرفته و کسب سیاست‌های مناسب منجر به آرامش بازار شده است و شرایط بهتر نیز می‌شود، در واقع در حال حاضر شوک ناشی از تحریم تخلیه شده و بازار به ثبات نسبی رسیده است؛ وضعیت بازار بهتر از شرایط کنونی می‌شو" +
                                //     "وزیر صنعت، معدن و تجارت افزود:" +
                                //     " حفظ تولید موجود و افزایش میزان آن و در نتیجه عرضه بیشتر خودرو به بازار، شرایط را بهبود می‌بخشد.",

                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontFamily: 'ir-sans'),
                                //overflow: TextOverflow.fade,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: cust_items.length,
                )
              : Center(
                  child: Text(
                    text,
                    style: TextStyle(fontFamily: 'ir-sans'),
                  ),
                )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
