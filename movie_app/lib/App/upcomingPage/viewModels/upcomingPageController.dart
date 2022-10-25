import 'package:get/get.dart';
import 'package:movie_app/App/detailsPage/views/detailsPage.dart';
import 'package:movie_app/App/upcomingPage/models/upcomingMovieModelResult.dart';
import 'package:movie_app/App/upcomingPage/repositories/upcomingMoviesRemoteApiInteface.dart';

class UpcomingPageController extends GetxController {
  // //RELATED TO API INTERFACE
  // final UpcomingMoviesRemoteApiInteface remoteApiInterface =
  //     Get.find<UpcomingMoviesRemoteApiInteface>();

  //Constructor Initialization
  final UpcomingMoviesRemoteApiInteface remoteApiInterface;
  UpcomingPageController(this.remoteApiInterface);

  RxList<UpcomingMovieModelResult> upcomings = <UpcomingMovieModelResult>[].obs;

  @override
  void onInit() {
    super.onInit();
    getUpcomings();
  }

  getUpcomings() async {
    var result = await remoteApiInterface.getUpcomingMovies();

    upcomings.value = result.results;
  }

  gotoDetails(int id) {
    Get.to(() => DetailsPage(), arguments: [
      {'id': id, 'isMovie': true}
    ]);
  }
}
