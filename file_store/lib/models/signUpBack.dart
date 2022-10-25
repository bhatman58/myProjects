import 'package:flutter/material.dart';

class signUpBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var width = media.width;
    var height = media.height;
    return SafeArea(
      child: Scaffold(
        body: CustomPaint(
          child: Container(
            width: width,
            height: height,
            // color: Colors.blueGrey,
          ),
          painter: Customi(),
        ),
      ),
    );
  }
}

class Customi extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint();
    print(size);

    Path cyanPath = Path();
    cyanPath.lineTo(size.width, 0);
    cyanPath.lineTo(size.width, size.height * .68);
    cyanPath.quadraticBezierTo(
        size.width * .6, size.height * .7, size.width * .5, size.height);
    cyanPath.lineTo(0, size.height);
    cyanPath.close();
    paint.color = Colors.cyan[300];
    canvas.drawPath(cyanPath, paint);

    Path blueGray = Path();
    blueGray.lineTo(size.width, 0);
    blueGray.lineTo(size.width, size.height * .25);
    blueGray.quadraticBezierTo(size.width * .8, size.height * .55,
        size.width * .49, size.height * .535);
    blueGray.quadraticBezierTo(size.width * .3, size.height * .51,
        size.width * .22, size.height * .525);
    blueGray.quadraticBezierTo(
        size.width * .035, size.height * .555, 0, size.height * .65);
    blueGray.close();
    paint.color = Colors.blueGrey[700];
    canvas.drawPath(blueGray, paint);

    // Path cyanPath = Path();
    // cyanPath.lineTo(size.width, 0);
    // cyanPath.lineTo(size.width, size.height * .55);
    // cyanPath.quadraticBezierTo(size.width * .5, size.height * .6, 0, 0);
    // cyanPath.close();
    // paint.color = Colors.cyan;
    // canvas.drawPath(cyanPath, paint);

    // Path blueGrayPath = Path();
    // blueGrayPath.lineTo(size.width, 0);
    // blueGrayPath.lineTo(size.width, size.height * .15);
    // blueGrayPath.quadraticBezierTo(size.width * .75, size.height * .15,
    //     size.width * .68, size.height * .4);
    // blueGrayPath.quadraticBezierTo(size.width * .6, size.height * .6,
    //     size.width * .47, size.height * .619);
    // blueGrayPath.quadraticBezierTo(
    //     size.width * .25, size.height * .65, 0, size.height * .4);
    // blueGrayPath.close();
    // paint.color = Colors.blueGrey[700];
    // canvas.drawPath(blueGrayPath, paint);

    // Path orangePath = Path();
    // orangePath.lineTo(size.width * .65, 0);
    // orangePath.quadraticBezierTo(
    //     size.width * .55, size.width * .08, size.width * .35, size.width * .12);
    // orangePath.quadraticBezierTo(
    //     size.width * .15, size.width * .15, size.width * .09, size.width * .45);
    // orangePath.quadraticBezierTo(
    //     size.width * .04, size.height * .45, 0, size.height * .45);
    // orangePath.close();
    // paint.color = Colors.orange[300];
    // canvas.drawPath(orangePath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
