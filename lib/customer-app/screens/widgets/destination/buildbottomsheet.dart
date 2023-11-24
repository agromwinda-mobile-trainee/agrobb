<<<<<<< HEAD:lib/customer-app/screens/widgets/destination/buildbottomsheet.dart
import 'package:agrobeba/customer-app/screens/widgets/currentlocationicon.dart';
import 'package:agrobeba/customer-app/screens/widgets/custom_button.dart';
import 'package:agrobeba/customer-app/screens/widgets/destination/cubits/destination_cubit.dart';
import 'package:agrobeba/customer-app/screens/widgets/destination/enterdestination_widget.dart';
import 'package:agrobeba/customer-app/screens/widgets/destination/input_form_fields.dart';
import 'package:agrobeba/utils/app_constants.dart';
=======
import 'package:agrobeba/widgets/currentlocationicon.dart';
import 'package:agrobeba/widgets/destination/cubits/destination_cubit.dart';
import 'package:agrobeba/widgets/destination/enterdestination_widget.dart';
import 'package:agrobeba/widgets/destination/input_form_fields.dart';
import 'package:agrobeba/widgets/loader.dart';
>>>>>>> origin/Driver:lib/widgets/destination/buildbottomsheet.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
<<<<<<< HEAD:lib/customer-app/screens/widgets/destination/buildbottomsheet.dart
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
=======
>>>>>>> origin/Driver:lib/widgets/destination/buildbottomsheet.dart

class BuildBottomSheet extends StatefulWidget {
  const BuildBottomSheet({super.key});

  @override
  State<BuildBottomSheet> createState() => _BuildBottomSheetState();
}

<<<<<<< HEAD:lib/customer-app/screens/widgets/destination/buildbottomsheet.dart
class _BuildBottomSheetState extends State<BuildBottomSheet>
    with SingleTickerProviderStateMixin {
  TextEditingController startPointTextController = TextEditingController();
  TextEditingController destinationTextController = TextEditingController();
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: const Duration(seconds: 10),
    );
  }
=======
class _BuildBottomSheetState extends State<BuildBottomSheet> {
  TextEditingController startPointTextController = TextEditingController();
  TextEditingController destinationTextController = TextEditingController();
>>>>>>> origin/Driver:lib/widgets/destination/buildbottomsheet.dart

