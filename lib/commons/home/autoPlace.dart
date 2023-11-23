// import 'package:agrobeba/utils/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';

// class AutoPlace extends StatefulWidget {
//   const AutoPlace({super.key});

//   @override
//   State<AutoPlace> createState() => _AutoPlaceState();
// }

// class _AutoPlaceState extends State<AutoPlace> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Appcolors.whiteColor,
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 16),
//           child: CircleAvatar(
//             backgroundColor: Color.fromARGB(255, 245, 46, 46),
//             child: SvgPicture.asset(
//               "assets/icons/location.svg",
//               height: 16,
//               width: 16,
//               color: Color.fromARGB(255, 247, 244, 244),
//             ),
//           ),
//         ),
//         title: const Text(
//           "Donner une position",
//           style: TextStyle(color: Color.fromARGB(255, 5, 5, 5)),
//         ),
//         actions: [
//           CircleAvatar(
//             backgroundColor: Color.fromARGB(255, 245, 46, 46),
//             child: IconButton(
//               onPressed: () {
//                 Get.back();
//               },
//               icon: const Icon(Icons.close,
//                   color: Color.fromARGB(255, 247, 245, 245)),
//             ),
//           ),
//           const SizedBox(width: 16)
//         ],
//       ),
//       body: Column(
//         children: [
//           Form(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: TextFormField(
//                 onChanged: (value) {},
//                 textInputAction: TextInputAction.search,
//                 decoration: InputDecoration(
//                   hintText: "De :",
//                   prefixIcon: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     child: SvgPicture.asset(
//                       "assets/icons/location_pin.svg",
//                       color: Color.fromARGB(255, 5, 5, 5),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const Divider(
//             height: 4,
//             thickness: 4,
//             color: Color.fromARGB(255, 180, 179, 179),
//           ),
//           Padding(
//             padding: EdgeInsets.all(16),
//             child: ElevatedButton.icon(
//               onPressed: () {
//                 Get.to(buildRiderConfirmation());
//               },
//               icon: SvgPicture.asset(
//                 "assets/icons/location.svg",
//                 color: Appcolors.whiteColor,
//                 height: 16,
//               ),
//               label: const Text("Utiliser ma position actuelle"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color.fromARGB(255, 250, 46, 46),
//                 foregroundColor: Color.fromARGB(221, 253, 252, 252),
//                 elevation: 0,
//                 fixedSize: const Size(double.infinity, 40),
//                 shape: const RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(10)),
//                 ),
//               ),
//             ),
//           ),
//           const Divider(
//             height: 4,
//             thickness: 4,
//             color: Color.fromARGB(255, 182, 180, 180),
//           ),
//           LocationListTile(
//             press: () {},
//             location: "station total,magasin, kinshasa",
//           ),
//         ],
//       ),
//     );
//   }
// }
