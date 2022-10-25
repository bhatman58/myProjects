import 'package:flutter/material.dart';

class policy extends StatefulWidget {
  @override
  _policyState createState() => _policyState();
}

class _policyState extends State<policy> {
  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: wi * .05),
        child: Center(
            child: RichText(
          text: TextSpan(children: [
            TextSpan(
                text:
                    "قوانین وب/اپلیکیشن تیم آموزشی دانیال حق پرست\n همانطور که می دانید در این وبسایت ",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'ir-sans',
                    fontSize: wi * .03,
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text: "(Danielhaghparast.com)",
                style: TextStyle(
                  color: Colors.red[700],
                  fontSize: wi * .03,
                )),
            TextSpan(
                text:
                    """ قصد داریم جدید‌ترین و به روزترین مباحث مرتبط با آموزش کسب درآمد، ثروت و آرامش را با شما به اشتراک بگذاریم و در این راستا تلاش  های بسیاری تا به امروز انجام داده ایم. و با بررسی نتایج خانواده بزرگ خود میتوانیم با قاطعیت از عملکرد تیم در به ثمر رساندن بهترین موفقیت ها برای بسیاری از انسان ها صحبت کنیم. و برترین نکاتی که انسانها در زندگی برای رسیدن به موفقیت نیاز دارند را در اختیارشان قرار دهیم.

 

ایمان داریم و باور داریم که با این آموزه ها می توانید به هر آنچه که در ذهن و نظرتون دارید دست پیدا کنید

 
این وب سایت کاملاً در چارچوب قوانین جمهوری اسلامی ایران فعالیت می‌کند و رعایت کلیه قوانین در این سایت الزامی است. این قوانین دربرگیرنده فهرست مصادیق محتوای مجرمانه\n""",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: wi * .03,
                    fontFamily: 'ir-sans',
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text: "http://internet.ir/crime_index.html",
                style: TextStyle(
                  color: Colors.red[700],
                  fontSize: wi * .03,
                )),
            TextSpan(
                text: " میباشد ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: wi * .03,
                    fontFamily: 'ir-sans',
                    fontWeight: FontWeight.bold)),
          ]),
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
          // style: TextStyle(
          //     fontFamily: 'ir-sans',
          //     fontSize: wi * .03,
          //     fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
