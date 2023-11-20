import 'package:agrobeba/widgets/widget_build_Tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../commons/home/drawer.dart';

class HomeDriver extends StatefulWidget {
  const HomeDriver({super.key});

  @override
  State<HomeDriver> createState() => _HomeDriverState();
}

class _HomeDriverState extends State<HomeDriver> {
  late LatLng source;
  Set<Marker> markers = Set<Marker>();
  String? _mapStyle;

  @override
  void initState() {
    rootBundle.loadString('assets/map_style.txt').then((String) {
      _mapStyle = String;
    });
    // permanentRequest();
    super.initState();
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
          awaitForCommandes(context),
        ],
      ),
    );
  }
}

Widget awaitForCommandes(context) {
  return Positioned(
    bottom: 0,
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: 400,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: const Center(
        child: Text(
          "En attente d'une course...",
          style: TextStyle(color: Colors.black),
        ),
      ),
    ),
  );
}
