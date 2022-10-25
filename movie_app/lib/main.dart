import 'dart:ui';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/App/initApp.dart';
import 'package:movie_app/App/mainPage/bindings/mainPageBindings.dart';
import 'package:movie_app/App/mainPage/mainPage.dart';

void main() {
  initApp();
  runApp(MyApp()
      // DevicePreview(
      //   builder: ((context) => MyApp()),
      // ),
      );
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // builder: DevicePreview.appBuilder,
      // useInheritedMediaQuery: true,
      // locale: DevicePreview.locale(context),
      initialBinding: MainPageBindings(),
      scrollBehavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
        PointerDeviceKind.mouse,
        PointerDeviceKind.touch,
        PointerDeviceKind.trackpad
      }, scrollbars: false),
      home: MainPage(),
    );
  }
}
