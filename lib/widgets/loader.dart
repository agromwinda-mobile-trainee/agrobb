import 'package:flutter/material.dart';

Widget loader(context) {
  return const SizedBox(
    height: 40,
    width: 40,
    child: CircularProgressIndicator(
      color: Color.fromARGB(255, 250, 80, 80),
      strokeWidth: 2,
    ),
  );
}
