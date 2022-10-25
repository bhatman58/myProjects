import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/App/searchPage/viewModels/searchPageController.dart';
import 'package:movie_app/App/utils/AppColors.dart';

class TvModel extends GetResponsiveView {
  TvModel({Key? key}) : super(key: key);

  SearchPageController pageController = Get.find<SearchPageController>();

  @override
  Widget? builder() {
    return Container(
        // color: Colors.blue,
        child: Obx(
      () => pageController.tvs.isNotEmpty
          ? ListView.separated(
              itemCount: pageController.tvs.length,
              controller: pageController.tvScrollController,
              key: const PageStorageKey('searcTvListKey'),
              itemBuilder: (context, index) {
                return SizedBox(
                  // width: 100,
                  height: screen.height * .22,
                  child: InkWell(
                    onTap: () {
                      pageController.gotoDetails(pageController.tvs[index].id! , false);
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
                                        'https://image.tmdb.org/t/p/w500${pageController.tvs[index].posterPath}'))),
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
                                    pageController.tvs[index].name.toString(),
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
                                      'Premiere : ${pageController.tvs[index].firstAir}',
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
                                      'Popularity : ${pageController.tvs[index].voteAverage} / 10',
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
              child: Text('Nothing to show here\nSearch a Tv Show!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cinzelDecorative(
                    fontSize: screen.width * .035,
                    color: Colors.white,
                  )),
            ),
    ));
  }
}
