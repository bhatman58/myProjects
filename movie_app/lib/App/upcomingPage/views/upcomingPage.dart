import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/App/upcomingPage/viewModels/upcomingPageController.dart';
import 'package:movie_app/App/utils/AppColors.dart';
import 'package:movie_app/App/utils/configs.dart';

class UpcomingPage extends GetResponsiveView<UpcomingPageController> {
  UpcomingPage({Key? key}) : super(key: key);

  // Upcomingcontroller controller = Get.put(Upcomingcontroller());

  @override
  Widget? builder() {
    return Container(
        // color: Colors.blue,
        child: Obx(
      () => controller.upcomings.isNotEmpty
          ? ListView.separated(
              itemCount: controller.upcomings.length,
              key: const PageStorageKey('upcomingMoviesListKey'),
              itemBuilder: (context, index) {
                return SizedBox(
                  // width: 100,
                  height: screen.height * .22,
                  child: InkWell(
                    onTap: () {
                      controller.gotoDetails(controller.upcomings[index].id!);
                    },
                    child: Card(
                      color: AppColors.phoneMainBackgroundColor,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: screen.width * .3,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        '${Configs.posterPath}${controller.upcomings[index].posterPath}'))),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: screen.height * .008,
                                  horizontal: screen.width * .025),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.upcomings[index].title
                                        .toString(),
                                    style: GoogleFonts.cinzelDecorative(
                                        fontSize: screen.width * .035,
                                        color: AppColors.phoneBottomNavIconColor
                                            .withAlpha(230)),
                                  ),
                                  SizedBox(height: screen.height * .035),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: screen.height * .01),
                                    child: Text(
                                      'Release Date : ${controller.upcomings[index].releaseDate}',
                                      style: GoogleFonts.cinzelDecorative(
                                          fontSize: screen.width * .035,
                                          color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(height: screen.height * .015),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: screen.height * .01),
                                    child: Text(
                                      'Popularity : ${controller.upcomings[index].voteAverage} / 10',
                                      style: GoogleFonts.cinzelDecorative(
                                          fontSize: screen.width * .035,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (con, ind) => const SizedBox(),
            )
          : Center(
              child: Text('Nothing to show here\nSearch a Movie!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cinzelDecorative(
                    fontSize: screen.width * .035,
                    color: Colors.white,
                  )),
            ),
    ));
  }
}
