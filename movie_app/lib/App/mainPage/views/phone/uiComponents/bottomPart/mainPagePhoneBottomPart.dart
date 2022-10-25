import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/App/mainPage/viewModels/mainPageController.dart';
import 'package:movie_app/App/mainPage/views/phone/uiComponents/bottomPart/dailyTrendingTv.dart';
import 'package:movie_app/App/mainPage/views/phone/uiComponents/bottomPart/weeklyTrendingTv.dart';
import 'package:movie_app/App/utils/appColors.dart';

class MainPagePhoneBottomPart extends GetResponsiveView {
  MainPagePhoneBottomPart({Key? key}) : super(key: key);

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
                      child: Text('Trending On TV',
                          style: GoogleFonts.cinzelDecorative(
                            fontSize: screen.width * .048,
                            letterSpacing: .2,
                            color: Colors.white,
                          )),
                    ),
                    SizedBox(
                      width: screen.width * .03,
                    ),
                    Container(
                      constraints: BoxConstraints(
                        // maxWidth: screen.width * .7,
                        maxHeight: screen.height * .035,
                      ),
                      // width: screen.width * .5,
                      alignment: Alignment.centerRight,
                      // height: screen.height * .035,
                      // color: Colors.red,
                      child: TabBar(
                          onTap: (ind) {
                            if (ind == 0 &&
                                pageController.dailyTrendingsTv.isEmpty) {
                              print('daily was empty , called method');
                              pageController.getTrendingMainPageTv('day');
                            } else if (ind == 1 &&
                                pageController.weeklyTrendingsTv.isEmpty) {
                              print('week empty ');
                              pageController.getTrendingMainPageTv('week');
                            }
                          },
                          physics: const NeverScrollableScrollPhysics(),
                          controller: pageController.tvTController,
                          overlayColor: MaterialStateColor.resolveWith(
                              (states) => Colors.transparent),
                          unselectedLabelStyle:
                              GoogleFonts.cinzel(fontSize: screen.width * .035),
                          labelStyle: GoogleFonts.cinzel(
                            fontSize: screen.width * .035,
                          ),
                          labelColor:
                              AppColors.phoneBottomNavIconColor.withAlpha(230),
                          unselectedLabelColor: Colors.white,
                          isScrollable: true,
                          indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: AppColors.phoneBottomNavIconColor
                                      .withAlpha(230)),
                              insets: EdgeInsets.symmetric(
                                  horizontal: screen.width * .06)),
                          indicatorColor:
                              AppColors.phoneBottomNavIconColor.withAlpha(230),
                          // indicatorSize: TabBarIndicatorSize.label,
                          tabs: const [
                            Tab(
                              text: 'Daily',
                            ),
                            Tab(
                              text: 'Weekly',
                            )
                          ]),
                    )
                  ],
                ),
              ),
              SizedBox(height: screen.height * .03),
              Expanded(
                  child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: pageController.tvTController,
                      children: [DailyTrendingTv(), WeeklyTrendingTv()]))
            ],
          )),
    );
  }
}
