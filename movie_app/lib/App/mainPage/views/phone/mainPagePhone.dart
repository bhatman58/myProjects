import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/App/mainPage/viewModels/mainPageController.dart';
import 'package:movie_app/App/upcomingPage/views/upcomingPage.dart';
import 'package:movie_app/App/mainPage/views/phone/phoneExporter.dart';
import 'package:movie_app/App/mainPage/views/phone/uiComponents/bottomPart/mainPagePhoneBottomPart.dart';
import 'package:movie_app/App/mainPage/views/phone/uiComponents/middlePart/mainPagePhoneMiddlePart.dart';
import 'package:movie_app/App/searchPage/views/searchPage.dart';

class MainPagePhone extends GetResponsiveView<MainPageController> {
  MainPagePhone({Key? key}) : super(key: key);


  @override
  Widget? builder() {
    return Scaffold(
      backgroundColor: AppColors.phoneMainBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size(screen.width, screen.height * .065),
        child: CustomAppBar(),
      ),
      body: Container(
          width: screen.width,
          height: screen.height,
          padding: EdgeInsets.symmetric(
            horizontal: screen.width * .05,
          ),
          child: PageView(
            onPageChanged: (index) =>
                controller.bottomNavigationOnpageChanged(index),
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.navigationController,
            children: [
              CustomScrollView(
                controller: controller.scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: MainPagePhoneTopPart(),
                  ),
                  SliverToBoxAdapter(
                    child: MainPagePhoneMiddlePart(),
                  ),
                  SliverToBoxAdapter(
                    child: MainPagePhoneBottomPart(),
                  ),
                ],
              ),
              SearchPage(),
              UpcomingPage()
            ],
          )),
      bottomNavigationBar: Get.mediaQuery.viewInsets.bottom != 0
          ? const SizedBox(
              width: 0,
              height: 0,
            )
          : BottomNavigationPhone(),
    );
  }
}
