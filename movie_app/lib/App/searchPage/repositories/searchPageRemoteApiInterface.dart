import 'package:movie_app/App/searchPage/models/searchMovieModel.dart';
import 'package:movie_app/App/searchPage/models/searchTvModel.dart';

abstract class SearchPageRemoteApiInterface {
  Future<SearchMovieModel> searchMovie(String query);
  Future<SearchTvModel> searchTv(String query);
}
