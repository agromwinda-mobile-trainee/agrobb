import 'package:agrobeba/widgets/currentlocationicon.dart';
import 'package:agrobeba/widgets/destination/cubits/destination_cubit.dart';
import 'package:agrobeba/widgets/destination/enterdestination_widget.dart';
import 'package:agrobeba/widgets/loader.dart';
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
            onTap: () => Get.bottomSheet(
              destinationFormWidget(context),
              isDismissible: true,
              elevation: 1,
              exitBottomSheetDuration: const Duration(milliseconds: 300),
              enterBottomSheetDuration: const Duration(milliseconds: 300),
            ),
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
    height: MediaQuery.of(context).size.height - 100,
    width: MediaQuery.of(context).size.width,
    decoration: bottomSheetDecoration(context),
    child: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          destinationFormWidgetHead(context),
          destinationFormWidgetInputFields(context),
          const SizedBox(height: 20),
          gettingPlacesLoader(context),
          resultPlaces(context),
        ],
      ),
    ),
  );
}

Widget gettingPlacesLoader(context) {
  return BlocBuilder<DestinationCubit, DestinationState>(
      builder: (context, state) {
    bool? gettingPlaces = state.destination!["gettingPlaces"];
    return gettingPlaces! ? loader(context) : const SizedBox.shrink();
  });
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

Widget destinationFormWidgetHead(context) {
  return Padding(
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
  );
}

Widget destinationFormWidgetInputFields(context) {
  return Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Colors.grey.shade100.withOpacity(.6),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        inputField(
          context,
          label: "Point de depart",
          hint: "9, avenue de l'Equateur, Gombe, Kinshasa...",
          prefixIcon: prefixIconStartPoint(context),
          stateField: 'startPoint',
        ),
        const SizedBox(height: 10),
        Divider(
          color: Colors.grey.shade300.withOpacity(.9),
          height: 4,
        ),
        const SizedBox(height: 16),
        inputField(
          context,
          label: "Destination",
          hint: "Kitambo, magasin, Ngaliema, Kinshasa...",
          prefixIcon: prefixIconFinalPoint(context),
          stateField: 'destinationValue',
        ),
      ],
    ),
  );
}

Widget prefixIconStartPoint(context) {
  return Container(
    height: 20,
    width: 20,
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Theme.of(context).colorScheme.primary,
    ),
    child: Container(
      padding: const EdgeInsets.all(1),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Container(
            decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        )),
      ),
    ),
  );
}

Widget prefixIconFinalPoint(context) {
  return Container(
    height: 20,
    width: 20,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.black54,
    ),
    child: const Icon(
      IconlyBold.location,
      color: Colors.white,
      size: 14,
    ),
  );
}

Widget inputField(context,
    {required String stateField,
    required String label,
    String? hint,
    Widget? prefixIcon}) {
  return Ink(
    child: TextField(
      onChanged: (String? value) {
        BlocProvider.of<DestinationCubit>(context)
            .onChangeField(field: "emplacementField", value: stateField);
        if (value!.length > 2) {
          BlocProvider.of<DestinationCubit>(context).getPlaces(value: value);
        }
      },
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: Colors.transparent,
        filled: false,
        contentPadding: const EdgeInsets.symmetric(horizontal: 2),
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIconConstraints:
            const BoxConstraints(maxHeight: 50, maxWidth: 30),
        prefixIcon: Row(
          children: [
            prefixIcon ?? prefixIconStartPoint(context),
            const SizedBox(width: 4),
          ],
        ),
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.black26,
            ),
      ),
    ),
  );
}
