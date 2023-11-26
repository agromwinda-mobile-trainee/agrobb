import 'dart:ffi';

import 'package:agrobeba/commons/home/authLogic/cubit/login_process_cubit.dart';
import 'package:agrobeba/commons/home/widgets/widgets.dart';
import 'package:agrobeba/customer-app/screens/widgets/custom_button.dart';
import 'package:agrobeba/customer-app/screens/widgets/widget_build_Tile.dart';
import 'package:agrobeba/driver-app/screens/cubits/driver_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../commons/home/api_contents/functions/getfunctions.dart';
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
    print("homeDriver" + token!);
    print(phoneNumber!);

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
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      // height: MediaQuery.of(context).size.height - 250,
      height: 400,
      width: MediaQuery.of(context).size.width,
      decoration: bottomSheetDecoration(context),
      child: BlocBuilder<DriverCubit, DriverState>(
        builder: (context, state) {
          List? commandes = state.driver!["drivers"] ?? [];

          if (state.driver!["acceptedCommande"] != null) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Vous avez accepté une course",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 18,
                        ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<DriverCubit, DriverState>(
                      builder: (context, state) {
                    return ListTile(
                      title: Text(
                        "${state.driver!["acceptedCommande"]["startPoint"]['longitude']} * ${state.driver!["acceptedCommande"]["startPoint"]['latitude']}",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      subtitle: Text(
                        "${state.driver!["acceptedCommande"]["endPoint"]['longitude']} * ${state.driver!["acceptedCommande"]["endPoint"]['latitude']}",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 16,
                            ),
                      ),
                      trailing: distance(
                          context,
                          state.driver!["acceptedCommande"]["totalAmount"]
                              .toString()),
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                    );
                  }),
                  BlocBuilder<DriverCubit, DriverState>(
                      builder: (context, state) {
                    return ListTile(
                      title: Text(
                        "Client",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      subtitle: Text(
                        "${state.driver!["acceptedCommande"]["customer"]["phoneNumber"]}",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 16,
                            ),
                      ),
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                    );
                  }),
                ],
              ),
            );
          }

          if (commandes!.isEmpty) {
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    waittingAnimationWidget(context),
                    const SizedBox(height: 20),
                    const Text(
                      "En attente d'une course...",
                      style: TextStyle(color: Colors.black87),
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            );
          }

          return BlocBuilder<DriverCubit, DriverState>(
              builder: (context, state) {
            bool showDetailsCommande = state.driver!["showDetailsCommande"];
            String commandeID = state.driver!["commandeID"];

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Courses disponibles (${commandes.length})",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: commandes
                        .map(
                          (commande) => Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  child: ZoomTapAnimation(
                                    child: ListTile(
                                      title: Text(
                                        "${commande["startPoint"]['longitude']} * ${commande["startPoint"]['latitude']}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontSize: 12,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      subtitle: Text(
                                        "${commande["endPoint"]['longitude']} * ${commande["endPoint"]['latitude']}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                      trailing: distance(context,
                                          commande["totalAmount"].toString()),
                                      dense: true,
                                      contentPadding: EdgeInsets.zero,
                                      onTap: () =>
                                          BlocProvider.of<DriverCubit>(context)
                                              .onShowCommandeDetails(
                                                  showDetailsCommande:
                                                      !showDetailsCommande,
                                                  commandeID: commande["id"]
                                                      .toString()),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                if (showDetailsCommande &&
                                    commandeID == commande["id"].toString())
                                  customButton(context,
                                      text: "Accepter la course",
                                      onTap: () =>
                                          BlocProvider.of<DriverCubit>(context)
                                              .onConfirmeCommande(
                                                  token: token,
                                                  commande: commande))
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            );
          });
        },
      ),
    ),
  );
}

Widget distance(context, String value) {
  return Container(
    width: 95,
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    decoration: BoxDecoration(
      color: Colors.grey.shade300,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Row(children: [
      const Icon(
        IconlyBroken.discovery,
        size: 12,
        color: Colors.black87,
      ),
      const SizedBox(width: 22),
      Text(
        "$value km",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
      )
    ]),
  );
}
