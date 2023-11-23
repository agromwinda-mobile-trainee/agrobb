import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

Widget currentLocationIcon(context) {
  return ZoomTapAnimation(
    onTap: () {},
    onLongTap: () {},
    enableLongTapRepeatEvent: false,
    longTapRepeatDuration: const Duration(milliseconds: 100),
    begin: 1.0,
    end: 0.93,
    beginDuration: const Duration(milliseconds: 20),
    endDuration: const Duration(milliseconds: 120),
    beginCurve: Curves.decelerate,
    endCurve: Curves.fastOutSlowIn,
    child: InkWell(
      onTap: () {
        // sendCourseRequest();
      },
      child: Container(
        // padding: const EdgeInsets.only(bottom: 30, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 70,
              spreadRadius: 1,
            ),
          ],
        ),
        child: const CircleAvatar(
          radius: 28,
          backgroundColor: Colors.white,
          child: Icon(
            IconlyLight.location,
            size: 26,
            color: Colors.black54,
          ),
        ),
      ),
    ),
  );
}
