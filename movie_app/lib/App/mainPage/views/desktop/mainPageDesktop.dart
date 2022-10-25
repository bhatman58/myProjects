import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/App/mainPage/viewModels/mainPageController.dart';

class MainPageDesktop extends GetResponsiveView<MainPageController> {
  MainPageDesktop({Key? key}) : super(key: key);

  @override
  Widget? builder() {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
          child: Text(
        'Desktop',
        style: TextStyle(
          fontSize: screen.height * .028,
          color: Colors.white,
        ),
      )),
    );
  }
}
