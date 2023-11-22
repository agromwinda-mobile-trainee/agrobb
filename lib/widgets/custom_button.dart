import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

Widget customButton(context,
    {Widget? icon,
    required String text,
    required Function onTap,
    Color? borderColor,
    Color? bkgColor,
    Color? textColor}) {
  return ZoomTapAnimation(
    child: InkWell(
      splashColor: Colors.grey.shade300,
      onTap: () => onTap(),
      child: Ink(
        color: Colors.transparent,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: bkgColor ?? Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: borderColor ?? Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            softWrap: true,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: textColor ?? Colors.white,
                ),
          ),
        ),
      ),
    ),
  );
  // return Container(
  //   // width: double.infinity,
  //   padding: const EdgeInsets.all(16),
  //   child: Container(
  //     width: 150,
  //     constraints: const BoxConstraints(minWidth: 150),
  //     child: ElevatedButton.icon(
  //       onPressed: () => onTap(),
  //       icon: icon ?? const SizedBox.shrink(),
  //       label: Text(
  //         text,
  //         style: const TextStyle(color: Colors.white),
  //         textAlign: TextAlign.center,
  //       ),
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: const Color.fromARGB(255, 250, 80, 80),
  //         foregroundColor: const Color.fromARGB(221, 10, 10, 10),
  //         elevation: 0,
  //         fixedSize: const Size(double.infinity, 40),
  //         shape: const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(10)),
  //         ),
  //       ),
  //     ),
  //   ),
  // );
}
