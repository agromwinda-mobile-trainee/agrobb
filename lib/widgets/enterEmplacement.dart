import 'package:agrobeba/commons/home/autoPlace.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:google_maps_webservice/places.dart';
//import 'package:google_maps_webservice/places.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/colors.dart';
import 'package:geocoding/geocoding.dart' as geoCoding;
import 'package:agrobeba/commons/home/home.dart';

Widget enterEmplacement() {
  return Positioned(
    top: 250,
    left: 20,
    right: 20,
    child: Container(
      width: Get.width,
      height: 50,
      padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 4,
                blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(8)),
      child: TextFormField(
        controller: sourceController,
        readOnly: true,
        onTap: () async {
          // buildSourceSheet();
        },
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          hintText: 'De:',
          hintStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(
              Icons.search,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    ),
  );
}

TextEditingController sourceController = TextEditingController();

// this function is used in the destination widget

// void buildSourceSheet() {
//   Get.bottomSheet(Container(
//     width: Get.width,
//     height: Get.height * 0.5,
//     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//     decoration: BoxDecoration(
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
//         Text(
//           "Choisir un emplacement",
//           style: TextStyle(
//               color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(
//           height: 40,
//         ),
//         BuildSourcepart(),
//         SizedBox(
//           height: 20,
//         ),
//         Padding(
//           padding: EdgeInsets.all(16),
//           child: ElevatedButton.icon(
//             onPressed: () {},
//             icon: SvgPicture.asset(
//               "assets/icons/location.svg",
//               color: Color.fromARGB(255, 19, 17, 17),
//               height: 16,
//             ),
//             label: const Text("Utiliser ma position actuelle"),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Color.fromARGB(255, 172, 170, 170),
//               foregroundColor: Color.fromARGB(221, 10, 10, 10),
//               elevation: 0,
//               fixedSize: const Size(double.infinity, 40),
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(10)),
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   ));
// }

class BuildSourcepart extends StatefulWidget {
  const BuildSourcepart({super.key});

  @override
  State<BuildSourcepart> createState() => _BuildSourcepartState();
}

class _BuildSourcepartState extends State<BuildSourcepart> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        //  Get.back();
        // String place = await showGoogleAutoComplete(context);

        // sourceController.text = place;
        // List<geoCoding.Location> location =
        //     await geoCoding.locationFromAddress(place);

        // source = await authController.buildLatLngFromAddress(place);

        // if (markers.length >= 2) {
        //   markers.remove(markers.last);
        // }
        // markers.add(Marker(
        //     markerId: MarkerId(place),
        //     infoWindow: InfoWindow(
        //       title: 'Source: $place',
        //     ),
        //     position: source));

        // await getPolylines(source, destination);

        // // drawPolyline(place);

        // myMapController!.animateCamera(CameraUpdate.newCameraPosition(
        //     CameraPosition(target: source, zoom: 14)));
        setState(() {});
        // buildRideConfirmation();
      },
      child: Container(
        width: Get.width,
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  spreadRadius: 4,
                  blurRadius: 10)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("De : "),
            Icon(
              Icons.location_on,
              color: Color.fromARGB(255, 245, 73, 61),
            ),
            Text(
              "ma position",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}
