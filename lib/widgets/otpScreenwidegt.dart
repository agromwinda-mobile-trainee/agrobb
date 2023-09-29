import 'package:flutter/cupertino.dart';
import 'package:agrobeba/commons/home/otpscreen.dart';
import 'package:agrobeba/utils/app_constants.dart';
import 'package:agrobeba/widgets/textWidget.dart';
//import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../commons/home/Custom_pinput.dart';

Widget otpScreenwidget() {
  return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textWidget(text: AppConstants.phoneVerif, color: Colors.black),
          textWidget(
              text: AppConstants.otpSending,
              fontSize: 20,
              fontWeight: FontWeight.bold, color: Colors.black),
          const SizedBox(
            height: 15,
          ),
          Container(width: Get.width, height: 50, child: BoxPinput()),
          const SizedBox(
            height: 30,
          ),
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 12),
                  children: [
                    TextSpan(
                        text: AppConstants.resendingOtp +
                            " 10 " +
                            AppConstants.time,
                        style:
                            GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                  ]))
        ],
      ));
}
