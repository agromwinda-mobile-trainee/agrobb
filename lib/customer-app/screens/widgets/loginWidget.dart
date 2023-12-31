import 'package:agrobeba/commons/home/api_contents/functions/getfunctions.dart';
import 'package:agrobeba/commons/home/otpscreen.dart';
import 'package:agrobeba/customer-app/screens/widgets/otpScreenwidegt.dart';
import 'package:agrobeba/customer-app/screens/widgets/textWidget.dart';
import 'package:agrobeba/utils/app_constants.dart';
import 'package:agrobeba/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

Widget loginWidget(Function onSubmit) {
  String fieldValue = "";
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  textWidget(
                      text: AppConstants.slog,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ]),
          ),

          textWidget(text: AppConstants.hello, color: Colors.black),
          const SizedBox(
            height: 33,
          ),
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 3,
                      blurRadius: 2)
                ],
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        width: 1,
                        height: 55,
                        color: Colors.white,
                        child: Container(
                            child: Row(
                          children: const [
                            // textWidget(
                            //     text: '  num Tel',
                            //     color: Color.fromARGB(255, 78, 77, 77)),
                            // const Icon(
                            //   Icons.done,
                            //   color: Color.fromARGB(255, 241, 87, 87),
                            // ),
                          ],
                        )),
                      ),
                    )),
                Expanded(
                    flex: 4,
                    child: TextField(
                      onChanged: ((value) {
                        fieldValue = value;
                      }),
                      // onSubmitted: (String? input) => sendCode(input!),
                      decoration: InputDecoration(
                          helperStyle: GoogleFonts.poppins(
                              fontSize: 12, fontWeight: FontWeight.normal),
                          hintText: AppConstants.numTel,
                          border: InputBorder.none),
                    )),
                // Expanded(
                //     flex: 1,
                //     child: InkWell(
                //       onTap: () {},
                //       child: Container(
                //         width: 1,
                //         height: 55,
                //         color: const Color.fromARGB(255, 241, 87, 87),
                //         child: Row(
                //           children: [
                //             textWidget(
                //                 text: 'Valider', color: Appcolors.redColor),
                //             const Icon(
                //               Icons.done,
                //               color: Color.fromARGB(255, 241, 87, 87),
                //             ),
                //           ],
                //         ),
                //       ),
                //     )),
              ],
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          // RichText(
          //     textAlign: TextAlign.center,
          //     text: TextSpan(
          //         style: const TextStyle(color: Colors.black, fontSize: 12),
          //         children: [
          //           const TextSpan(
          //             text: "${AppConstants.byCReating}  ",
          //           ),
          //           TextSpan(
          //               text: "${AppConstants.termeServices}  ",
          //               style:
          //                   GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          //           const TextSpan(
          //             text: "${AppConstants.et}  ",
          //           ),
          //           TextSpan(
          //               text: AppConstants.policy,
          //               style:
          //                   GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          //         ]))

          FittedBox(
            child: GestureDetector(
              onTap: () {
                print("done done");
                sendCode(fieldValue);
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 20, left: 20),
                padding: const EdgeInsets.symmetric(
                  horizontal: 26,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Appcolors.blackColor,
                ),
                child: Row(
                  children: const [
                    Text(
                      'Recevoir le code',
                      style: TextStyle(color: Colors.white),
                      //  style: Appcolors.whiteColor,
                      //  Theme.of(context).textTheme.labelLarge?.copyWith(
                      //       color: Appcolors.whiteColor,
                      //     ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.arrow_forward,
                      color: Appcolors.redColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ));
}
