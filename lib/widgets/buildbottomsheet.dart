import 'package:agrobeba/widgets/currentlocationicon.dart';
import 'package:agrobeba/widgets/destination/cubits/destination_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

Widget buildBottomSheet(context) {
  return Positioned(
    bottom: 0,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            currentLocationIcon(context),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          // height: 100,
          padding: const EdgeInsets.all(20),
          decoration: bottomSheetDecoration(context),
          child: InkWell(
            onTap: () => Get.bottomSheet(destinationFormWidget(context)),
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: Text(
                "Où allons-nous ?",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget destinationFormWidget(context) {
  return Container(
    height: 500,
    width: MediaQuery.of(context).size.width,
    decoration: bottomSheetDecoration(context),
    child: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 22),
            child: Row(
              children: [
                InkWell(
                  onTap: () => Get.back(),
                  splashColor: Colors.grey.shade400,
                  focusColor: Colors.grey.shade400,
                  hoverColor: Colors.grey.shade400,
                  highlightColor: Colors.grey.shade400,
                  child: Ink(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      IconlyLight.arrow_left,
                      color: Colors.black,
                      size: 22,
                      semanticLabel: "Retour",
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "Précisez l'emplacement",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                ),
              ],
            ),
          ),
          // const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade100.withOpacity(.4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Point de depart"),
                Divider(
                  color: Colors.grey.shade400,
                  height: 2,
                ),
                Text("Destination"),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Decoration bottomSheetDecoration(context) {
  return BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.5),
        blurRadius: 50,
        spreadRadius: 2,
      ),
    ],
    color: Colors.white,
    borderRadius: const BorderRadius.only(
      topRight: Radius.circular(25),
      topLeft: Radius.circular(25),
    ),
  );
}
