import 'package:get/get.dart';
import 'package:movie_app/App/detailsPage/repositories/detailsPageRemoteApi.dart';
import 'package:movie_app/App/detailsPage/repositories/detailsPageRemoteApiInterface.dart';
import 'package:movie_app/App/detailsPage/viewModels/detailsPageController.dart';
import 'package:movie_app/App/utils/configs.dart';
import 'package:tmdb_api/tmdb_api.dart';

class DetailsPageBinding implements Bindings {
  @override
  void dependencies() {
    final tmdbApi = TMDB(ApiKeys(Configs.apiKeyV3, Configs.apiKeyV4),
        logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true));

    //DETAILS PAGE DEPENDENCY INJECTION
    final DetailsPageRemoteApi detailsRemoteApi = DetailsPageRemoteApi(tmdbApi);
    Get.lazyPut<DetailsPageRemoteApiInterface>(() => detailsRemoteApi,
        fenix: true);

    Get.lazyPut(() => DetailsPageController(Get.find()), fenix: true);
  }
}
