import 'package:flutter/material.dart';
import 'package:user_crud/widget/home.dart';

void main() {
  runApp( MaterialApp(
    home: MyWidget(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyWidget  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }

}



