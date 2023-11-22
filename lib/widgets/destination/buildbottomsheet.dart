import 'package:agrobeba/widgets/currentlocationicon.dart';
import 'package:agrobeba/widgets/destination/cubits/destination_cubit.dart';
import 'package:agrobeba/widgets/destination/enterdestination_widget.dart';
import 'package:agrobeba/widgets/destination/input_form_fields.dart';
import 'package:agrobeba/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class BuildBottomSheet extends StatefulWidget {
  const BuildBottomSheet({super.key});

  @override
  State<BuildBottomSheet> createState() => _BuildBottomSheetState();
}

class _BuildBottomSheetState extends State<BuildBottomSheet> {
  TextEditingController startPointTextController = TextEditingController();
  TextEditingController destinationTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return buildBottomSheet(context);
  }

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
                isDismissible: false,
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
            resultPlaces(
              context,
              destinationTextController: destinationTextController,
              startPointTextController: startPointTextController,
            ),
          ],
        ),
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
          InputFormFields(
            label: "Point de depart",
            hint: "9, avenue de l'Equateur, Gombe, Kinshasa...",
            prefixIcon: prefixIconStartPoint(context),
            stateField: 'startPoint',
            initialValue: "startPoint",
            textController: startPointTextController,
          ),
          const SizedBox(height: 10),
          Divider(
            color: Colors.grey.shade300.withOpacity(.9),
            height: 4,
          ),
          const SizedBox(height: 16),
          InputFormFields(
            label: "Destination",
            hint: "Kitambo, magasin, Ngaliema, Kinshasa...",
            prefixIcon: prefixIconFinalPoint(context),
            stateField: 'destinationValue',
            initialValue: "destination",
            textController: destinationTextController,
          ),
        ],
      ),
    );
  }
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
          onTap: () => {
            Get.back(),
            BlocProvider.of<DestinationCubit>(context)
                .onChangeField(field: "places", value: []),
          },
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