import 'package:get/get.dart';
import 'package:movie_app/App/searchPage/repositories/searchPageRemoteApi.dart';
import 'package:movie_app/App/searchPage/repositories/searchPageRemoteApiInterface.dart';
import 'package:movie_app/App/searchPage/viewModels/searchPageController.dart';
import 'package:movie_app/App/utils/configs.dart';
import 'package:tmdb_api/tmdb_api.dart';

class SearchPageBindings implements Bindings {
  @override
  void dependencies() {
    final tmdbApi = TMDB(ApiKeys(Configs.apiKeyV3, Configs.apiKeyV4),
        logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true));

    //SEARCH PAGE DEPENDENCY INJECTION
    final SearchPageRemoteApi searchRemoteApi = SearchPageRemoteApi(tmdbApi);
    Get.lazyPut<SearchPageRemoteApiInterface>(() => searchRemoteApi,
        fenix: true);
    Get.lazyPut(
        () => SearchPageController(Get.find<SearchPageRemoteApiInterface>()),
        fenix: true);
  }
}
