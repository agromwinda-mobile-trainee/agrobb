import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget customButton(context,
    {Widget? icon, required String text, required Function onTap}) {
  return Ink(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    child: ElevatedButton.icon(
      onPressed: () => onTap(),
      icon: icon ?? const SizedBox.shrink(),
      label: Text(
        text,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 250, 80, 80),
        foregroundColor: const Color.fromARGB(221, 10, 10, 10),
        elevation: 0,
        fixedSize: const Size(double.infinity, 40),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ),
  );
}
