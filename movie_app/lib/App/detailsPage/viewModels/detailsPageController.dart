import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:movie_app/App/detailsPage/models/movieDetailModel.dart';
import 'package:movie_app/App/detailsPage/models/trailerModelResult.dart';
import 'package:movie_app/App/detailsPage/models/tvDetailModel.dart';
import 'package:movie_app/App/detailsPage/repositories/detailsPageRemoteApiInterface.dart';
import 'package:movie_app/App/videoPlayerPage/views/videoPlayerOverlay.dart';

class DetailsPageController extends GetxController {
  // final DetailsPageRemoteApiInterface remoteApiInterface =
  //     Get.find<DetailsPageRemoteApiInterface>();

  //Constructor Initialization
  final DetailsPageRemoteApiInterface remoteApiInterface;
  DetailsPageController(this.remoteApiInterface);

  dynamic args = Get.arguments;

  var movieDetail = MovieDetailModel().obs;
  var tvDetail = TvDetailModel().obs;

  //RELATED TO TRAILER VIDEO PATH
  var trailer = TrailerModelResult().obs;

  @override
  void onInit() {
    super.onInit();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    // print('cont ' + args[0]['id'].toString());/
    getDetails(args[0]['id'], args[0]['isMovie']);
  }

  getDetails(int id, bool isMovie) async {
    if (isMovie) {
      var result = await remoteApiInterface.getMovieDetail(id);
      movieDetail.update((movie) {
        movie?.adult = result.adult;
        movie?.backdropPath = result.backdropPath;
        movie?.genres = result.genres;
        movie?.id = result.id;
        movie?.overview = result.overview;
        movie?.popularity = result.popularity;
        movie?.posterPath = result.posterPath;
        movie?.releaseDate = result.releaseDate;
        movie?.status = result.status;
        movie?.title = result.title;
        movie?.voteAverage = result.voteAverage;
      });
      print(movieDetail.value.releaseDate);

      //GETTING THE TRAILER MAP
      var trailerList = await remoteApiInterface.getVideo(id);
      var oneTrailer = trailerList.results!.firstWhere((singleTrailer) =>
          singleTrailer.type == 'Trailer' &&
          singleTrailer.site == 'YouTube' &&
          singleTrailer.official == true);

      print('one trailer key is : ${oneTrailer.key}');

      trailer.update((val) {
        val!.key = oneTrailer.key;
      });
    } else if (isMovie == false) {
      var result = await remoteApiInterface.getTvDetail(id);
      tvDetail.update((tv) {
        tv?.adult = result.adult;
        tv?.backdropPath = result.backdropPath;
        tv?.firstAirDate = result.firstAirDate;
        tv?.genres = result.genres;
        tv?.id = result.id;
        tv?.inProduction = result.inProduction;
        tv?.name = result.name;
        tv?.numberOfEpisodes = result.numberOfEpisodes;
        tv?.numberOfSeasons = result.numberOfSeasons;
        tv?.originalName = result.originalName;
        tv?.overview = result.overview;
        tv?.popularity = result.popularity;
        tv?.posterPath = result.posterPath;
        tv?.status = result.status;
        tv?.voteAverage = result.voteAverage;
      });
      print(tvDetail.value.numberOfEpisodes);
    }
  }

  launchVideoPlayer() {
    // print('${Configs.youtubePath}${trailer.value.key}');
    Get.to(() => VideoPlayerOverlay(), arguments: [
      {'videoPath': '${trailer.value.key}'}
    ]);
  }
}
