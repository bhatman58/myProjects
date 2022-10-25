import 'package:movie_app/App/mainPage/models/popularMovieModel.dart';
import 'package:movie_app/App/mainPage/models/popularTVModel.dart';
import 'package:movie_app/App/mainPage/models/trendingModel.dart';
import 'package:movie_app/App/mainPage/models/trendingModelTv.dart';
import 'package:tmdb_api/tmdb_api.dart';

abstract class MainPageRemoteApiInterface {
  //POPULAR MOVIE MODEL IN MAIN SCREEN PAGE VIEW
  Future<PopularMovieModel> getWhatsPopularMainPageOnStreaming(int page);

  //POPULAR TV MODEL IN MAIN SCREEN PAGE VIEW
  Future<PopularTVModel> getWhatsPopularMainPageOnTV();

  //TRENDING MOVIE MEDIA TYPE MODEL IN MAIN SCREEN
  Future<TrendingModel> getTrendingMainPage(TimeWindow timeWindow);

  //TRENDING MOVIE MEDIA TYPE MODEL IN MAIN SCREEN
  Future<TrendingModelTv> getTrendingTvMainPage(TimeWindow timeWindow);

}
