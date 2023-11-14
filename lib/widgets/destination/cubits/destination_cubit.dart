// ignore_for_file: avoid_print, depend_on_referenced_packages
import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:agrobeba/commons/home/api_contents/functions/getfunctions.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agrobeba/commons/home/api_contents/functions/autolocation.dart';
part 'destination_state.dart';

class DestinationCubit extends Cubit<DestinationState> {
  DestinationCubit() : super(DestinationState(destination: initialState()));

  Future<void> getPlaces({required String value}) async {
    // PickPlaces()
    List? places = await pickPlaces(value);

    emit(DestinationState(destination: {
      ...state.destination!,
      "places": places ?? [],
    }));
  }

  Future<void> saveDestinationValue({required Map value}) async {
    // PickPlaces()

    emit(DestinationState(destination: {
      ...state.destination!,
      "destinationValue": value,
    }));
  }

  Future<void> sendRequest() async {
    try {
      final List? destination =
          state.destination!['destinationValue']['coordinates'];
      final Position? startPosition = await determinePosition();
      print("$destination + $startPosition");

      // Create Data To Send
      final Map endPoint = {
        "longitude": destination![0],
        "latitude": destination[1],
      };
      final Map startPoint = {
        "longitude": startPosition!.longitude,
        "latitude": startPosition.latitude,
      };
      Map? currentService =
          await sendCourseRequest(endPoint: endPoint, startPoint: startPoint);

      if (currentService != null) {
        emit(DestinationState(destination: {
          ...state.destination!,
          'currentService': currentService,
        }));
      }
    } catch (e) {
      print("erreur affichage $e");
    }
  }
}
