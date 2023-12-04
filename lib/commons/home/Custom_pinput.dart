import 'package:agrobeba/commons/home/authLogic/cubit/login_process_cubit.dart';
import 'package:agrobeba/controller/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import 'api_contents/functions/getfunctions.dart';

class BoxPinput extends StatefulWidget {
  const BoxPinput({super.key});

  @override
  State<BoxPinput> createState() => _BoxPinputState();
  @override
  String toStringShort() => 'rounded with shadow';
}

class _BoxPinputState extends State<BoxPinput> {
  @override
  final controller = TextEditingController();
  final focusNode = FocusNode();

  AuthController authController = Get.find<AuthController>();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    String phoneNumber = BlocProvider.of<LoginProcessCubit>(context)
        .state
        .usercontent!["Telephone"];
    final DefaultpinTheme = PinTheme(
      width: 60,
      height: 64,
      textStyle: GoogleFonts.poppins(
          fontSize: 20, color: Color.fromARGB(70, 69, 66, 1)),
      decoration: BoxDecoration(
          color: Color.fromRGBO(232, 235, 241, 0.37),
          borderRadius: BorderRadius.circular(8)),
    );
    final cursor = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 21,
        height: 1,
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
            color: Color.fromRGBO(137, 146, 160, 1),
            borderRadius: BorderRadius.circular(8)),
      ),
    );
    return Pinput(
      length: 6,
      controller: controller,
      focusNode: focusNode,
      onCompleted: (String input) {
        otpVerifyDriver(input, phoneNumber);
      },
      defaultPinTheme: DefaultpinTheme.copyWith(
          decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.5999999865889549),
              offset: Offset(0, 3),
              blurRadius: 16)
        ],
      )),
      separator: SizedBox(width: 14),
      focusedPinTheme: DefaultpinTheme.copyWith(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.5999999865889549),
              offset: Offset(0, 3),
              blurRadius: 14,
            )
          ])),
      showCursor: true,
      cursor: cursor,
    );
  }
}
