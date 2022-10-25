import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/App/mainPage/viewModels/mainPageController.dart';
import 'package:movie_app/App/utils/AppColors.dart';

class BottomNavigationPhone extends GetResponsiveView {
  BottomNavigationPhone({Key? key,}) : super(key: key);

  MainPageController pageController = Get.find<MainPageController>();

  @override
  Widget? builder() {
    return Container(
      width: screen.width * .9,
      height: screen.height * .085,
      margin: EdgeInsets.symmetric(horizontal: screen.width * .045),
      decoration: const BoxDecoration(
          color: AppColors.phoneBottomNavBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, -5),
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(1.5),
            bottomRight: Radius.circular(1.5),
          )),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Obx(
          () =>
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            InkWell(
                onTap: () {
                  pageController.bottomNavigationSwitcher(0);
                },
                borderRadius: BorderRadius.circular(18),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.movie_creation_outlined,
                      color: pageController.navigationIndex.value == 0
                          ? AppColors.phoneBottomNavIconColor.withAlpha(230)
                          : Colors.grey.shade400,
                      size: screen.width * .075,
                    ),
                    Text(
                      'Home',
                      style: GoogleFonts.cinzel(
                          color: pageController.navigationIndex.value == 0
                              ? AppColors.phoneBottomNavIconColor.withAlpha(230)
                              : Colors.grey.shade400,
                          fontSize: screen.width * .028),
                    )
                  ],
                )),
            InkWell(
              onTap: () {
                pageController.bottomNavigationSwitcher(1);
              },
              borderRadius: BorderRadius.circular(18),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_rounded,
                    color: pageController.navigationIndex.value == 1
                        ? AppColors.phoneBottomNavIconColor.withAlpha(230)
                        : Colors.grey.shade400,
                    size: screen.width * .075,
                  ),
                  Text(
                    'Search',
                    style: GoogleFonts.cinzel(
                        color: pageController.navigationIndex.value == 1
                            ? AppColors.phoneBottomNavIconColor.withAlpha(230)
                            : Colors.grey.shade400,
                        fontSize: screen.width * .028),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                pageController.bottomNavigationSwitcher(2);
              },
              borderRadius: BorderRadius.circular(18),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              // overlayColor:MaterialStateProperty.resolveWith((states) => Colors.transparent)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    color: pageController.navigationIndex.value == 2
                        ? AppColors.phoneBottomNavIconColor.withAlpha(230)
                        : Colors.grey.shade400,
                    size: screen.width * .075,
                  ),
                  Text(
                    'Upcoming',
                    style: GoogleFonts.cinzel(
                        color: pageController.navigationIndex.value == 2
                            ? AppColors.phoneBottomNavIconColor.withAlpha(230)
                            : Colors.grey.shade400,
                        fontSize: screen.width * .028),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  // Widget CustomNavButton(
  //   final IconData icon,
  //   final Function onTap,
  // ) =>
  //     Material(
  //       color: Colors.transparent,
  //       child: InkWell(
  //         onTap: () {},
  //         borderRadius: BorderRadius.circular(18),
  //         splashColor: Colors.white,
  //         child: Icon(
  //           Icons.favorite_border,
  //           color: AppColors.phoneBottomNavIconColor,
  //           size: screen.width * .075,
  //         ),
  //       ),
  //     );
}
