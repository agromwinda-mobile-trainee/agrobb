import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget currentLocationIcon() {
  return Align(
    alignment: Alignment.bottomRight,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 30, right: 10),
      child: CircleAvatar(
        radius: 22,
        backgroundColor: Colors.red,
        child: Icon(Icons.my_location),
      ),
    ),
  );
}
