import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/App/mainPage/views/phone/phoneExporter.dart';
import 'package:movie_app/App/searchPage/viewModels/searchPageController.dart';
import 'package:movie_app/App/utils/configs.dart';

class MoviesModel extends GetResponsiveView {
  MoviesModel({Key? key}) : super(key: key);

  SearchPageController pageController = Get.find<SearchPageController>();

  @override
  Widget? builder() {
    return Container(
        // color: Colors.blue,
        child: Obx(
      () => pageController.movies.isNotEmpty
          ? ListView.separated(
              itemCount: pageController.movies.length,
              controller: pageController.movieScrollController,
              key: const PageStorageKey('searchMovieListKey'),
              itemBuilder: (context, index) {
                return SizedBox(
                  // width: 100,
                  height: screen.height * .22,
                  child: InkWell(
                    onTap: () {
                      pageController.gotoDetails(
                          pageController.movies[index].id!, true);
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
                                        '${Configs.posterPath}${pageController.movies[index].posterPath}'))),
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
                                    pageController.movies[index].title
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
                                      'Release Date : ${pageController.movies[index].releaseDate}',
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
                                      'Popularity : ${pageController.movies[index].voteAverage} / 10',
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
