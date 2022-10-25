import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/App/mainPage/viewModels/mainPageController.dart';
import 'package:movie_app/App/mainPage/views/phone/uiComponents/topPart/popularCard.dart';
import 'package:movie_app/App/utils/appColors.dart';

class MainPagePhoneTopPart extends GetResponsiveView {
  MainPagePhoneTopPart({Key? key}) : super(key: key);

  MainPageController pageController = Get.find<MainPageController>();

  @override
  Widget? builder() {
    return Material(
      color: Colors.transparent,
      child: Container(
          constraints: BoxConstraints(
              maxHeight: screen.height * .5, minHeight: screen.height * .5),
          padding: EdgeInsets.only(top: screen.width * .01),
          width: screen.width,
          height: screen.height * .5,
          child: Column(
            children: [
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Text('What\'s Popular',
                          style: GoogleFonts.cinzelDecorative(
                            fontSize: screen.width * .048,
                            letterSpacing: .2,
                            color: Colors.white,
                          )),
                    ),
                    Container(
                      height: screen.height * .055,
                      width: screen.width * .35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                            width: .4,
                            color: Colors.white,
                          )),
                      child: Center(
                        child: Obx(
                          (() => PageView(
                                onPageChanged: (index) {
                                  pageController.setWhatsPopular(index);
                                },
                                controller: PageController(
                                    initialPage: 0, viewportFraction: .45),
                                scrollDirection: Axis.vertical,
                                children: List.generate(
                                  pageController.sources.length,
                                  (index) => Center(
                                    child: AnimatedScale(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      scale: index ==
                                              pageController.selectedIndex.value
                                          ? screen.width * .003
                                          : screen.width * .0015,
                                      child: Text(pageController.sources[index],
                                          style: GoogleFonts.cinzelDecorative(
                                            letterSpacing: .2,
                                            color: index ==
                                                    pageController
                                                        .selectedIndex.value
                                                ? AppColors
                                                    .phoneBottomNavIconColor
                                                    .withAlpha(255)
                                                : Colors.grey,
                                          )),
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screen.height * .03),
              PopularCard(pageController: pageController)
            ],
          )),
    );
  }
}
