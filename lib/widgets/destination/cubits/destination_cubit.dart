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
          'error': '',
        }));
        return;
      }

      emit(DestinationState(destination: {
        ...state.destination!,
        "loading": false,
        "error": "Requete echouée, veullez réessayer !"
      }));
    } catch (e) {
      print("erreur affichage $e");
      emit(DestinationState(destination: {
        ...state.destination!,
        "loading": false,
        "error": "Une erreur est survenue  !"
      }));
    }
  }

  Future<void> findAvailableCar() async {
    try {
      emit(DestinationState(destination: {
        ...state.destination!,
        'loading': true,
        'error': '',
      }));

      int requestID = state.destination!["currentService"]["id"];
      List? drivers = [];

      do {
        drivers = await findDrivers(requestID);
        emit(DestinationState(destination: {
          ...state.destination!,
          "drivers": drivers ?? [],
          "step": 3,
          'error': '',
        }));

        print("no cars found");
        await Future.delayed(const Duration(minutes: 5));
      } while (drivers!.isEmpty);

      print("some cars found");
      emit(DestinationState(destination: {
        ...state.destination!,
        "loading": false,
        "drivers": drivers,
        "step": 3,
        'error': '',
      }));
    } catch (e) {
      log("error on finding car: $e ");
      emit(DestinationState(destination: {
        ...state.destination!,
        'loading': false,
        "error": "Une erreur est survenue  !"
      }));
    }
  }

  Future<void> onChooseDriver(int driverID) async {
    try {
      emit(DestinationState(destination: {
        ...state.destination!,
        "loading": true,
        'error': '',
      }));
      Map? driver = await chooseDriver(driverID);
      if (driver != null) {
        emit(DestinationState(destination: {
          ...state.destination!,
          "driver": driver,
          "loading": false,
          "step": 4,
          "error": '',
        }));
        return;
      }

      emit(DestinationState(destination: {
        ...state.destination!,
        "loading": false,
        "error": "Requete échouée, veuillez réessayer !",
      }));
    } catch (e) {
      log('error on choosing driver: $e');
      emit(DestinationState(destination: {
        ...state.destination!,
        "error": "Une erreur est survenue  !",
        "loading": false,
      }));
    }
  }
}
