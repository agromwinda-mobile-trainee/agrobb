import 'package:agrobeba/customer-app/screens/widgets/introwidget.dart';
import 'package:agrobeba/customer-app/screens/widgets/loginWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'api_contents/functions/getfunctions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SizedBox(
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
