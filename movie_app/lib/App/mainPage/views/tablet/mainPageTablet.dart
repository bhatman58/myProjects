import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/App/mainPage/viewModels/mainPageController.dart';

class MainPageTablet extends GetResponsiveView<MainPageController> {
  MainPageTablet({Key? key}) : super(key: key);

  @override
  Widget? builder() {
    return Scaffold(
      backgroundColor: Colors.brown[400],
      body: Center(
          child: Text(
        'Tablet',
        style: TextStyle(
          fontSize: screen.height * .028,
          color: Colors.white,
        ),
      )),
    );
  }
}
