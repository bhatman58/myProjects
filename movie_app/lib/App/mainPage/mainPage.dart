import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/App/mainPage/viewModels/mainPageController.dart';
import 'package:movie_app/App/mainPage/mainPageExporter.dart';

class MainPage extends GetResponsiveView {
  MainPage({Key? key}) : super(key: key);

  @override
  Widget? builder() {
    return Scaffold(
      body: ScreenDefiner(),
    );
  }
}

class ScreenDefiner extends GetResponsiveView<MainPageController> {
  ScreenDefiner() : super(alwaysUseBuilder: false);

  @override
  Widget? phone() => MainPagePhone();

  @override
  Widget? desktop() => MainPageDesktop();

  @override
  Widget? tablet() => MainPageTablet();
}
