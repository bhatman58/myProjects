import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/App/detailsPage/views/detailsPage.dart';
import 'package:movie_app/App/mainPage/views/phone/phoneExporter.dart';
import 'package:movie_app/App/searchPage/models/searchMovieResult.dart';
import 'package:movie_app/App/searchPage/models/searchTvResult.dart';
import 'package:movie_app/App/searchPage/repositories/searchPageRemoteApiInterface.dart';

class SearchPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();

  //Constructor Initialization
  final SearchPageRemoteApiInterface remoteApiInterface;
  SearchPageController(this.remoteApiInterface);

  // //RELATED TO SEARCH API INTERFACE
  // final SearchPageRemoteApiInterface remoteApiInterface =
  //     Get.find<SearchPageRemoteApiInterface>();

  //RELATED TO TABS
  TabController? tabController;

  //RELATED TO SCROLL CONTROLLER
  ScrollController movieScrollController = ScrollController();
  ScrollController tvScrollController = ScrollController();

  //RELATED TO MOVIES SEARCH LIST VIEW
  RxList<SearchMovieResult> movies = <SearchMovieResult>[].obs;

  //RELATED TO TVs SEARCH LIST VIEW
  RxList<SearchTvResult> tvs = <SearchTvResult>[].obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  searchQuery(String query) async {
    snack();

    var movieResult = await remoteApiInterface.searchMovie(query);
    var tvResult = await remoteApiInterface.searchTv(query);

    movies.value = movieResult.results;
    tvs.value = tvResult.results;

    movieScrollController.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    tvScrollController.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  snack() {
    Get.showSnackbar(GetSnackBar(
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
      message: 'Please be patient',
      isDismissible: true,
      dismissDirection: DismissDirection.startToEnd,
      barBlur: 10,
      backgroundColor: AppColors.phoneBottomNavBackgroundColor.withAlpha(230),
      forwardAnimationCurve: Curves.easeInOut,
      overlayBlur: 2.5,
      icon: Icon(
        Icons.search_rounded,
        color: AppColors.phoneBottomNavIconColor.withAlpha(230),
      ),
      title: 'Search in Progress',
      shouldIconPulse: true,
    ));
  }

  gotoDetails(int id, bool isMovie) {
    isMovie
        ? Get.to(() => DetailsPage(), arguments: [
            {'id': id, 'isMovie': true},
          ])
        : Get.to(() => DetailsPage(), arguments: [
            {'id': id, 'isMovie': false},
          ]);
  }
}
