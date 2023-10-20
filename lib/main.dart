import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:user_crud/utils/dependency_injection.dart';
import 'package:user_crud/widget/home.dart';

import 'configs/api_config.dart';
import 'controllers/network_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
// import 'package:user_crud/widget/home_noInternet.dart';
import 'package:user_crud/widget/home.dart'
if (dart.library.io) 'package:user_crud/widget/home_noInternet.dart';
void main() {

  ApiConfig.initialize();

  runApp( GetMaterialApp(
    home: MyWidget(),
    debugShowCheckedModeBanner: false,
  ));

  DependencyInjection.init();
}

class MyWidget extends StatefulWidget  {

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final NetworkController networkController = Get.find();
  final isWeb = kIsWeb;



  @override
  Widget build(BuildContext context) {

      return Obx(
              () {
                return networkController.isOnline.value
                    ? const HomeScreen() // Display in online
                    : const HomeScreen2(); // Display home2.dart
              });
    return const HomeScreen();
  }
}



