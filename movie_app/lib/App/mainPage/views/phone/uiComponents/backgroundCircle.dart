import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/App/mainPage/views/phone/phoneExporter.dart';

class BackgroundCircle extends GetResponsiveView {
  final double? voteAverage;
  BackgroundCircle({Key? key, double? this.voteAverage}) : super(key: key);

  @override
  Widget? builder() => Positioned(
        top: -(screen.height * .03),
        right: -(screen.width * .07),
        child: ClipRRect(
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(25),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: screen.width * .2,
              height: screen.width * .2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white70.withOpacity(.3),
              ),
              child: Stack(children: [
                Positioned(
                  bottom: screen.width * .044,
                  left: screen.width * .042,
                  child: Text(
                      voteAverage! == 0
                          ? 0.toString()
                          : voteAverage!.toStringAsFixed(1),
                      style: GoogleFonts.cinzelDecorative(
                        fontSize: screen.width * .045,
                        color: AppColors.phoneBottomNavIconColor.withAlpha(230),
                      )),
                ),
              ]),
            ),
          ),
        ),
      );
}
