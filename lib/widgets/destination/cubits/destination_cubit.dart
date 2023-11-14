// ignore_for_file: avoid_print, depend_on_referenced_packages
import 'dart:async';
import 'dart:developer';
import 'package:agrobeba/commons/home/api_contents/functions/getfunctions.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
      "step": 1,
    }));
  }

  Future<void> sendRequest() async {
    try {
      // Active Loader
      emit(DestinationState(destination: {
        ...state.destination!,
        "loading": true,
      }));
      // Retrieve map data
      final List? destination =
          state.destination!['destinationValue']['coordinates'];
      final Position startPosition = await determinePosition();

      // Prepare map data to request like
      final Map endPoint = {
        "longitude": destination![0],
        "latitude": destination[1],
      };
      final Map startPoint = {
        "longitude": startPosition.longitude,
        "latitude": startPosition.latitude,
      };
      Map? currentService =
          await sendCourseRequest(endPoint: endPoint, startPoint: startPoint);

      // Save response if request is successful
      if (currentService != null) {
        emit(DestinationState(destination: {
          ...state.destination!,
          'currentService': currentService,
          'step': 2,
          'loading': false,
        }));
        return;
      }

      emit(DestinationState(destination: {
        ...state.destination!,
        "loading": false,
      }));
    } catch (e) {
      print("erreur affichage $e");
      emit(DestinationState(destination: {
        ...state.destination!,
        "loading": false,
      }));
    }
  }

  Future<void> findAvailableCar() async {
    try {
      emit(DestinationState(destination: {
        ...state.destination!,
        'loading': true,
      }));

      int requestID = state.destination!["currentService"]["id"];
      List? drivers = await findDrivers(requestID);

      emit(DestinationState(destination: {
        ...state.destination!,
        "loading": false,
        "drivers": drivers ?? [],
        "step": 3,
      }));
    } catch (e) {
      log("error on finding car: $e ");
      emit(DestinationState(destination: {
        ...state.destination!,
        'loading': false,
      }));
    }
  }
}
