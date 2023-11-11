import 'dart:convert';

import 'package:agrobeba/widgets/destination/enterdestination_widget.dart';
import 'package:agrobeba/widgets/notificationicon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

import '../../widgets/buildbottomsheet.dart';
import '../../widgets/currentlocationicon.dart';
import '../../widgets/enterEmplacement.dart';
import '../../widgets/widget_build_Tile.dart';
import 'drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late LatLng source;
  Set<Marker> markers = Set<Marker>();

  String? _mapStyle;

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((String) {
      _mapStyle = String;
    });
  }

  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(-4.325, 15.322222),
    //target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  GoogleMapController? myMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BuildDrawer(),
      body: Stack(
        children: [
          GoogleMap(
            markers: markers,
            zoomControlsEnabled: false,
            // mapType: MapType.terrain,
            onMapCreated: (GoogleMapController controller) {
              myMapController = controller;
              myMapController!.setMapStyle(_mapStyle);
            },
            initialCameraPosition: _kGooglePlex,
          ),
          buildProfileTile(),
          enterDestination(),
          // destinationInputField(context),
          showSourceField ? enterEmplacement() : Container(),
          currentLocationIcon(),
          noficationIcon(),
          buildBottomSheet(),
        ],
      ),
    );
  }
}

List<Map> places = [
  {
    "id": "jdkskdf",
    "name": "ngaliema",
  },
  {
    "id": "jdkskdf",
    "name": "ngaliema",
  },
  {
    "id": "jdkskdf",
    "name": "ngaliema",
  },
  {
    "id": "jdkskdf",
    "name": "ngaliema",
  },
];
