import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/App/detailsPage/bindings/detailsPageBindings.dart';
import 'package:movie_app/App/detailsPage/views/detailsPage.dart';
import 'package:movie_app/App/mainPage/viewModels/mainPageController.dart';
import 'package:movie_app/App/mainPage/views/phone/uiComponents/backgroundCircle.dart';

class DailyTrendingTv extends GetResponsiveView {
  DailyTrendingTv({Key? key}) : super(key: key);

  final MainPageController pageController = Get.find<MainPageController>();

  @override
  Widget? builder() {
    return Container(
      width: screen.width,
      // color: Colors.purple,
      // height: screen.height * .3,
      padding: EdgeInsets.symmetric(vertical: screen.height * .03),
      child: Obx(
        () => ListView.separated(
          key: const PageStorageKey<String>('dailyTrendingTv'),
          scrollDirection: Axis.horizontal,
          itemCount: pageController.dailyTrendingsTv.length,
          addAutomaticKeepAlives: true,
          separatorBuilder: ((context, index) => SizedBox(
                width: screen.width * .13,
              )),
          itemBuilder: (context, index) => Obx(
            () => Container(
              clipBehavior: Clip.hardEdge,
              // margin: EdgeInsets.only(right: screen.width * .13),
              width: screen.width * .57,
              height: screen.height * .2,
              decoration: BoxDecoration(
                  // color: index.isEven ? Colors.blue : Colors.red,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500${pageController.dailyTrendingsTv[index].posterPath}'))),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Get.to(
                      () => DetailsPage(),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 500),
                      binding: DetailsPageBinding(),
                      arguments: [
                        {
                          'id': pageController.dailyTrendingsTv[index].id!,
                          'isMovie': false,
                        }
                      ],
                    );
                  },
                  child: Stack(
                    children: [
                      BackgroundCircle(
                        voteAverage: (pageController
                            .dailyTrendingsTv[index].voteAverage),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: ClipRRect(
                            clipBehavior: Clip.hardEdge,
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                constraints: BoxConstraints(
                                    minHeight: screen.height * .08,
                                    maxHeight: screen.height * .11),
                                width: screen.width,
                                height: screen.height * .08,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  color: Colors.white70.withOpacity(.2),
                                ),
                                child: Flex(
                                    direction: Axis.vertical,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          pageController
                                              .dailyTrendingsTv[index].name
                                              .toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.visible,
                                          style: GoogleFonts.cinzel(
                                              color: Colors.black,
                                              fontSize: screen.width * .042,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
