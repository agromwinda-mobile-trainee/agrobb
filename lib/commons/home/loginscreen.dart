import 'package:agrobeba/commons/home/otpscreen.dart';
import 'package:agrobeba/widgets/loginWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../widgets/introwidget.dart';
import 'api_contents/functions/getfunctions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        width: Get.width,
        height: Get.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            introWidget(),
            const SizedBox(
              height: 30,
            ),
            loginWidget(sendCode),
          ],
        ),
      ),
    ));
  }
}
