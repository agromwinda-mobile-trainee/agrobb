import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:geocoding/geocoding.dart' as geoCoding;

import '../../utils/colors.dart';

class enterDestination extends StatefulWidget {
  const enterDestination({super.key});

  @override
  State<enterDestination> createState() => _enterDestinationState();
}

class _enterDestinationState extends State<enterDestination> {
  late LatLng destination;
  Set<Marker> markers = Set<Marker>();
  GoogleMapController? myMapController;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 180,
      left: 15,
      right: 20,
      child: Container(
        width: Get.width,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 4,
                  blurRadius: 10)
            ],
            borderRadius: BorderRadius.circular(8)),
        child: TextField(
          controller: destinationController,
          // readOnly: true,
          onChanged: (String value) {
            // getPlaces();
            //
          },
          onTap: (() async {
            String selectedPlace = await showGoogleAutoComplete(context);
            destinationController.text = selectedPlace;
            List<geoCoding.Location> location =
                await geoCoding.locationFromAddress(selectedPlace);
            // destination =
            //     LatLng(locations.first.latitude, locations.first.longitude);
            // markers.add(Marker(
            //   markerId: MarkerId(selectedPlace),
            //   infoWindow: InfoWindow(
            //     title: 'Destination: $selectedPlace',
            //   ),
            //   position: destination,
            //  // icon: BitmapDescriptor.fromBytes(markIcons),
            // ));

            myMapController!.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(target: destination, zoom: 14)
                //17 is new zoom level
                ));

            setState(() {
              showSourceField = true;
            });
          }),
          style: GoogleFonts.poppins(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
          decoration: const InputDecoration(
              hintText: 'Entrez votre Destination',
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.search,
                  color: Appcolors.redColor,
                ),
              ),
              border: InputBorder.none),
        ),
      ),
    );
  }
}

Future<String> showGoogleAutoComplete(context) async {
  const kGoogleApiKey = "";
  // Prediction? p = await PlacesAutocomplete.show(
  //   offset: 0,
  //   radius: 1000,
  //   strictbounds: false,
  //   region: "us",
  //   language: "en",
  //   context: context,
  //   mode: Mode.overlay,
  //   apiKey: kGoogleApiKey,
  //   components: [new Component(Component.country, "us")],
  //   types: ["(cities)"],
  //   hint: "Search City",
  // );
  String p = 'gg';
  return p;
}

TextEditingController destinationController = TextEditingController();

bool showSourceField = false;
