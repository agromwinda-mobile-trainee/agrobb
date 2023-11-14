import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'destination/cubits/destination_cubit.dart';

Widget customButton(context, {Widget? icon, required String text}) {
  return Ink(
    width: Get.width,
    padding: const EdgeInsets.all(16),
    child: ElevatedButton.icon(
      onPressed: () {
        BlocProvider.of<DestinationCubit>(context).sendRequest();
      },
      icon: icon ?? const SizedBox.shrink(),
      label: Text(
        text,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 250, 80, 80),
        foregroundColor: const Color.fromARGB(221, 10, 10, 10),
        elevation: 0,
        fixedSize: const Size(double.infinity, 40),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ),
  );
}
