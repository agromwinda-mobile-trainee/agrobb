import 'package:agrobeba/commons/home/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildProfileTile() {
  return Positioned(
      top: 60,
      right: 20,
      left: 20,
      child: Container(
          width: Get.width,
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    Get.to(BuildDrawer());
                  },
                  child: Icon(Icons.menu)
                  // const CircleAvatar(
                  //   radius: 17,
                  //   backgroundColor: Colors.black,
                  // ),
                  ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                        text: 'Bienvenu à bord',
                        style: TextStyle(color: Colors.black, fontSize: 14)),
                  ])),
                  const Text(
                    "Ou allez-vous ?",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          )));
}
