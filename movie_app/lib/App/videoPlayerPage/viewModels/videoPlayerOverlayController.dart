import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerOverlayController extends GetxController {
//RELATED TO VIDEO PLAYER
  dynamic args = Get.arguments;

  late YoutubePlayerController? youtubePlayerController;

  Rx<bool> isInitialized = false.obs;

  @override
  void onInit() async {
    super.onInit();
    print(args[0]['videoPath']);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);

    youtubePlayerController = YoutubePlayerController(
      initialVideoId: args[0]['videoPath'],
      flags: const YoutubePlayerFlags(
        controlsVisibleAtStart: true,
        autoPlay: true,
      ),
    );
    isInitialized.value = true;
  }

  @override
  void onClose() {
    super.onClose();
    youtubePlayerController!.dispose();
  }
}
