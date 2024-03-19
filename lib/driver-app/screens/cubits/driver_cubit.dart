// ignore_for_file: avoid_print, depend_on_referenced_packages
import 'dart:async';
import 'dart:developer';

import 'package:agrobeba/commons/home/api_contents/functions/getfunctions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
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
    } catch (error) {
      log("error on permanent requests: $error");
    }
  }

  void onConfirmeCommande(context,
      {required Map commande, required String driverRef}) async {
    try {
      CollectionReference errands =
          FirebaseFirestore.instance.collection('errand');
      errands
          .doc(commande['id'])
          .update({'status': 'during', 'driver_ref': driverRef})
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

  Future<void> checkDriverAvailability({required String driverRef}) async {
    try {
      log("onCheckDriverAvailability: $driverRef");
      emit(DriverState(driver: {
        ...state.driver!,
        'checkDriverAvailability': true,
      }));

      FirebaseFirestore.instance
          .collection('errand')
          .where('driver_ref', isEqualTo: driverRef)
          .where('status', isEqualTo: 'during')
          .get()
          .then((snapshot) {
        final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
            snapshot.docs;
        if (docs.isNotEmpty) {
          final Map<String, dynamic> errand = {
            ...docs[0].data(),
            'id': docs[0].id
          };

          log("errand found: ${errand.toString()}");

          emit(DriverState(driver: {
            ...state.driver!,
            "acceptedCommande": errand,
            "checkDriverAvailability": false,
          }));
        }
      }).catchError((onError) {
        log("error on fetch driver's errand: ${onError.toString()}");

        emit(DriverState(driver: {
          ...state.driver!,
          'checkDriverAvailability': false,
        }));
      });
    } catch (error) {
      log("Error on checkDriverAvailability: ${error.toString()}");
      emit(DriverState(driver: {
        ...state.driver!,
        'checkDriverAvailability': false,
      }));
    }
  }
}
