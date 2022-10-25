import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/App/detailsPage/viewModels/detailsPageController.dart';
import 'package:movie_app/App/mainPage/views/phone/phoneExporter.dart';
import 'package:movie_app/App/utils/configs.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:math';

class DetailsPage extends GetResponsiveView<DetailsPageController> {
  DetailsPage({
    Key? key,
  }) : super(key: key);

  var args = Get.arguments;

  @override
  Widget? builder() {
    return Scaffold(
      backgroundColor: AppColors.phoneMainBackgroundColor,
      body: Container(
        width: screen.width,
        height: screen.height,
        child: Obx(
          () => controller.movieDetail.value.title != null ||
                  controller.tvDetail.value.name != null
              ? ListView(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      child: Container(
                        width: screen.width,
                        height: screen.height * .45,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(args[0]['isMovie']
                                    ? '${Configs.backDropPath}${controller.movieDetail.value.backdropPath}'
                                    : '${Configs.backDropPath}${controller.tvDetail.value.backdropPath}'))),
                        child: Stack(children: [
                          Container(
                            width: screen.width,
                            height: screen.height,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  stops: const [
                                    .2,
                                    .4,
                                  ],
                                  colors: [
                                    Colors.black.withOpacity(.5),
                                    Colors.transparent
                                  ]),
                            ),
                          ),
                          Positioned(
                              top: screen.height * .02,
                              left: screen.width * .02,
                              child: Material(
                                color: AppColors.phoneBottomNavBackgroundColor
                                    .withAlpha(230),
                                borderRadius: BorderRadius.circular(25),
                                child: InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  borderRadius: BorderRadius.circular(25),
                                  child: Container(
                                    padding: EdgeInsets.all(screen.width * .02),
                                    child: Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      size: screen.width * .05,
                                      color: AppColors.phoneBottomNavIconColor,
                                    ),
                                  ),
                                ),
                              )),
                          Positioned(
                              top: screen.height * .02,
                              right: screen.width * .02,
                              child: Material(
                                color: AppColors.phoneBottomNavBackgroundColor
                                    .withAlpha(230),
                                borderRadius: BorderRadius.circular(25),
                                child: InkWell(
                                  onTap: () {
                                    // MAKE IT FAVORITE
                                  },
                                  borderRadius: BorderRadius.circular(25),
                                  child: Padding(
                                    padding: EdgeInsets.all(screen.width * .02),
                                    child: Icon(
                                      Icons.favorite_outline_rounded,
                                      size: screen.width * .05,
                                      color: AppColors.phoneBottomNavIconColor,
                                    ),
                                  ),
                                ),
                              )),
                          Positioned(
                              bottom: screen.height * .02,
                              left: screen.width * .03,
                              child: Container(
                                width: screen.width,
                                child: Text(
                                  args[0]['isMovie']
                                      ? controller.movieDetail.value.title
                                          .toString()
                                      : controller.tvDetail.value.name
                                          .toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: GoogleFonts.cinzelDecorative(
                                    fontSize: screen.width * .075,
                                    color: Colors.white,
                                  ),
                                ),
                              )),
                          Positioned(
                              top: screen.height * .08,
                              right: screen.width * .02,
                              child: CircleAvatar(
                                radius: screen.width * .045,
                                backgroundColor: AppColors
                                    .phoneBottomNavBackgroundColor
                                    .withAlpha(230),
                                child: CircularPercentIndicator(
                                  radius: screen.width * .045,
                                  lineWidth: 2,
                                  curve: Curves.bounceInOut,
                                  animation: true,
                                  progressColor: AppColors
                                      .phoneBottomNavIconColor
                                      .withAlpha(230),
                                  animationDuration: 1000,
                                  percent: args[0]['isMovie']
                                      ? (controller
                                              .movieDetail.value.voteAverage!) /
                                          10.toDouble()
                                      : (controller
                                              .tvDetail.value.voteAverage!) /
                                          10.toDouble(),
                                  center: Text(
                                      args[0]['isMovie']
                                          ? controller
                                              .movieDetail.value.voteAverage!
                                              .toStringAsFixed(1)
                                          : controller
                                              .tvDetail.value.voteAverage!
                                              .toStringAsFixed(1),
                                      style: GoogleFonts.cinzelDecorative(
                                          fontSize: screen.width * .035,
                                          color: Colors.white)),
                                  // footer: Text("Popularity",
                                  //     style: GoogleFonts.cinzel(
                                  //         fontSize: screen.width * .019,
                                  //         fontWeight: FontWeight.bold,
                                  //         color: Colors.white)
                                  //         )
                                ),
                              )),
                          Align(
                              alignment: Alignment.center,
                              child: controller.trailer.value.key != null
                                  ? InkWell(
                                      onTap: () {
                                        controller.launchVideoPlayer();
                                      },
                                      child: CircleAvatar(
                                        radius: screen.width * .08,
                                        backgroundColor: AppColors
                                            .phoneBottomNavBackgroundColor
                                            .withAlpha(230),
                                        child: Icon(
                                          Icons.play_arrow_rounded,
                                          color: AppColors
                                              .phoneBottomNavIconColor
                                              .withAlpha(230),
                                          size: screen.width * .1,
                                        ),
                                      ),
                                    )
                                  : const SizedBox(
                                      width: 0,
                                      height: 0,
                                    )),
                        ]),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: screen.width * .03),
                          child: Text('Genres : ',
                              style: GoogleFonts.cinzel(
                                  fontSize: screen.width * .04,
                                  color: Colors.white,
                                  letterSpacing: 1.5)),
                        ),
                        Expanded(
                          child: Container(
                            height: screen.height * .07,
                            padding: EdgeInsets.symmetric(
                                vertical: screen.height * .014),
                            // color: Colors.blue,
                            child: ListView.builder(
                                itemCount: args[0]['isMovie']
                                    ? controller
                                        .movieDetail.value.genres!.length
                                    : controller.tvDetail.value.genres!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (contex, inde) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        right: screen.width * .02),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screen.width * .025),
                                    decoration: BoxDecoration(
                                        color: AppColors.phoneBottomNavIconColor
                                            .withAlpha(230),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    alignment: Alignment.center,
                                    child: Text(
                                        args[0]['isMovie']
                                            ? controller.movieDetail.value
                                                .genres![inde].name
                                                .toString()
                                            : controller.tvDetail.value
                                                .genres![inde].name
                                                .toString(),
                                        style: GoogleFonts.cinzel(
                                            fontSize: screen.width * .04,
                                            color: Colors.black,
                                            letterSpacing: 1.5)),
                                  );
                                }),
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(left: screen.width * .035),
                      child: Text(
                        args[0]['isMovie']
                            ? controller.movieDetail.value.status.toString() ==
                                    'Released'
                                ? 'Released on : ${controller.movieDetail.value.releaseDate}'
                                : 'Will be released on : ${controller.movieDetail.value.releaseDate}'
                            : 'First Air Date : ${controller.tvDetail.value.firstAirDate}',
                        style: GoogleFonts.cinzel(
                            fontSize: screen.width * .04,
                            color: Colors.white,
                            letterSpacing: 1.2),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screen.width * .035,
                          vertical: screen.height * .015),
                      child: Text('Overview ',
                          style: GoogleFonts.cinzel(
                              color: AppColors.phoneBottomNavIconColor
                                  .withAlpha(230),
                              fontSize: screen.width * .05)),
                    ),
                    Container(
                        constraints:
                            BoxConstraints(minHeight: screen.height * .3),
                        margin: EdgeInsets.symmetric(
                            horizontal: screen.width * .015),
                        padding: EdgeInsets.symmetric(
                            horizontal: screen.width * .03,
                            vertical: screen.height * .01),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: .3,
                                color: AppColors.phoneBottomNavIconColor
                                    .withAlpha(230)),
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                            args[0]['isMovie']
                                ? '${controller.movieDetail.value.overview}'
                                : '${controller.tvDetail.value.overview}',
                            style: GoogleFonts.cinzelDecorative(
                                color: Colors.white,
                                fontSize: screen.width * .04,
                                letterSpacing: 1.2)))
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(
                      color: AppColors.phoneBottomNavIconColor),
                ),
        ),
      ),
    );
  }
}
