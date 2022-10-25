import 'package:movie_app/App/upcomingPage/models/upcomingMovieModel.dart';
import 'package:movie_app/App/upcomingPage/repositories/upcomingMoviesRemoteApiInteface.dart';
import 'package:tmdb_api/tmdb_api.dart';

class UpcomingMoviesRemoteApi extends UpcomingMoviesRemoteApiInteface {
  final TMDB tmdbApi;
  UpcomingMoviesRemoteApi(this.tmdbApi);

  @override
  Future<UpcomingMovieModel> getUpcomingMovies() async {
    Map<dynamic, dynamic> response;
    response = await tmdbApi.v3.movies
        .getUpcoming()
        .timeout(const Duration(seconds: 15));
    // print(response);
    return UpcomingMovieModel.fromJson(response);
  }
}
