// import 'package:agrobeba/customer-app/screens/home.dart';
// import 'package:agrobeba/customer-app/screens/widgets/introwidget.dart';
// import 'package:agrobeba/customer-app/screens/widgets/textWidget.dart';
// import 'package:agrobeba/utils/colors.dart';
// import 'package:flutter/material.dart';

// class Confimation extends StatelessWidget {
//   const Confimation({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           introWidget(),
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 textWidget(
//                     text: 'Merci d avoir utilisé(e) agrobeba',
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black),
//                 textWidget(
//                     text: 'Votre taxi arrive',
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black),
//                 FittedBox(
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const HomeScreen(),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.only(bottom: 20),
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 26,
//                         vertical: 16,
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(25),
//                         color: Appcolors.blackColor,
//                       ),
//                       child: Row(
//                         children: [
//                           Text(
//                             'reload',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .labelLarge
//                                 ?.copyWith(
//                                   color: Appcolors.whiteColor,
//                                 ),
//                           ),
//                           const SizedBox(width: 10),
//                           const Icon(
//                             Icons.arrow_forward,
//                             color: Appcolors.redColor,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
