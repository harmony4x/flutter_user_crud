import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  final isOnline = false.obs;
  var  isNontification = false;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    // _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    _connectivitySubscription = _connectivity.onConnectivityChanged
        .debounceTime(Duration(seconds: 2))
        .listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {

    if (connectivityResult == ConnectivityResult.none) {
      isOnline.value = false;
      isNontification = true;

      if(isNontification == true) {
        Get.rawSnackbar(
            messageText: const Text(
                'BẠN ĐANG Ở CHẾ ĐỘ OFFLINE',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14
                )
            ),
            isDismissible: false,
            duration: const Duration(seconds: 5),
            backgroundColor: Colors.red[400]!,
            icon : const Icon(Icons.wifi_off, color: Colors.white, size: 35,),
            margin: EdgeInsets.zero,
            snackStyle: SnackStyle.GROUNDED
        );
        // Reset the notification flag after a delay (e.g., 5 seconds)
        Future.delayed(Duration(seconds: 5), () {
          isNontification = false;
        });
      }

    } else {
      isNontification = false;
      isOnline.value = true;
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}