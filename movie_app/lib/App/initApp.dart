import 'package:get/get.dart';
import 'package:movie_app/App/detailsPage/repositories/detailsPageRemoteApi.dart';
import 'package:movie_app/App/detailsPage/repositories/detailsPageRemoteApiInterface.dart';
import 'package:movie_app/App/upcomingPage/repositories/upcomingMoviesRemoteApi.dart';
import 'package:movie_app/App/upcomingPage/repositories/upcomingMoviesRemoteApiInteface.dart';
import 'package:movie_app/App/mainPage/repositories/mainPageRemoteApi.dart';
import 'package:movie_app/App/mainPage/repositories/mainPageRemoteApiInterface.dart';
import 'package:movie_app/App/searchPage/repositories/searchPageRemoteApi.dart';
import 'package:movie_app/App/searchPage/repositories/searchPageRemoteApiInterface.dart';
import 'package:movie_app/App/utils/configs.dart';
import 'package:tmdb_api/tmdb_api.dart';

initApp() {
  // final tmdbApi = TMDB(ApiKeys(Configs.apiKeyV3, Configs.apiKeyV4),
  //     logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true));

  // //MAIN PAGE DEPENDENCY INJECTION
  // final MainPageRemoteApi remoteApi = MainPageRemoteApi(tmdbApi);
  // Get.put<MainPageRemoteApiInterface>(remoteApi, permanent: true);

  // //DETAILS PAGE DEPENDENCY INJECTION
  // final DetailsPageRemoteApi detailsRemoteApi = DetailsPageRemoteApi(tmdbApi);
  // Get.lazyPut<DetailsPageRemoteApiInterface>(() => detailsRemoteApi,
  //     fenix: true);

  // //SEARCH PAGE DEPENDENCY INJECTION
  // final SearchPageRemoteApi searchRemoteApi = SearchPageRemoteApi(tmdbApi);
  // Get.lazyPut<SearchPageRemoteApiInterface>(() => searchRemoteApi, fenix: true);

  // //Upcoming PAGE DEPENDENCY INJECTION
  // final UpcomingMoviesRemoteApi upcomingRemoteApi =
  //     UpcomingMoviesRemoteApi(tmdbApi);
  // Get.lazyPut<UpcomingMoviesRemoteApiInteface>(() => upcomingRemoteApi,
  //     fenix: true);
}
