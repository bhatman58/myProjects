import 'package:movie_app/App/detailsPage/models/movieDetailModel.dart';
import 'package:movie_app/App/detailsPage/models/trailerModel.dart';
import 'package:movie_app/App/detailsPage/models/tvDetailModel.dart';
import 'package:movie_app/App/detailsPage/repositories/detailsPageRemoteApiInterface.dart';
import 'package:tmdb_api/tmdb_api.dart';

class DetailsPageRemoteApi extends DetailsPageRemoteApiInterface {
  final TMDB tmdbApi;

  DetailsPageRemoteApi(this.tmdbApi);

  @override
  Future<MovieDetailModel> getMovieDetail(int movieId) async {
    final Map<dynamic, dynamic> response;

    response = await tmdbApi.v3.movies
        .getDetails(movieId)
        .onError((error, stackTrace) =>
            print('sssss ' + error.toString()) as Map<dynamic, dynamic>)
        .timeout(const Duration(seconds: 15));

    return MovieDetailModel.fromJson(response);
  }

  @override
  Future<TvDetailModel> getTvDetail(int tvId) async {
    final Map<dynamic, dynamic> response;

    response = await tmdbApi.v3.tv
        .getDetails(tvId)
        .onError((error, stackTrace) =>
            print('sssss ' + error.toString()) as Map<dynamic, dynamic>)
        .timeout(const Duration(seconds: 15));

    return TvDetailModel.fromJson(response);
  }

  @override
  Future<TrailerModel> getVideo(int movieId) async {
    final Map<dynamic, dynamic> response;

    response = await tmdbApi.v3.movies
        .getVideos(movieId)
        .onError((error, stackTrace) =>
            print('sssss ' + error.toString()) as Map<dynamic, dynamic>)
        .timeout(const Duration(seconds: 15));

    return TrailerModel.fromJson(response);
  }
}
