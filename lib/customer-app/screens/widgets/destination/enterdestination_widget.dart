// import 'package:agrobeba/customer-app/screens/widgets/destination/cubits/destination_cubit.dart';
// import 'package:agrobeba/utils/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// // # import 'package:google_maps_webservice/places.dart';
// import 'package:iconly/iconly.dart';
// import '../custom_button.dart';
// import '../enterEmplacement.dart';
// import '../loader.dart';

// class enterDestination extends StatefulWidget {
//   const enterDestination({super.key});

//   @override
//   State<enterDestination> createState() => _enterDestinationState();
// }

// class _enterDestinationState extends State<enterDestination> {
//   late LatLng destination;
//   Set<Marker> markers = Set<Marker>();
//   GoogleMapController? myMapController;
//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       top: 180,
//       left: 15,
//       right: 20,
//       child: Column(
//         children: [
//           searchBoxField(context),
//           // resultPlaces(context),
//         ],
//       ),
//     );
//   }
// }

// // Future<String> showGoogleAutoComplete(context) async {
// //   const kGoogleApiKey = "AIzaSyCeISApmlA_dYJeMWgE5OsbVyGG_mzUeTc";
// //   // Prediction? p = await PlacesAutocomplete.show(
// //   //   offset: 0,
// //   //   radius: 1000,
// //   //   strictbounds: false,
// //   //   region: "us",
// //   //   language: "en",
// //   //   context: context,
// //   //   mode: Mode.overlay,
// //   //   apiKey: kGoogleApiKey,
// //   //   components: [new Component(Component.country, "us")],
// //   //   types: ["(cities)"],
// //   //   hint: "Search City",
// //   // );
// //   return p;
// // }

// TextEditingController destinationController = TextEditingController();

// bool showSourceField = false;

// Widget searchBoxField(context) {
//   return Container(
//     width: Get.width,
//     height: 50,
//     decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               spreadRadius: 4,
//               blurRadius: 10)
//         ],
//         borderRadius: BorderRadius.circular(8)),
//     child: TextField(
//       controller: destinationController,
//       //readOnly: true,
//       // onTap: (() async {
//       //   String selectedPlace = await showGoogleAutoComplete(context);
//       //   destinationController.text = selectedPlace;
//       //   List<geoCoding.Location> location =
//       //       await geoCoding.locationFromAddress(selectedPlace);
//       //   // destination =
//       //   //     LatLng(locations.first.latitude, locations.first.longitude);
//       //   // markers.add(Marker(
//       //   //   markerId: MarkerId(selectedPlace),
//       //   //   infoWindow: InfoWindow(
//       //   //     title: 'Destination: $selectedPlace',
//       //   //   ),
//       //   //   position: destination,
//       //   //  // icon: BitmapDescriptor.fromBytes(markIcons),
//       //   // ));
//       // readOnly: true,

//       // onTap: (() async {
//       //   String selectedPlace = await showGoogleAutoComplete(context);
//       //   destinationController.text = selectedPlace;
//       //   List<geoCoding.Location> location =
//       //       await geoCoding.locationFromAddress(selectedPlace);
//       // destination =
//       //     LatLng(locations.first.latitude, locations.first.longitude);
//       // markers.add(Marker(
//       //   markerId: MarkerId(selectedPlace),
//       //   infoWindow: InfoWindow(
//       //     title: 'Destination: $selectedPlace',
//       //   ),
//       //   position: destination,
//       //  // icon: BitmapDescriptor.fromBytes(markIcons),
//       // ));

//       //   myMapController!.animateCamera(CameraUpdate.newCameraPosition(
//       //       CameraPosition(target: destination, zoom: 14)
//       //       //17 is new zoom level
//       //       )
//       //       );

//       // }),

//       onChanged: (value) {
//         if (value.toString().length > 2) {
//           BlocProvider.of<DestinationCubit>(context).getPlaces(value: value);
//         }
//       },
//       style: GoogleFonts.poppins(
//           fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
//       decoration: const InputDecoration(
//           hintText: 'Entrez votre Destination',
//           prefixIcon: Padding(
//             padding: EdgeInsets.only(left: 10),
//             child: Icon(
//               Icons.search,
//               color: Appcolors.redColor,
//             ),
//           ),
//           border: InputBorder.none),
//     ),
//   );
// }





// Widget bottomcall(context) {
//   return BlocBuilder<DestinationCubit, DestinationState>(
//       builder: (context, state) {
//     int step = state.destination!["step"];
//     if (step == 1) {
//       return courseCommandeWidget(context);
//     }

//     if (step == 2) {
//       return courseDetailsWidget(context);
//     }

//     if (step == 3) {
//       return drivers(context);
//     }

//     if (step == 4) {
//       return waitingForDriver(context);
//     }

//     return const SizedBox.shrink();
//   });
// }

// Widget waitingForDriver(context) {
//   return Ink(
//     width: Get.width,
//     height: 400,
//     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//     decoration: const BoxDecoration(
//         borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(8), topRight: Radius.circular(8)),
//         color: Colors.white),
//     child: SingleChildScrollView(
//       child: Column(
//         children: [
//           courseDetailsItem(context,
//               text: "En attente d'une confirmation du taxi..."),
//         ],
//       ),
//     ),
//   );
// }

