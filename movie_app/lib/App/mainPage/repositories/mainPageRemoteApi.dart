import 'package:movie_app/App/mainPage/models/popularMovieModel.dart';
import 'package:movie_app/App/mainPage/models/popularTVModel.dart';
import 'package:movie_app/App/mainPage/models/trendingModel.dart';
import 'package:movie_app/App/mainPage/models/trendingModelTv.dart';
import 'package:movie_app/App/mainPage/repositories/mainPageRemoteApiInterface.dart';
import 'package:tmdb_api/tmdb_api.dart';

class MainPageRemoteApi implements MainPageRemoteApiInterface {
  //RELATED TO TMDBAPI REQUIRMENTS
  final TMDB tmdbApi;
  //= TMDB(ApiKeys(Configs.apiKeyV3, Configs.apiKeyV4),
  //  logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true));

  MainPageRemoteApi(this.tmdbApi);

  @override
  Future<PopularMovieModel> getWhatsPopularMainPageOnStreaming(
      [int page = 1]) async {
    Map<dynamic, dynamic> response;
    response = await tmdbApi.v3.movies.getPopular(page: page);
    // print(response);
    return PopularMovieModel.fromJson(response);
  }

  @override
  Future<PopularTVModel> getWhatsPopularMainPageOnTV() async {
    Map<dynamic, dynamic> response;
    response = await tmdbApi.v3.tv.getPopular();
    // print('RESULT TVMODEL IS : ${response["results"]}');
    return PopularTVModel.fromJson(response);
  }

  @override
  Future<TrendingModel> getTrendingMainPage(TimeWindow timeWindow) async {
    Map<dynamic, dynamic> response;
    response = await tmdbApi.v3.trending
        .getTrending(timeWindow: timeWindow, mediaType: MediaType.movie);

    return TrendingModel.fromJson(response);
  }

  @override
  Future<TrendingModelTv> getTrendingTvMainPage(TimeWindow timeWindow) async {
    Map<dynamic, dynamic> response;
    response = await tmdbApi.v3.trending
        .getTrending(timeWindow: timeWindow, mediaType: MediaType.tv);

    return TrendingModelTv.fromJson(response);
  }

}
