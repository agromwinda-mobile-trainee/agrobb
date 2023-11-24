// import 'package:agrobeba/commons/home/drawer.dart';
// import 'package:agrobeba/customer-app/screens/widgets/destination/enterdestination_widget.dart';
// import 'package:agrobeba/customer-app/screens/widgets/enterEmplacement.dart';
// import 'package:agrobeba/customer-app/screens/widgets/notificationicon.dart';
// import 'package:agrobeba/customer-app/screens/widgets/widget_build_Tile.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter/services.dart' show rootBundle;
// //import '../../widgets/buildbottomsheet.dart';
// import '../../widgets/currentlocationicon.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   late LatLng source;
//   Position? currentPosition;
//   Set<Marker> markers = Set<Marker>();

//   String? _mapStyle;

//   @override
//   void initState() {
//     super.initState();
//     _determinePosition();
//     rootBundle.loadString('assets/map_style.txt').then((String) {
//       _mapStyle = String;
//     });
//   }

//   final CameraPosition _kGooglePlex = const CameraPosition(
//     target: LatLng(-4.325, 15.322222),
//     //target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );

//   GoogleMapController? myMapController;
//   _determinePosition() async {
//     Position position = await Geolocator.getCurrentPosition();
//     setState(() {
//       currentPosition = position;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: const BuildDrawer(),
//       body: Stack(
//         children: [
//           GoogleMap(
//             markers: markers,
//             // {
//             //   Marker(
//             //     markerId: MarkerId("votre position"),
//             //     position: LatLng(
//             //         currentPosition!.latitude, currentPosition!.longitude),
//             //   ),
//             // },
//             //  markers: markers,
//             zoomControlsEnabled: false,
//             // mapType: MapType.terrain,
//             onMapCreated: (GoogleMapController controller) {
//               myMapController = controller;
//               myMapController!.setMapStyle(_mapStyle);
//             },
//             initialCameraPosition: _kGooglePlex,
//           ),
//           buildProfileTile(),
//           const enterDestination(),
//           // destinationInputField(context),
//           showSourceField ? enterEmplacement() : Container(),
//           currentLocationIcon(context),
//           noficationIcon(),
//           //buildBottomSheet(),
//         ],
//       ),
//     );
//   }
// }

// List<Map> places = [
//   {
//     "id": "jdkskdf",
//     "name": "ngaliema",
//   },
//   {
//     "id": "jdkskdf",
//     "name": "ngaliema",
//   },
//   {
//     "id": "jdkskdf",
//     "name": "ngaliema",
//   },
//   {
//     "id": "jdkskdf",
//     "name": "ngaliema",
//   },
// ];
