import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/App/searchPage/viewModels/searchPageController.dart';
import 'package:movie_app/App/searchPage/views/moviesModel.dart';
import 'package:movie_app/App/searchPage/views/tvModel.dart';
import 'package:movie_app/App/utils/appColors.dart';

class SearchPage extends GetResponsiveView<SearchPageController> {
  SearchPage({Key? key}) : super(key: key);
  @override
  Widget? builder() {
    return Container(
      width: screen.width,
      height: screen.height,
      child: Column(
        children: [
          Container(
            height: screen.height * .11,
            // padding: EdgeInsets.symmetric(vertical: screen.height * .01),
            alignment: Alignment.center,
            // color: Colors.red,
            child: TextField(
              onSubmitted: (query) {
                controller.searchQuery(query);
              },
              cursorColor: AppColors.phoneBottomNavIconColor.withAlpha(230),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              maxLength: 30,
              controller: controller.searchController,
              style: GoogleFonts.cinzel(
                  fontSize: screen.width * .035,
                  color: Colors.white,
                  letterSpacing: 1.2),
              decoration: InputDecoration(
                counter: const SizedBox(
                  width: 0,
                  height: 0,
                ),
                labelText: 'Search a Movie',
                labelStyle: GoogleFonts.cinzelDecorative(
                    fontSize: screen.width * .036,
                    color: Colors.white,
                    letterSpacing: 1.2),
                hintText: 'e.g Avengers , Max 30 letters',
                hintStyle: GoogleFonts.cinzel(
                    fontSize: screen.width * .035,
                    color: Colors.grey.shade600,
                    letterSpacing: 1.2),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Colors.white, width: .5)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      color: AppColors.phoneBottomNavIconColor.withAlpha(230),
                      width: .5),
                ),
              ),
            ),
          ),
          TabBar(
              controller: controller.tabController,
              overlayColor: MaterialStateColor.resolveWith(
                  (states) => Colors.transparent),
              unselectedLabelStyle:
                  GoogleFonts.cinzel(fontSize: screen.width * .035),
              labelStyle: GoogleFonts.cinzel(
                fontSize: screen.width * .035,
              ),
              labelColor: AppColors.phoneBottomNavIconColor.withAlpha(230),
              unselectedLabelColor: Colors.white,
              isScrollable: true,
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                      width: 1,
                      color: AppColors.phoneBottomNavIconColor.withAlpha(230)),
                  insets: EdgeInsets.symmetric(horizontal: screen.width * .06)),
              indicatorColor: AppColors.phoneBottomNavIconColor.withAlpha(230),
              tabs: const [
                Tab(
                  text: 'Movies',
                ),
                Tab(
                  text: 'Tv Shows',
                ),
              ]),
          SizedBox(height: screen.height * .01),
          Expanded(
              child:
                  TabBarView(controller: controller.tabController, children: [
            MoviesModel(),
            TvModel(),
          ])),
        ],
      ),
    );
  }
}
