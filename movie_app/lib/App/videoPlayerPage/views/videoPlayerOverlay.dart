import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:movie_app/App/mainPage/views/phone/phoneExporter.dart';
import 'package:movie_app/App/videoPlayerPage/viewModels/videoPlayerOverlayController.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerOverlay extends GetResponsiveView {
  VideoPlayerOverlay({Key? key}) : super(key: key);

  VideoPlayerOverlayController pageController =
      Get.put(VideoPlayerOverlayController());

  dynamic args = Get.arguments;

  @override
  Widget? builder() {
    return WillPopScope(
      onWillPop: () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        return Future.value(true);
      },
      child: Container(
          width: screen.width,
          height: screen.height,
          color: AppColors.phoneMainBackgroundColor.withAlpha(230),
          child: Obx(() => pageController.youtubePlayerController != null &&
                  pageController.isInitialized.value
              ? YoutubePlayer(
                  controller: pageController.youtubePlayerController!,
                  showVideoProgressIndicator: true,
                  onReady: () =>
                      pageController.youtubePlayerController!.addListener(() {
                    print('player is ready');
                  }),
                  controlsTimeOut: const Duration(seconds: 3),
                  progressIndicatorColor:
                      AppColors.phoneBottomNavIconColor.withAlpha(230),
                  aspectRatio: 16 / 9,
                  width: screen.width,
                  progressColors: ProgressBarColors(
                      handleColor:
                          AppColors.phoneBottomNavIconColor.withAlpha(230),
                      bufferedColor: Colors.grey,
                      playedColor: AppColors.phoneBottomNavBackgroundColor
                          .withAlpha(230)),
                )
              : Center(
                  child: CircularProgressIndicator(
                      color: AppColors.phoneBottomNavIconColor.withAlpha(230)),
                ))),
    );
  }
}
