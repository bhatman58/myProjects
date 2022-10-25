import 'package:movie_app/App/upcomingPage/models/upcomingMovieModel.dart';

abstract class UpcomingMoviesRemoteApiInteface {
  Future<UpcomingMovieModel> getUpcomingMovies();
}
