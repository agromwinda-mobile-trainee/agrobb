import 'package:agrobeba/controller/auth_controller.dart';
import 'package:agrobeba/customer-app/screens/widgets/introwidget.dart';
import 'package:agrobeba/customer-app/screens/widgets/otpScreenwidegt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class OtpScreen extends StatefulWidget {
  String phoneNumber;
  OtpScreen(this.phoneNumber, {super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  AuthController authController = Get.put(AuthController());
  @override
  void initState() {
    super.initState();
    // authController.phoneAuth(widget.phoneNumber);
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
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ))
            ],
          ),
          const SizedBox(
            height: 45,
          ),
          otpScreenwidget(),
        ],
      ),
    ));
  }
}
