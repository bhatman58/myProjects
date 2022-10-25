import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/App/mainPage/models/PopularMovieResult.dart';
import 'package:movie_app/App/mainPage/models/popularTVResult.dart';
import 'package:movie_app/App/mainPage/models/trendingModelResult.dart';
import 'package:movie_app/App/mainPage/models/trendingModelTvResult.dart';
import 'package:movie_app/App/mainPage/repositories/mainPageRemoteApiInterface.dart';
import 'package:tmdb_api/tmdb_api.dart';

class MainPageController extends GetxController
    with GetTickerProviderStateMixin {
  //RELATED TO MAIN PAGE'S APPBAR COLOR SHIFT
  ScrollController scrollController = ScrollController();
  Rx<double> scrollOffset = (0.0).obs;

  //RELATED TO MAIN PAGE'S BOTTOM NAVIGATION PAGE VIEW
  PageController navigationController = PageController(initialPage: 0);
  Rx<int> navigationIndex = 0.obs;

  //RELATED TO WHAT'S POPULAR PAGEVIEW
  Rx<int> selectedIndex = 0.obs;
  List<String> sources = ['Streaming', 'On TV'];

  //RELATED TO WHAT'S POPULAR MAIN MOVIE PAGEVIEW
  Rx<int> selectedMoviePVIndex = 0.obs;

  //Constructor Initialization
  final MainPageRemoteApiInterface remoteApiInterface;
  MainPageController(this.remoteApiInterface);


  //RELATED TO POPULAR MOVIES LIST
  RxList<PopularMovieResult> movies = <PopularMovieResult>[].obs;
  final List<Map<dynamic, dynamic>> genreMovieBook = [
    {"id": 28, "name": "Action"},
    {"id": 12, "name": "Adventure"},
    {"id": 16, "name": "Animation"},
    {"id": 35, "name": "Comedy"},
    {"id": 80, "name": "Crime"},
    {"id": 99, "name": "Documentary"},
    {"id": 18, "name": "Drama"},
    {"id": 10751, "name": "Family"},
    {"id": 14, "name": "Fantasy"},
    {"id": 36, "name": "History"},
    {"id": 27, "name": "Horror"},
    {"id": 10402, "name": "Music"},
    {"id": 9648, "name": "Mystery"},
    {"id": 10749, "name": "Romance"},
    {"id": 878, "name": "Science Fiction"},
    {"id": 10770, "name": "TV Movie"},
    {"id": 53, "name": "Thriller"},
    {"id": 10752, "name": "War"},
    {"id": 37, "name": "Western"}
  ];
  RxList innerGenres = [].obs;

  //RELATED TO POPULAR TV LIST
  RxList<PopularTVResult> tvs = <PopularTVResult>[].obs;
  RxBool isStreaming = true.obs;
  final List<Map<String, dynamic>> genreTVBook = [
    {"id": 10759, "name": "Action & Adventure"},
    {"id": 16, "name": "Animation"},
    {"id": 35, "name": "Comedy"},
    {"id": 80, "name": "Crime"},
    {"id": 99, "name": "Documentary"},
    {"id": 18, "name": "Drama"},
    {"id": 10751, "name": "Family"},
    {"id": 10762, "name": "Kids"},
    {"id": 9648, "name": "Mystery"},
    {"id": 10763, "name": "News"},
    {"id": 10764, "name": "Reality"},
    {"id": 10765, "name": "Sci-Fi & Fantasy"},
    {"id": 10766, "name": "Soap"},
    {"id": 10767, "name": "Talk"},
    {"id": 10768, "name": "War & Politics"},
    {"id": 37, "name": "Western"}
  ];
  RxList innerTVGenres = [].obs;

  //RELATED TO DAILY/WEEKLY MOVIE TRENDING
  TabController? tController;
  RxList<TrendingResult> dailyTrendings = <TrendingResult>[].obs;
  RxList<TrendingResult> weeklyTrendings = <TrendingResult>[].obs;

  //RELATED TO DAILY/WEEKLY TV TRENDING
  TabController? tvTController;
  RxList<TrendingModelTvResult> dailyTrendingsTv =
      <TrendingModelTvResult>[].obs;
  RxList<TrendingModelTvResult> weeklyTrendingsTv =
      <TrendingModelTvResult>[].obs;

  @override
  void onInit() async {
    super.onInit();
    print('on init');
    scrollController.addListener(() {
      scrollOffset.value = scrollController.offset;
    });
    tController = TabController(length: 2, vsync: this);
    tvTController = TabController(length: 2, vsync: this);
    getPopularMoviesStreamingMainPage();
    getPopularTVMainPage();
    getTrendingMainPage('day');
    getTrendingMainPageTv('day');
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }

  setWhatsPopular(int index) {
    selectedIndex.value = index;
    index == 0 ? isStreaming.value = true : isStreaming.value = false;

    print(index);
  }

  whatsPopularMoviesPageviewIndexController(int index) {
    selectedMoviePVIndex.value = index;
    print(selectedMoviePVIndex);
  }

  getPopularMoviesStreamingMainPage() async {
    var result = await remoteApiInterface.getWhatsPopularMainPageOnStreaming(1);
    // print(result.results);
    movies.value = result.results;
    // innerGenres.clear();

    genreMatcher(movies, 1);
    print('got res');
  }

  genreMatcher(List<dynamic> movies, int index) {
    if (index == 1) {
      movies.forEach((element) {
        innerGenres.add(element.genreIds);
      });
      // print('INNNER GENRES +  $innerGenres \n');
      List<List<String>> wholeList = [];
      List<String> eachList = [];
      int k = 0;
      for (int i = 0; i < innerGenres.length; i++) {
        for (int j = 0; j < innerGenres[i].length; j++) {
          for (int k = 0; k < genreMovieBook.length; k++) {
            if (innerGenres[i][j] == genreMovieBook[k]['id']) {
              // print('${innerGenres[i][j]} + ${genreMovieBook[k]['id']}');
              eachList.add(genreMovieBook[k]['name']);
              // print(eachList);
            }
          }
        }
        wholeList.add(eachList.toList());
        eachList.clear();
        // print('CLEARED');
      }
      innerGenres.value.replaceRange(0, innerGenres.length, wholeList);

      print('\n WHOOOOOOOOOOOOOLE LIIIIIIIIIIIIIIISSSSSSSST ::: $innerGenres ');
    } else if (index == 2) {
      movies.forEach((element) {
        innerTVGenres.add(element.genreIds);
      });
      // print('INNNER GENRES +  $innerGenres \n');
      List<List<String>> wholeList = [];
      List<String> eachList = [];
      int k = 0;
      for (int i = 0; i < innerTVGenres.length; i++) {
        for (int j = 0; j < innerTVGenres[i].length; j++) {
          for (int k = 0; k < genreTVBook.length; k++) {
            if (innerTVGenres[i][j] == genreTVBook[k]['id']) {
              // print('${innerGenres[i][j]} + ${genreMovieBook[k]['id']}');
              eachList.add(genreTVBook[k]['name']);
              // print(eachList);
            }
          }
        }
        wholeList.add(eachList.toList());
        eachList.clear();
        // print('CLEARED');
      }
      innerTVGenres.value.replaceRange(0, innerGenres.length, wholeList);

      print(
          '\n WHOOOOOOOOOOOOOLE LIIIIIIIIIIIIIIISSSSSSSST INNER TV GENRES::: $innerTVGenres ');
    }
  }

  getPopularTVMainPage() async {
    var result = await remoteApiInterface.getWhatsPopularMainPageOnTV();
    tvs.value = result.results;

    genreMatcher(tvs, 2);
  }

  getTrendingMainPage(String window) async {
    if (window == 'day') {
      var result = await remoteApiInterface.getTrendingMainPage(TimeWindow.day);
      dailyTrendings.value = result.results;

      // print('DAILY : ${result.results}');
    } else if (window == 'week') {
      var result =
          await remoteApiInterface.getTrendingMainPage(TimeWindow.week);
      weeklyTrendings.value = result.results;
      print('WEEKLY : ${result.results}');
    }
  }

  getTrendingMainPageTv(String window) async {
    if (window == 'day') {
      var result =
          await remoteApiInterface.getTrendingTvMainPage(TimeWindow.day);
      dailyTrendingsTv.value = result.results;

      // print('DAILY : ${result.results}');
    } else if (window == 'week') {
      var result =
          await remoteApiInterface.getTrendingTvMainPage(TimeWindow.week);
      weeklyTrendingsTv.value = result.results;
      print('WEEKLY : ${result.results}');
    }
  }

  bottomNavigationSwitcher(int index) {
    navigationController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  bottomNavigationOnpageChanged(int index) {
    navigationIndex.value = index;
    print('navi ' + navigationIndex.toString());
  }
}
