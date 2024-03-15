import 'dart:developer';

import 'package:agrobeba/commons/home/authLogic/cubit/login_process_cubit.dart';
import 'package:agrobeba/customer-app/screens/widgets/widget_build_Tile.dart';
import 'package:agrobeba/driver-app/screens/cubits/driver_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:unicons/unicons.dart';

import '../../commons/home/api_contents/functions/getfunctions.dart';
import '../../commons/home/drawer.dart';
import '../../customer-app/screens/widgets/custom_button.dart';

class HomeDriver extends StatefulWidget {
  const HomeDriver({super.key});

  @override
  State<HomeDriver> createState() => _HomeDriverState();
}

class _HomeDriverState extends State<HomeDriver> {
  late LatLng source;
  Set<Marker> markers = <Marker>{};
  String? _mapStyle;
  final Stream<QuerySnapshot> _errandStream = FirebaseFirestore.instance
      .collection('errand')
      // .orderBy("createdAt", descending: true)
      .where("status", isEqualTo: "encours")
      .snapshots();

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
      body: SafeArea(
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
            buildProfileTile(),
            // awaitForCommandes(context),
            commandesWidget(context),
          ],
        ),
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
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
            stream: _errandStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Column(
                  children: [
                    Text(
                      'Something went wrong',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.black,
                          ),
                    ),
                    Text(
                      snapshot.error.toString(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ],
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

              return Container(
                height: 380,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return InkWell(
                      onTap: () {
                        Get.bottomSheet(
                          bottomsheet(context, data: data),
                          elevation: 1,
                          isDismissible: true,
                          enterBottomSheetDuration:
                              const Duration(milliseconds: 300),
                          exitBottomSheetDuration:
                              const Duration(milliseconds: 300),
                        );
                      },
                      child: Ink(
                        color: Colors.transparent,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade100.withOpacity(.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: Row(
                              children: [
                                Icon(
                                  UniconsLine.map_pin_alt,
                                  size: 16,
                                  color: Colors.grey.shade600,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  data["startPoint"],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Colors.black,
                                      ),
                                ),
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Icon(
                                  UniconsLine.location_arrow,
                                  size: 16,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  data["endsPoint"],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Colors.black,
                                      ),
                                ),
                              ],
                            ),
                          ),
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

Widget bottomsheet(context, {required Map data}) {
  return Container(
    padding: const EdgeInsets.all(20),
    height: 260,
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.secondary,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    child: Column(children: [
      ListTile(
        title: Row(
          children: [
            Icon(
              UniconsLine.map_pin_alt,
              size: 16,
              color: Colors.grey.shade600,
            ),
            const SizedBox(width: 10),
            Text(
              data["startPoint"],
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black,
                  ),
            ),
          ],
        ),
        subtitle: Row(
          children: [
            Icon(
              UniconsLine.location_arrow,
              size: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 10),
            Text(
              data["endsPoint"],
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black,
                  ),
            ),
          ],
        ),
      ),
      Divider(
        height: 4,
        color: Colors.white.withOpacity(.85),
      ),
      ListTile(
        title: Row(
          children: [
            Icon(
              UniconsLine.location_arrow,
              size: 16,
              color: Colors.grey.shade600,
            ),
            const SizedBox(width: 10),
            Text(
              data["distance"],
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black,
                  ),
            ),
          ],
        ),
        subtitle: Row(
          children: [
            Icon(
              UniconsLine.bill,
              size: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 10),
            Text(
              data["price"] + " Fc",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black,
                  ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
      customButton(
        context,
        text: "Prendre la course",
        onTap: () {},
        bkgColor: Theme.of(context).colorScheme.primary,
        textColor: Colors.white,
      ),
    ]),
  );
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
