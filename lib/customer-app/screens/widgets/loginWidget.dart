import 'package:agrobeba/commons/home/api_contents/functions/getfunctions.dart';
import 'package:agrobeba/customer-app/screens/widgets/textWidget.dart';
import 'package:agrobeba/utils/app_constants.dart';
import 'package:agrobeba/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget loginWidget(Function onSubmit) {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textWidget(text: AppConstants.hello, color: Colors.black),
          textWidget(
              text: AppConstants.slog,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 2)
                ],
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: TextField(
                      onSubmitted: (String? input) => sendCode(input!),
                      decoration: InputDecoration(
                          helperStyle: GoogleFonts.poppins(
                              fontSize: 12, fontWeight: FontWeight.normal),
                          hintText: AppConstants.numTel,
                          border: InputBorder.none),
                    )),
                Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        width: 1,
                        height: 55,
                        color: const Color.fromARGB(255, 241, 87, 87),
                        child: Row(
                          children: [
                            textWidget(
                                text: 'Valider', color: Appcolors.redColor),
                            const Icon(
                              Icons.done,
                              color: Color.fromARGB(255, 241, 87, 87),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                  children: [
                    const TextSpan(
                      text: "${AppConstants.byCReating}  ",
                    ),
                    TextSpan(
                        text: "${AppConstants.termeServices}  ",
                        style:
                            GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                    const TextSpan(
                      text: "${AppConstants.et}  ",
                    ),
                    TextSpan(
                        text: AppConstants.policy,
                        style:
                            GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                  ]))
        ],
      ));
}
