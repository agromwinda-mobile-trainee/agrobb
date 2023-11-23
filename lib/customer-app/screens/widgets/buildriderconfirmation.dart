// import 'package:agrobeba/commons/home/confirmation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// buildRiderConfirmation() {
//   Get.bottomSheet(Container(
//     width: Get.width,
//     height: Get.height * 0.4,
//     padding: const EdgeInsets.only(left: 20),
//     decoration: const BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.only(
//           topRight: Radius.circular(12), topLeft: Radius.circular(12)),
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(
//           height: 10,
//         ),
//         Center(
//           child: Container(
//             width: Get.width * 0.2,
//             height: 8,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8), color: Colors.grey),
//           ),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         textWidget(
//             text: 'choisir une option:',
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.black),
//         const SizedBox(
//           height: 20,
//         ),
//         buildDriversList(),
//         const SizedBox(
//           height: 16,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(right: 20),
//           child: Divider(),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(right: 20),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Expanded(child: buildPaymentCardWidget()),
//               MaterialButton(
//                 onPressed: () {
//                   Get.to(Confimation());
//                 },
//                 child: textWidget(
//                   text: 'Confirmer',
//                   color: Colors.white,
//                 ),
//                 color: Colors.red,
//                 shape: StadiumBorder(),
//               )
//             ],
//           ),
//         )
//       ],
//     ),
//   ));
// }

// int selectedRide = 0;

// buildDriversList() {
//   return Container(
//     height: 90,
//     width: Get.width,
//     child: StatefulBuilder(builder: (context, set) {
//       return ListView.builder(
//         itemBuilder: (ctx, i) {
//           return InkWell(
//             onTap: () {
//               set(() {
//                 selectedRide = i;
//               });
//             },
//             child: buildDriverCard(selectedRide == i),
//           );
//         },
//         itemCount: 3,
//         scrollDirection: Axis.horizontal,
//       );
//     }),
//   );
// }

// buildDriverCard(bool selected) {
//   return Container(
//     margin: EdgeInsets.only(right: 8, left: 8, top: 4, bottom: 4),
//     height: 85,
//     width: 165,
//     decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//               color: selected
//                   ? Color.fromARGB(255, 224, 61, 61).withOpacity(0.2)
//                   : Colors.grey.withOpacity(0.2),
//               offset: Offset(0, 5),
//               blurRadius: 5,
//               spreadRadius: 1)
//         ],
//         borderRadius: BorderRadius.circular(12),
//         color: selected ? Color.fromARGB(255, 206, 51, 51) : Colors.grey),
//     child: Stack(
//       children: [
//         Container(
//           padding: EdgeInsets.only(left: 8, top: 6, bottom: 6, right: 8),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               textWidget(
//                   text: 'Standard',
//                   color: Colors.white,
//                   fontWeight: FontWeight.w700),
//               textWidget(
//                   text: '\$9.90',
//                   color: Colors.white,
//                   fontWeight: FontWeight.w500),
//               textWidget(
//                   text: '3 MIN',
//                   color: Colors.white.withOpacity(0.8),
//                   fontWeight: FontWeight.normal,
//                   fontSize: 12),
//             ],
//           ),
//         ),
//         Positioned(
//             right: -48,
//             top: 0,
//             bottom: 0,
//             child: Image.asset('assets/images/taxitwo.png'))
//       ],
//     ),
//   );
// }
