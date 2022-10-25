import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/App/detailsPage/bindings/detailsPageBindings.dart';
import 'package:movie_app/App/detailsPage/views/detailsPage.dart';
import 'package:movie_app/App/mainPage/viewModels/mainPageController.dart';
import 'package:movie_app/App/utils/appColors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PopularCard extends GetResponsiveView {
  final MainPageController pageController;

  PopularCard({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget? builder() {
    final double focusedPVItemTopBottomOffset = screen.height * .02;
    final double unfocusedPVItemTopBottomOffset = screen.height * .05;
    final double focusedPVItemRightOffset = screen.width * .09;
    final double unfocusedPVItemRightOffset = screen.width * .07;
    return Expanded(
        child: LayoutBuilder(
      builder: ((context, constraints) => Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            // padding: EdgeInsets.only(left: screen.width * .09),
            // color: Colors.cyan,
            child: OverflowBox(
              maxWidth: screen.width,
              child: Obx(
                () => PageView.builder(
                  onPageChanged: (ind) {
                    // print(ind);
                    pageController
                        .whatsPopularMoviesPageviewIndexController(ind);
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: pageController.isStreaming.value
                      ? pageController.movies.length
                      : pageController.tvs.length,
                  padEnds: false,
                  controller:
                      ////////  MAIN PAGE CONTROLLER
                      PageController(initialPage: 0, viewportFraction: .7),
                  itemBuilder: (context, index) => Obx(
                    () {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 350),
                        margin: EdgeInsets.only(
                          top:
                              index == pageController.selectedMoviePVIndex.value
                                  ? focusedPVItemTopBottomOffset
                                  : unfocusedPVItemTopBottomOffset,
                          bottom:
                              index == pageController.selectedMoviePVIndex.value
                                  ? focusedPVItemTopBottomOffset
                                  : unfocusedPVItemTopBottomOffset,
                          right:
                              index == pageController.selectedMoviePVIndex.value
                                  ? focusedPVItemRightOffset
                                  : unfocusedPVItemRightOffset,
                          left: screen.width * .05,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(pageController
                                        .isStreaming.value
                                    ? 'https://image.tmdb.org/t/p/w500${pageController.movies[index].posterPath}'
                                    : 'https://image.tmdb.org/t/p/w500${pageController.tvs[index].posterPath}'))),
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 350),
                          opacity:
                              index == pageController.selectedMoviePVIndex.value
                                  ? 1
                                  : 0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  // pageController.detailsPage();
                                  pageController.isStreaming.value
                                      // ? print(pageController.movies[index].id!)
                                      ? Get.to(
                                          () => DetailsPage(),
                                          transition: Transition.rightToLeft,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          binding: DetailsPageBinding(),
                                          arguments: [
                                            {
                                              'id': pageController
                                                  .movies[index].id!,
                                              'isMovie': pageController
                                                  .isStreaming.value,
                                            }
                                          ],
                                        )
                                      : Get.to(
                                          () => DetailsPage(),
                                          transition: Transition.rightToLeft,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          arguments: [
                                            {
                                              "id":
                                                  pageController.tvs[index].id!,
                                              'isMovie': pageController
                                                  .isStreaming.value
                                            }
                                          ],
                                        );
                                },
                                child: Obx(
                                  () => Stack(children: [
                                    ////////// POPULARITY INDEX
                                    Positioned(
                                      top: screen.height * .02,
                                      right: screen.width * .025,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 6, sigmaY: 6),
                                          child: Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(
                                                  screen.width * .02),
                                              decoration: BoxDecoration(
                                                  color: Colors.white
                                                      .withOpacity(.2),
                                                  borderRadius: BorderRadius.circular(
                                                      10)),
                                              child: CircularPercentIndicator(
                                                  radius: screen.width * .042,
                                                  lineWidth: 2,
                                                  curve: Curves.bounceInOut,
                                                  animation: true,
                                                  progressColor: AppColors
                                                      .phoneBottomNavIconColor
                                                      .withAlpha(230),
                                                  animationDuration: 1000,
                                                  percent: pageController.isStreaming.value
                                                      ? (pageController
                                                              .movies[index]
                                                              .voteAverage!) /
                                                          10.toDouble()
                                                      : (pageController
                                                              .tvs[index]
                                                              .voteAverage!) /
                                                          10.toDouble(),
                                                  center: Text(pageController.isStreaming.value ? pageController.movies[index].voteAverage.toString() : pageController.tvs[index].voteAverage.toString(),
                                                      style: GoogleFonts.cinzelDecorative(fontSize: screen.width * .04)),
                                                  footer: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: screen.height *
                                                            .01),
                                                    child: Text("Popularity",
                                                        style:
                                                            GoogleFonts.cinzel(
                                                                fontSize: screen
                                                                        .width *
                                                                    .019,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                  ))),
                                        ),
                                      ),
                                    ),
                                    ////////// NAME AND GENRES
                                    Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20)),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 8, sigmaY: 8),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                maxWidth: screen.width,
                                                maxHeight: screen.height * .13,
                                                minHeight: screen.height * .11,
                                              ),
                                              padding: EdgeInsets.all(
                                                  screen.width * .025),
                                              decoration: BoxDecoration(
                                                  color: Colors.white
                                                      .withOpacity(.2),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  20),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  20))),
                                              child: Wrap(children: [
                                                Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          child: Flexible(
                                                            child: Text(
                                                              pageController
                                                                      .isStreaming
                                                                      .value
                                                                  ? pageController
                                                                      .movies[
                                                                          index]
                                                                      .title
                                                                      .toString()
                                                                  : pageController
                                                                      .tvs[
                                                                          index]
                                                                      .name
                                                                      .toString(),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: GoogleFonts.cinzel(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      screen.width *
                                                                          .038,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      width: screen.width,
                                                      height:
                                                          screen.height * .065,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: screen
                                                                      .height *
                                                                  .013),
                                                      // color: Colors.red,
                                                      child: ListView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        children: List.generate(
                                                            pageController
                                                                    .isStreaming
                                                                    .value
                                                                ? pageController
                                                                    .innerGenres[
                                                                        index]
                                                                    .length
                                                                : pageController
                                                                    .innerTVGenres[
                                                                        index]
                                                                    .length,
                                                            (indi) {
                                                          return Container(
                                                            constraints:
                                                                BoxConstraints(
                                                                    minWidth:
                                                                        screen.width *
                                                                            .1),
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        screen.width *
                                                                            .02),
                                                            margin: EdgeInsets.only(
                                                                right: screen
                                                                        .width *
                                                                    .02),
                                                            alignment: Alignment
                                                                .center,
                                                            decoration: BoxDecoration(
                                                                color: AppColors
                                                                    .phoneBottomNavIconColor
                                                                    .withAlpha(
                                                                        230),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            child: Text(
                                                              pageController
                                                                      .isStreaming
                                                                      .value
                                                                  ? pageController
                                                                          .innerGenres[
                                                                              index]
                                                                          .asMap()[
                                                                      indi]
                                                                  : pageController
                                                                      .innerTVGenres[
                                                                          index]
                                                                      .asMap()[indi],
                                                              style: GoogleFonts
                                                                  .cinzelDecorative(),
                                                            ),
                                                          );
                                                        }),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ]),
                                            ),
                                          ),
                                        ))
                                  ]),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          )),
    ));
  }
}
