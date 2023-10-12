import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';


class NontifiCation {
  static void showSuccessNotification(BuildContext context, String text) {
    Flushbar(
      title: "Thành công",
      message: text,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      backgroundGradient: const LinearGradient(colors: [Colors.green, Colors.blue, Colors.black54]),
      isDismissible: true,
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  static void showErrorNotification(BuildContext context, String textError) {
    Flushbar(
      title: "Lỗi",
      message: textError,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      backgroundColor: Colors.blueGrey,
      leftBarIndicatorColor: Colors.red,
      isDismissible: true,
      duration: const Duration(seconds: 3),
    ).show(context);
  }
}