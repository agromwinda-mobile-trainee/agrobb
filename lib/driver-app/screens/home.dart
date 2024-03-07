import 'dart:developer';

import 'package:agrobeba/commons/home/authLogic/cubit/login_process_cubit.dart';
import 'package:agrobeba/customer-app/screens/widgets/widget_build_Tile.dart';
import 'package:agrobeba/driver-app/screens/cubits/driver_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../commons/home/api_contents/functions/getfunctions.dart';
import '../../commons/home/drawer.dart';

class HomeDriver extends StatefulWidget {
  const HomeDriver({super.key});

  @override
  State<HomeDriver> createState() => _HomeDriverState();
}

class _HomeDriverState extends State<HomeDriver> {
  late LatLng source;
  Set<Marker> markers = <Marker>{};
  String? _mapStyle;
  final Stream<QuerySnapshot> _errandStream =
      FirebaseFirestore.instance.collection('errand').snapshots();

  @override
  void initState() {
    rootBundle.loadString('assets/map_style.txt').then((String) {
      _mapStyle = String;
    });

    // String token = BlocProvider.of<LoginProcessCubit>(context, listen: true)
    //     .state
    //     .usercontent!["token"];
    // String phoneNumber =
    //     BlocProvider.of<LoginProcessCubit>(context, listen: true)
    //         .state
    //         .usercontent!["Telephone"];
    initDriver();
    //  BlocProvider.of<DriverCubit>(context)
    //       .onSendPermanentRequests('token', 'phoneNumber');
    super.initState();
  }

  Future<void> initDriver() async {
    final String? token = await getToken();
    final String? phoneNumber = await getPhoneNumber();
    log("homeDriver${token!}");
    log(phoneNumber!);

    // ignore: use_build_context_synchronously
    BlocProvider.of<DriverCubit>(context)
        .onSendPermanentRequests(token, phoneNumber);
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
          // awaitForCommandes(context),
          commandesWidget(context),
        ],
      ),
    );
  }

  Widget commandesWidget(context) {
    return Positioned(
      bottom: 0,
      child: Container(
        height: 400,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: StreamBuilder<QuerySnapshot>(
            stream: _errandStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text(
                  'Something went wrong',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black,
                      ),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text(
                  "Loading",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black,
                      ),
                );
              }

              return SizedBox(
                height: 380,
                child: ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return ListTile(
                      title: Text(
                        data["startPoint"],
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      subtitle: Text(
                        data["endsPoint"],
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.black,
                            ),
                      ),
                    );
                  }).toList(),
                ),
              );
            }),
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
        List? commandes = state.driver!["drivers"] ?? [];

        if (state.driver!["acceptedCommande"] != null) {
          Column(
            children: [
              Text(
                "Vous avez accepté une course",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              BlocBuilder<DriverCubit, DriverState>(builder: (context, state) {
                return Text(
                  "Identifiant de la commande: ${state.driver!["acceptedCommande"]?["id"] ?? "--"}",
                  style: Theme.of(context).textTheme.bodyMedium,
                );
              }),
              BlocBuilder<DriverCubit, DriverState>(builder: (context, state) {
                return Text(
                  "Numero du téléphone du client: ${state.driver!["acceptedCommande"]?["customer"]["phoneNumber"] ?? "--"}",
                  style: Theme.of(context).textTheme.bodyMedium,
                );
              }),
            ],
          );
        }

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
                    title: Text("Course + ${commande["id"] ?? "DefaultID"}"),
                    onTap: () => BlocProvider.of<DriverCubit>(context)
                        .onConfirmeCommande(token: token, commande: commande),
                  ))
              .toList(),
        );
      }),
    ),
  );
}
