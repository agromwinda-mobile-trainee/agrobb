import 'package:agrobeba/commons/home/authLogic/cubit/login_process_cubit.dart';
import 'package:agrobeba/customer-app/screens/widgets/widget_build_Tile.dart';
import 'package:agrobeba/driver-app/screens/cubits/driver_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    String token = BlocProvider.of<LoginProcessCubit>(context, listen: true)
        .state
        .usercontent!["token"];
    String phoneNumber =
        BlocProvider.of<LoginProcessCubit>(context, listen: true)
            .state
            .usercontent!["Telephone"];

    BlocProvider.of<DriverCubit>(context)
        .onSendPermanentRequests(token, phoneNumber);
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
  String token =
      BlocProvider.of<LoginProcessCubit>(context).state.usercontent!["token"];
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
      child: BlocBuilder<DriverCubit, DriverState>(builder: (context, state) {
        List? commandes = state.driver!["commandes"];

        if (commandes!.isEmpty) {
          return const Center(
            child: Text(
              "En attente d'une course...",
              style: TextStyle(color: Colors.black),
            ),
          );
        }

        return Column(
          children: commandes
              .map((commande) => ListTile(
                    title: Text("Course + ${commande["id"]}"),
                    onTap: () => BlocProvider.of<DriverCubit>(context)
                        .onConfirmeCommande(token: token, commande: commande),
                  ))
              .toList(),
        );
      }),
    ),
  );
}
