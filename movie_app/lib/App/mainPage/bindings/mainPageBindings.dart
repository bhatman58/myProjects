import 'package:get/get.dart';
import 'package:movie_app/App/mainPage/repositories/mainPageRemoteApi.dart';
import 'package:movie_app/App/mainPage/repositories/mainPageRemoteApiInterface.dart';
import 'package:movie_app/App/mainPage/viewModels/mainPageController.dart';
import 'package:movie_app/App/searchPage/bindings/searchPageBindings.dart';
import 'package:movie_app/App/upcomingPage/bindings/upcomingPageBindings.dart';
import 'package:movie_app/App/utils/configs.dart';
import 'package:tmdb_api/tmdb_api.dart';

class MainPageBindings implements Bindings {
  @override
  void dependencies() {
    final tmdbApi = TMDB(ApiKeys(Configs.apiKeyV3, Configs.apiKeyV4),
        logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true));

    //MAIN PAGE DEPENDENCY INJECTION
    final MainPageRemoteApi remoteApi = MainPageRemoteApi(tmdbApi);
    Get.put<MainPageRemoteApiInterface>(remoteApi, permanent: true);

    Get.put(MainPageController(Get.find<MainPageRemoteApiInterface>()));
    SearchPageBindings().dependencies();
    UpcomingPageBinding().dependencies();
  }
}
