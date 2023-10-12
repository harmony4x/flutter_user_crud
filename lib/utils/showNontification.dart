import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';


class NontifiCation {
  static void showSuccessNotification(BuildContext context) {
    Flushbar(
      title: "Success",
      message: "Update successful",
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      backgroundGradient: const LinearGradient(colors: [Colors.green, Colors.blue, Colors.black54]),
      isDismissible: true,
      duration: const Duration(seconds: 3),
    ).show(context);
  }
}