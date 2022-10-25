import 'package:flutter/material.dart';

class back1 extends StatelessWidget {
  var green = Color(0xFF94FBAB);
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var width = media.width;
    var height = media.height;
    return ClipPath(
      child: Container(height: width * .55, color: green //Colors.yellow[300],
          ),
      clipper: clipper(),
    );
  }
}

class clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width, size.height * .95);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

/* 
return Stack(
      children: <Widget>[
        Positioned(
          left: 20, //-(height / 2 - width / 2),
          bottom: height * .57,
          child: Container(
            width: height,
            height: height,
            decoration: BoxDecoration(
              color: Colors.yellow[200],
              shape: BoxShape.circle,
            ),
          ),
        )
      ],
    );
 */
