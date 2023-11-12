import 'package:agrobeba/commons/home/api_contents/functions/getfunctions.dart';
import 'package:agrobeba/widgets/buildbottomsheet.dart';
import 'package:agrobeba/widgets/destination/cubits/destination_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// # import 'package:google_maps_webservice/places.dart';
import 'package:geocoding/geocoding.dart' as geoCoding;

import '../../utils/colors.dart';
import '../enterEmplacement.dart';

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
      child: Column(
        children: [
          searchBoxField(context),
          resultPlaces(context),
        ],
      ),
    );
  }
}

// Future<String> showGoogleAutoComplete(context) async {
//   const kGoogleApiKey = "AIzaSyCeISApmlA_dYJeMWgE5OsbVyGG_mzUeTc";
//   // Prediction? p = await PlacesAutocomplete.show(
//   //   offset: 0,
//   //   radius: 1000,
//   //   strictbounds: false,
//   //   region: "us",
//   //   language: "en",
//   //   context: context,
//   //   mode: Mode.overlay,
//   //   apiKey: kGoogleApiKey,
//   //   components: [new Component(Component.country, "us")],
//   //   types: ["(cities)"],
//   //   hint: "Search City",
//   // );
//   return p;
// }

TextEditingController destinationController = TextEditingController();

bool showSourceField = false;

Widget searchBoxField(context) {
  return Container(
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
      //readOnly: true,
      // onTap: (() async {
      //   String selectedPlace = await showGoogleAutoComplete(context);
      //   destinationController.text = selectedPlace;
      //   List<geoCoding.Location> location =
      //       await geoCoding.locationFromAddress(selectedPlace);
      //   // destination =
      //   //     LatLng(locations.first.latitude, locations.first.longitude);
      //   // markers.add(Marker(
      //   //   markerId: MarkerId(selectedPlace),
      //   //   infoWindow: InfoWindow(
      //   //     title: 'Destination: $selectedPlace',
      //   //   ),
      //   //   position: destination,
      //   //  // icon: BitmapDescriptor.fromBytes(markIcons),
      //   // ));
      // readOnly: true,

      // onTap: (() async {
      //   String selectedPlace = await showGoogleAutoComplete(context);
      //   destinationController.text = selectedPlace;
      //   List<geoCoding.Location> location =
      //       await geoCoding.locationFromAddress(selectedPlace);
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

      //   myMapController!.animateCamera(CameraUpdate.newCameraPosition(
      //       CameraPosition(target: destination, zoom: 14)
      //       //17 is new zoom level
      //       )
      //       );

      // }),

      onChanged: (value) {
        BlocProvider.of<DestinationCubit>(context).getPlaces(value: value);
      },
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
  );
}

Widget resultPlaces(context) {
  return BlocBuilder<DestinationCubit, DestinationState>(
      builder: (context, state) {
    List placeList = state.destination!["places"];
    if (placeList.isEmpty) {
      return SizedBox();
    }
    return Container(
      width: Get.width,
      child: Column(
          children: placeList
              .map((e) => placeItem(context, label: e["name"]))
              .toList()),
    );
  });
}

Widget placeItem(context, {required String label}) {
  return InkWell(
    onTap: () => Get.bottomSheet(Container(
      width: Get.width,
      height: Get.height * 0.5,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "confirmer la course",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 40,
          ),
          BuildSourcepart(),
          SizedBox(
            height: 20,
          ),
          Container(
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
              children: const [
                Text("A : "),
                Icon(
                  Icons.location_on,
                  color: Color.fromARGB(255, 247, 77, 65),
                ),
                Text(
                  "",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: SvgPicture.asset(
                "assets/icons/location.svg",
                color: Color.fromARGB(255, 19, 17, 17),
                height: 16,
              ),
              label: const Text("confirmer"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 250, 80, 80),
                foregroundColor: Color.fromARGB(221, 10, 10, 10),
                elevation: 0,
                fixedSize: const Size(double.infinity, 40),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
        ],
      ),
    )),
    child: Container(
      child: Text(label),
    ),
  );
}
