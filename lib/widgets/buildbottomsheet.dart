import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildBottomSheet() {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      width: Get.width * 0.8,
      height: 24,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 4),
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12), topLeft: Radius.circular(12))),
      child: Center(
        child: Container(
          width: Get.width * 0.6,
          height: 4,
          color: Colors.black45,
        ),
      ),
    ),
  );
}
