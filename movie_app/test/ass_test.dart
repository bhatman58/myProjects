import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/App/mainPage/models/PopularMovieResult.dart';
import 'package:movie_app/App/mainPage/models/popularMovieModel.dart';
import 'package:movie_app/App/mainPage/repositories/mainPageRemoteApi.dart';
import 'package:movie_app/App/mainPage/repositories/mainPageRemoteApiInterface.dart';
import 'package:movie_app/App/mainPage/viewModels/mainPageController.dart';
import 'package:movie_app/App/utils/configs.dart';
import 'package:tmdb_api/tmdb_api.dart';

class MockSag extends Mock implements TMDB {}

@GenerateMocks([MockSag])
void main() {
  group('Testing MainPageController', () {
    test('sag', () async {
      TMDB sag = MockSag();
      //MAIN PAGE DEPENDENCY INJECTION
      final MainPageRemoteApi remoteApi = MainPageRemoteApi(sag);
      Get.put<MainPageRemoteApiInterface>(remoteApi, permanent: true);
      when(sag.v3.movies.getPopular())
          .thenAnswer((real) => Future<Map<dynamic, dynamic>>.value({
                "page": 1,
                "results": [
                  {
                    "adult": false,
                    "backdrop_path": "/5GA3vV1aWWHTSDO5eno8V5zDo8r.jpg",
                    "genre_ids": [27, 53],
                    "id": 760161,
                    "original_language": "en",
                    "original_title": "Orphan: First Kill",
                    "overview":
                        "After escaping from an Estonian psychiatric facility, Leena Klammer travels to America by impersonating Esther, the missing daughter of a wealthy family. But when her mask starts to slip, she is put against a mother who will protect her family from the murderous “child” at any cost.",
                    "popularity": 3876.772,
                    "poster_path": "/pHkKbIRoCe7zIFvqan9LFSaQAde.jpg",
                    "release_date": "2022-07-27",
                    "title": "Orphan: First Kill",
                    "video": false,
                    "vote_average": 6.8,
                    "vote_count": 1024
                  },
                ],
                "total_pages": 35487,
                "total_results": 709729
              }));

      var controller =
          Get.put(MainPageController(Get.find<MainPageRemoteApiInterface>()));
      await controller.getPopularMoviesStreamingMainPage();
      expect(controller.movies.length, greaterThanOrEqualTo(1));
    });
  });
}
