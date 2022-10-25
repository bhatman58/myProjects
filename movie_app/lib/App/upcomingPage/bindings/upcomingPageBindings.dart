import 'package:get/get.dart';
import 'package:movie_app/App/upcomingPage/repositories/upcomingMoviesRemoteApi.dart';
import 'package:movie_app/App/upcomingPage/repositories/upcomingMoviesRemoteApiInteface.dart';
import 'package:movie_app/App/upcomingPage/viewModels/upcomingPageController.dart';
import 'package:movie_app/App/utils/configs.dart';
import 'package:tmdb_api/tmdb_api.dart';

class UpcomingPageBinding implements Bindings {
  @override
  void dependencies() {
    final tmdbApi = TMDB(ApiKeys(Configs.apiKeyV3, Configs.apiKeyV4),
        logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true));

    //Upcoming PAGE DEPENDENCY INJECTION
    final UpcomingMoviesRemoteApi upcomingRemoteApi =
        UpcomingMoviesRemoteApi(tmdbApi);
    Get.lazyPut<UpcomingMoviesRemoteApiInteface>(() => upcomingRemoteApi,
        fenix: true);

    Get.lazyPut(
        () =>
            UpcomingPageController(Get.find<UpcomingMoviesRemoteApiInteface>()),
        fenix: true);
  }
}
