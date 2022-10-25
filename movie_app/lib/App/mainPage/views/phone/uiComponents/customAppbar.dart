import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/App/mainPage/viewModels/mainPageController.dart';
import 'package:movie_app/App/utils/appColors.dart';

class CustomAppBar extends GetResponsiveView {
  CustomAppBar({Key? key}) : super(key: key);
  MainPageController pageController = Get.find<MainPageController>();

  @override
  Widget? builder() {
    return Obx(() {
      return Container(
        height: screen.height * .1,
        padding: EdgeInsets.only(
            left: screen.width * .05,
            right: screen.width * .05,
            top: screen.height * .027),
        color: AppColors.phoneBottomNavIconColor.withAlpha(230).withOpacity(
              (pageController.scrollOffset / 200).clamp(0, 1).toDouble(),
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // margin: EdgeInsets.only(top: screen.height * .02),
              child: Text(
                'Movience',
                style: GoogleFonts.satisfy(
                    fontSize: screen.width * .045,
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.phoneBottomNavIconColor.withAlpha(230)),
              ),
            ),
            // Material(
            //   borderRadius: BorderRadius.circular(25),
            //   color: Colors.transparent,
            //   child: InkWell(
            //     borderRadius: BorderRadius.circular(25),
            //     onTap: () => print('profile'),
            //     child: Container(
            //       // margin: EdgeInsets.only(top: screen.height * .02),
            //       padding: const EdgeInsets.all(5),
            //       decoration: BoxDecoration(
            //           shape: BoxShape.circle,
            //           border: Border.all(
            //             width: .6,
            //             color: Colors.white,
            //           )),
            //       child: Icon(
            //         Icons.person_sharp,
            //         size: screen.width * .07,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      );
    });
  }
}
