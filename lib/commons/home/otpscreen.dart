import 'package:agrobeba/commons/home/loginscreen.dart';
import 'package:agrobeba/controller/auth_controller.dart';
import 'package:agrobeba/widgets/introwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../widgets/otpScreenwidegt.dart';

class OtpScreen extends StatefulWidget {
  String phoneNumber;
  OtpScreen(this.phoneNumber);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  AuthController authController = Get.put(AuthController());
  @override
  void initState() {
    super.initState();
    authController.phoneAuth(widget.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              introWidget(),
              Positioned(
                  top: 55,
                  left: 25,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: 45,
          ),
          otpScreenwidget(),
        ],
      ),
    ));
  }
}
