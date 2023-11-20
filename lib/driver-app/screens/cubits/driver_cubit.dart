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
    try {
      List? commandes = [];
      Position? startPosition;

      if (state.driver!["acceptedCommande"] != null) {
        do {
          startPosition = await Geolocator.getCurrentPosition();
          String message =
              'agrobeba send -L ${startPosition.longitude} -l ${startPosition.latitude} -v "3.83" -f "0" ';

          await sendCurrentPosition(
              data: {"message": message, "phoneNumber": phoneNumber});
          commandes = await getCommandes(token: token);

          log("current position got: $startPosition");
          log("current commandes: $commandes");

          emit(DriverState(driver: {
            ...state.driver!,
            "drivers": commandes ?? [],
            "currentPosition": startPosition
          }));

          print("no cars found");
          await Future.delayed(const Duration(minutes: 5));
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
}