  @override
  void dispose() {
    startPointTextController.dispose();
    destinationTextController.dispose();
<<<<<<< HEAD:lib/customer-app/screens/widgets/destination/buildbottomsheet.dart
    _controller.dispose();
=======
>>>>>>> origin/Driver:lib/widgets/destination/buildbottomsheet.dart
    super.dispose();
  }

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
                isScrollControlled: true,
                useRootNavigator: true,
                elevation: 1,
                enableDrag: false,
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
<<<<<<< HEAD:lib/customer-app/screens/widgets/destination/buildbottomsheet.dart
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: BlocBuilder<DestinationCubit, DestinationState>(
          builder: (context, state) {
        if (state.destination!["step"] == 0) {
          return emplacement(context);
        }

        if (state.destination!["step"] == 1) {
          return courseDetails(context);
        }

        if (state.destination!["step"] == 2) {
          return waitingForDriverConfirmation(context);
        }

        return const SizedBox.shrink();
      }),
    );
  }

  Widget waitingForDriverConfirmation(context) {
    return Container(
      height: 400,
      width: MediaQuery.of(context).size.width,
      decoration: bottomSheetDecoration(context),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            destinationFormWidgetHead(
              context,
              title: "Commande envoyée",
              onTap: () {},
            ),
            waittingAnimationWidget(context),
            const SizedBox(height: 20),
            Center(
              child: Text(
                "En attente de la confirmation d'un chauffeur...",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            customButton(
              context,
              text: "Annuler la course",
              onTap: () {},
              bkgColor: Colors.transparent,
              textColor: Theme.of(context).colorScheme.primary,
              borderColor: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget waittingAnimationWidget(context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: SpinKitSpinningLines(
        color: Colors.grey.shade200,
        duration: const Duration(seconds: 5),
        lineWidth: 3,
        size: 200.0,
        itemCount: 2,
        // controller: _controller,
      ),
    );
  }

  Widget courseDetails(context) {
    return Container(
      height: 400,
      width: MediaQuery.of(context).size.width,
      decoration: bottomSheetDecoration(context),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: destinationFormWidgetHead(
                context,
                title: "Détails de la course",
                onTap: () => BlocProvider.of<DestinationCubit>(context)
                    .onChangeField(field: "step", value: 0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: destinationDetails(context),
            ),
            const SizedBox(height: 22),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BlocBuilder<DestinationCubit, DestinationState>(
                  builder: (context, state) {
                return Row(
                  children: [
                    const SizedBox(width: 20),
                    driversWidget(
                      context,
                      imageAsset: 'assets/images/cars/car1.png',
                      type: "Standard",
                      serviceID: 1,
                      price:
                          "${state.destination!["currentService"]["totalAmount"] * AppConstants.standardCar * AppConstants.usdToCdf} CDF",
                    ),
                    driversWidget(
                      context,
                      imageAsset: 'assets/images/cars/car2.png',
                      type: "Class",
                      serviceID: 2,
                      price:
                          "${state.destination!["currentService"]["totalAmount"] * AppConstants.comfortCar * AppConstants.usdToCdf} CDF",
                    ),
                    driversWidget(
                      context,
                      imageAsset: 'assets/images/cars/car3.png',
                      type: "Comfort",
                      serviceID: 3,
                      price:
                          "${state.destination!["currentService"]["totalAmount"] * AppConstants.classCar * AppConstants.usdToCdf} CDF",
                    ),
                  ],
                );
              }),
            ),
            const SizedBox(height: 20),
            BlocBuilder<DestinationCubit, DestinationState>(
                builder: (context, state) {
              if (state.destination!["selectedServiceID"] == 0) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: customButton(
                  context,
                  text: "Commandez",
                  onTap: () {
                    // BlocProvider.of<DestinationCubit>(context).sendRequest();
                    BlocProvider.of<DestinationCubit>(context)
                        .onChangeField(field: "step", value: 2);
                  },
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  Widget driversWidget(
    context, {
    required String imageAsset,
    required String price,
    required String type,
    required int serviceID,
  }) {
    return ZoomTapAnimation(
      onTap: () {
        BlocProvider.of<DestinationCubit>(context)
            .onChangeField(field: "selectedServiceID", value: serviceID);
      },
      child: BlocBuilder<DestinationCubit, DestinationState>(
          builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: (state.destination!["selectedServiceID"] == serviceID)
                ? Theme.of(context).colorScheme.primary
                : Colors.grey.shade200.withOpacity(.6),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                imageAsset,
                width: 60,
                height: 40,
              ),
              Text(
                type,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 12,
                      color:
                          (state.destination!["selectedServiceID"] == serviceID)
                              ? Colors.white54
                              : Colors.black,
                    ),
                textAlign: TextAlign.start,
              ),
              Text(
                price,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.4,
                      color:
                          (state.destination!["selectedServiceID"] == serviceID)
                              ? Colors.white
                              : Colors.black,
                    ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget destinationDetails(context) {
    return Flex(
      direction: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Destination",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600),
            ),
            BlocBuilder<DestinationCubit, DestinationState>(
                builder: (context, state) {
              return Text(
                state.destination!["destinationValue"]?["name"] ??
                    "Avenue de l'Equateur",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 14,
                      color: Colors.black,
                    ),
              );
            }),
          ],
        ),
        const Expanded(child: SizedBox()),
        distance(context),
      ],
    );
  }

  Widget distance(context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(children: [
        const Icon(
          IconlyBroken.discovery,
          size: 12,
          color: Colors.black87,
        ),
        const SizedBox(width: 22),
        BlocBuilder<DestinationCubit, DestinationState>(
            builder: (context, state) {
          String distance = state.destination!["currentService"]["service"]
                  ["distance"] ??
              "10";
          return Text(
            "$distance km",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
          );
        })
      ]),
    );
  }

  Widget emplacement(context) {
=======
>>>>>>> origin/Driver:lib/widgets/destination/buildbottomsheet.dart
    return Container(
      height: MediaQuery.of(context).size.height - 250,
      width: MediaQuery.of(context).size.width,
      decoration: bottomSheetDecoration(context),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
<<<<<<< HEAD:lib/customer-app/screens/widgets/destination/buildbottomsheet.dart
            destinationFormWidgetHead(context,
                title: "Précisez l'emplacement",
                onTap: () => {
                      Get.back(),
                      BlocProvider.of<DestinationCubit>(context)
                          .onChangeField(field: "places", value: []),
                    }),
=======
            destinationFormWidgetHead(context),
>>>>>>> origin/Driver:lib/widgets/destination/buildbottomsheet.dart
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

<<<<<<< HEAD:lib/customer-app/screens/widgets/destination/buildbottomsheet.dart
Widget destinationFormWidgetHead(context,
    {required String title, required Function onTap}) {
=======
Widget destinationFormWidgetHead(context) {
>>>>>>> origin/Driver:lib/widgets/destination/buildbottomsheet.dart
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 22),
    child: Row(
      children: [
        InkWell(
<<<<<<< HEAD:lib/customer-app/screens/widgets/destination/buildbottomsheet.dart
          onTap: () => onTap(),
=======
          onTap: () => {
            Get.back(),
            BlocProvider.of<DestinationCubit>(context)
                .onChangeField(field: "places", value: []),
          },
>>>>>>> origin/Driver:lib/widgets/destination/buildbottomsheet.dart
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
<<<<<<< HEAD:lib/customer-app/screens/widgets/destination/buildbottomsheet.dart
          title,
=======
          "Précisez l'emplacement",
>>>>>>> origin/Driver:lib/widgets/destination/buildbottomsheet.dart
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
