import 'package:movie_app/App/detailsPage/models/movieDetailModel.dart';
import 'package:movie_app/App/detailsPage/models/trailerModel.dart';
import 'package:movie_app/App/detailsPage/models/tvDetailModel.dart';

abstract class DetailsPageRemoteApiInterface {
  Future<MovieDetailModel> getMovieDetail(int movieId);
  Future<TvDetailModel> getTvDetail(int tvId);
  Future<TrailerModel> getVideo(int movieId);
}
