import 'package:movie_app/App/searchPage/models/searchMovieModel.dart';
import 'package:movie_app/App/searchPage/models/searchTvModel.dart';
import 'package:movie_app/App/searchPage/repositories/searchPageRemoteApiInterface.dart';
import 'package:tmdb_api/tmdb_api.dart';

class SearchPageRemoteApi extends SearchPageRemoteApiInterface {
  final TMDB tmdbApi;

  SearchPageRemoteApi(this.tmdbApi);

  @override
  Future<SearchMovieModel> searchMovie(String query) async {
    final Map<dynamic, dynamic> response;

    response = await tmdbApi.v3.search
        .queryMovies(query)
        .timeout(const Duration(seconds: 15));
    return SearchMovieModel.fromJson(response);
  }

  @override
  Future<SearchTvModel> searchTv(String query) async {
    final Map<dynamic, dynamic> response;

    response = await tmdbApi.v3.search
        .queryTvShows(query)
        .timeout(const Duration(seconds: 15));
    return SearchTvModel.fromJson(response);
  }
}
