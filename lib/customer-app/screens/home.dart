import 'package:agrobeba/commons/home/authLogic/cubit/login_process_cubit.dart';
import 'package:agrobeba/customer-app/screens/widgets/destination/buildbottomsheet.dart';
import 'package:agrobeba/driver-app/screens/cubits/driver_cubit.dart';
import 'package:agrobeba/driver-app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../../commons/home/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late LatLng source;
  Set<Marker> markers = <Marker>{};

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
      drawer: const BuildDrawer(),
      body: BlocBuilder<LoginProcessCubit, LoginProcessState>(
          builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
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
              // buildProfileTile(),

              // const enterDestination(),
              // destinationInputField(context),
              // showSourceField ? enterEmplacement() : Container(),
              // currentLocationIcon(),

              // noficationIcon(),

              (state.usercontent!["role"] == "driver")
                  ? awaitForCommandes(context)
                  : const SizedBox.shrink(),

              (state.usercontent!["role"] == "customer")
                  ? iconMenu(context)
                  : const SizedBox.shrink(),

              (state.usercontent!["role"] == "customer")
                  ? const BuildBottomSheet()
                  : const SizedBox.shrink(),
            ],
          ),
        );
      }),
    );
  }
}

Widget iconMenu(context) {
  return Positioned(
    top: 60,
    left: 20,
    child: InkWell(
      onTap: () => Get.to(const BuildDrawer()),
      splashColor: Colors.white38,
      child: Ink(
        decoration: const BoxDecoration(
            color: Colors.transparent, shape: BoxShape.circle),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(.9),
              shape: BoxShape.circle),
          child: const Icon(
            Icons.menu_rounded,
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
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
