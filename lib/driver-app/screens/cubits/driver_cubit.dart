// ignore_for_file: avoid_print, depend_on_referenced_packages
import 'dart:async';
import 'dart:developer';
import 'package:agrobeba/commons/home/api_contents/functions/getfunctions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agrobeba/commons/home/api_contents/functions/autolocation.dart';
import 'package:get/get.dart';
part 'driver_state.dart';

class DriverCubit extends Cubit<DriverState> {
  DriverCubit() : super(DriverState(driver: initialState()));

  void onSendPermanentRequests(String token, String phoneNumber) async {
    print("Request request");
    try {
      List? commandes = [];
      Position? startPosition;

      if (state.driver!["acceptedCommande"] == null) {
        do {
          startPosition = await Geolocator.getCurrentPosition();
          String message =
              'agrobeba send -L ${startPosition.longitude} -l ${startPosition.latitude} -v "3.83" -f "0" ';

          await sendCurrentPosition(
              data: {"message": message, "phoneNumber": phoneNumber});
          commandes = await getCommandes(token: token);

          print("current position got: $startPosition");
          print("current commandes: $commandes");

          emit(DriverState(driver: {
            ...state.driver!,
            "drivers": commandes ?? [],
            "currentPosition": startPosition
          }));

          print("no cars found");
          await Future.delayed(const Duration(seconds: 10));
        } while (true);
      }

      // emit(DriverState(driver: {
      //   ...state.driver!,
      //   'currentPosition': startPosition,
      //   'commandes': commandes ?? [],
      // }));
    } catch (error) {
      log("error on permanent requests: $error");
    }
  }

  void onConfirmeCommande(context,
      {required Map commande}) async {
    try {
      CollectionReference errands =
          FirebaseFirestore.instance.collection('errand');
      errands
          .doc(commande['id'])
          .update({'status': 'encours'})
          .then((value) => log("Errand Updated"))
          .catchError((error) => log("Failed to update errand: $error"));

      emit(DriverState(driver: {
        ...state.driver!,
        "acceptedCommande": commande,
      }));
      Get.back();

      // int? resultCode = await confirmCommande(id: commande["id"], token: token);
      // emit(DriverState(driver: {
      //   ...state.driver!,
      //   "acceptedCommande":
      //       (resultCode == 200 || resultCode == 201) ? commande : null,
      // }));
    } catch (error) {
      log("error onConfirmCommande: ${error.toString()}");
    }
  }
}
