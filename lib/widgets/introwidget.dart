import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

Widget introWidget() {
  return Container(
    width: Get.width,
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              'assets/images/loginscreen.jpeg',
            ),
            fit: BoxFit.cover)),
    height: Get.height * 0.6,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [Image.asset('assets/images/logo.jpg')],
    ),
  );
}
