import 'package:flutter/material.dart';

class back2 extends StatelessWidget {
  var green = Color(0xFF94FBAB);
  var bluGrey = Color(0xFF82ABA1);
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var width = media.width;
    var height = media.height;
    return Stack(
      children: <Widget>[
        Positioned(
          left: -(height / 2 - width / 2),
          bottom: height * .65,
          child: Container(
            width: height,
            height: height,
            decoration: BoxDecoration(
                color: green, //Colors.yellow[300],
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(.4),
                      blurRadius: 5,
                      spreadRadius: .3,
                      offset: Offset(1, 4))
                ]),
          ),
        ),
        // Positioned(
        //   right: 200, //-(height / 2 - width / 2),
        //   bottom: height * .7,
        //   child: Container(
        //     width: height / 1.5,
        //     height: height / 1.5,
        //     decoration: BoxDecoration(
        //       color: Colors.orange[600],
        //       shape: BoxShape.circle,
        //     ),
        //   ),
        // ),
        // Positioned(
        //   left: 350, //-(height / 2 - width / 2),
        //   bottom: height * .85,
        //   child: Container(
        //     width: height * .05,
        //     height: height * .05,
        //     decoration: BoxDecoration(
        //       color: Colors.orange[600],
        //       shape: BoxShape.circle,
        //     ),
        //   ),
        // ),
        // Positioned(
        //   left: 400, //-(height / 2 - width / 2),
        //   bottom: height * .8,
        //   child: Container(
        //     width: height * .05,
        //     height: height * .05,
        //     decoration: BoxDecoration(
        //       color: Colors.orange[600],
        //       shape: BoxShape.circle,
        //     ),
        //   ),
        // )
      ],
    );
  }
}
