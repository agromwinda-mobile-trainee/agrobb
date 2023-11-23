import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'buildriderconfirmation.dart';

Widget noficationIcon() {
  return Align(
    alignment: Alignment.bottomLeft,
    child: Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 27),
      child: InkWell(
        onTap: (() {
          // Get.to(buildRiderConfirmation());
        }),
        child: const CircleAvatar(
          backgroundColor: Colors.red,
          radius: 20,
          child: Icon(Icons.notifications),
        ),
      ),
    ),
  );
}
