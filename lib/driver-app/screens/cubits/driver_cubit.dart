// ignore_for_file: avoid_print, depend_on_referenced_packages
import 'dart:async';
import 'dart:developer';
import 'package:agrobeba/commons/home/api_contents/functions/getfunctions.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agrobeba/commons/home/api_contents/functions/autolocation.dart';
part 'driver_state.dart';

class DriverCubit extends Cubit<DriverState> {
  DriverCubit() : super(DriverState(driver: initialState()));

  void onSendPermanentRequests(String token, String phoneNumber) async {
    print("*** Send permanent requests: $phoneNumber");
    try {
      List? commandes = [];
      Position? startPosition;

      if (state.driver!["acceptedCommande"] == null) {
        do {
          // startPosition = await Geolocator.getCurrentPosition();
          startPosition = await determinePosition();
          String message =
              "agrobeba send -L \"${startPosition.longitude.toString()}\" -l \"${startPosition.latitude.toString()}\" -v \"3.83\" -f \"0\" ";

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

          // print("no commandes found");
          await Future.delayed(const Duration(seconds: 15));
        } while (state.driver!["acceptedCommande"] == null);
      }

      // emit(DriverState(driver: {
      //   ...state.driver!,
      //   'currentPosition': startPosition,
      //   'commandes': commandes ?? [],
      // }));
    } catch (error) {
      print("error on permanent requests: $error");
    }
  }

  void onConfirmeCommande(
      {required String token, required Map commande}) async {
    print("Confirm commande: ${commande['id'].toString()}");
    try {
      int? resultCode = await confirmCommande(id: commande["id"], token: token);

      if (resultCode == 200 || resultCode == 201) {
        emit(DriverState(driver: {
          ...state.driver!,
          "acceptedCommande": commande,
        }));
      }
    } catch (error) {
      print(error.toString());
    }
  }

  void onChangeField({required String field, required String value}) {
    emit(DriverState(driver: {
      ...state.driver!,
      field: value,
    }));
  }

  void onShowCommandeDetails(
      {required bool showDetailsCommande, required String commandeID}) {
    print("show commande: $commandeID - $showDetailsCommande");
    emit(DriverState(driver: {
      ...state.driver!,
      'showDetailsCommande': showDetailsCommande,
      'commandeID': commandeID,
    }));
  }
}