// Widget drivers(context) {
//   return Ink(
//     width: Get.width,
//     height: 400,
//     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//     decoration: const BoxDecoration(
//         borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(8), topRight: Radius.circular(8)),
//         color: Colors.white),
//     child: BlocBuilder<DestinationCubit, DestinationState>(
//         builder: (context, state) {
//       List? drivers = state.destination!["drivers"];

//       if (drivers!.isEmpty) {
//         return const Center(child: Text("Recherche des taxi encours..."));
//       }

//       return SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Voiture(s) disponible",
//               style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                     color: Colors.black54,
//                     fontSize: 24,
//                     fontWeight: FontWeight.w400,
//                   ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 40),
//             if (state.destination!["error"] != '')
//               Text(
//                 state.destination!["error"],
//                 style: const TextStyle(color: Colors.red),
//               ),
//             Column(
//               children: drivers
//                   .map((driver) => courseDetailsItem(context,
//                       driver: driver,
//                       text: driver["names"] +
//                           ' à' +
//                           driver["distance"].toString() +
//                           'm'))
//                   .toList(),
//             ),
//           ],
//         ),
//       );
//     }),
//   );
// }

// // Widget courseDetailsWidget(context) {
// //   return Ink(
// //     width: Get.width,
// //     height: 400,
// //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// //     decoration: const BoxDecoration(
// //         borderRadius: BorderRadius.only(
// //             topLeft: Radius.circular(8), topRight: Radius.circular(8)),
// //         color: Colors.white),
// //     child: SingleChildScrollView(
// //       child: BlocBuilder<DestinationCubit, DestinationState>(
// //           builder: (context, state) {
// //         Map? courseDetails = state.destination!["currentService"];
// //         return Column(
// //           children: [
// //             courseDetailsItem(context,
// //                 text: courseDetails!["totalAmount"].toString() +
// //                     courseDetails["currency"].toString()),
// //             courseDetailsItem(context, text: courseDetails["service"]["name"]),
// //             courseDetailsItem(context, text: "Autres détails C"),
// //             customButton(context,
// //                 text: "Commander un taxi",
// //                 icon: SvgPicture.asset(
// //                   "assets/icons/location.svg",
// //                   color: Colors.grey.shade100,
// //                   height: 16,
// //                 ),
// //                 onTap: () => BlocProvider.of<DestinationCubit>(context)
// //                     .findAvailableCar()),
// //           ],
// //         );
// //       }),
// //     ),
// //   );
// // }

// Widget courseDetailsItem(context, {required String text, Map? driver}) {
//   return InkWell(
//     onTap: () {
//       if (driver!.isNotEmpty) {
//         BlocProvider.of<DestinationCubit>(context).onChooseDriver(driver["id"]);
//         return;
//       }
//     },
//     child: Container(
//       width: Get.width,
//       height: 50,
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       margin: const EdgeInsets.only(bottom: 10),
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: [
//             BoxShadow(
//                 color: Colors.black.withOpacity(0.04),
//                 spreadRadius: 4,
//                 blurRadius: 10)
//           ]),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(
//             Icons.monetization_on,
//             color: Colors.grey,
//           ),
//           const SizedBox(width: 10),
//           Text(
//             text,
//             style: const TextStyle(
//                 color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),
//             textAlign: TextAlign.start,
//             softWrap: true,
//           ),
//         ],
//       ),
//     ),
//   );
// }

// Widget courseCommandeWidget(context) {
//   return Ink(
//     width: Get.width,
//     height: 400,
//     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//     decoration: const BoxDecoration(
//         borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(8), topRight: Radius.circular(8)),
//         color: Colors.white),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         const SizedBox(
//           height: 10,
//         ),
//         const Text(
//           "Confirmer la course",
//           style: TextStyle(
//               color: Colors.black54, fontSize: 22, fontWeight: FontWeight.w400),
//         ),
//         const SizedBox(
//           height: 40,
//         ),
//         const BuildSourcepart(),
//         const SizedBox(
//           height: 20,
//         ),
//         Container(
//           width: Get.width,
//           height: 50,
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               boxShadow: [
//                 BoxShadow(
//                     color: Colors.black.withOpacity(0.04),
//                     spreadRadius: 4,
//                     blurRadius: 10)
//               ]),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text("A : "),
//               const Icon(
//                 Icons.location_on,
//                 color: Color.fromARGB(255, 247, 77, 65),
//               ),
//               BlocBuilder<DestinationCubit, DestinationState>(
//                 builder: (context, state) {
//                   return Text(
//                     state.destination!["destinationValue"]['name'],
//                     style: const TextStyle(
//                         color: Colors.black,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600),
//                     textAlign: TextAlign.start,
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(
//           height: 15,
//         ),
//         BlocBuilder<DestinationCubit, DestinationState>(
//             builder: (context, state) {
//           if (!state.destination!['loading']) {
//             return const SizedBox.shrink();
//           }
//           return loader(context);
//         }),
//         const SizedBox(
//           height: 15,
//         ),
//         customButton(
//           context,
//           text: "Confirmer",
//           icon: SvgPicture.asset(
//             "assets/icons/location.svg",
//             color: Colors.grey.shade100,
//             height: 16,
//           ),
//           onTap: () => BlocProvider.of<DestinationCubit>(context).sendRequest(),
//         ),
//       ],
//     ),
//   );
// }
