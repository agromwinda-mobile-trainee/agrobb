// ignore_for_file: avoid_print, depend_on_referenced_packages
import 'dart:async';
import 'dart:developer';
import 'package:agrobeba/commons/home/api_contents/functions/getfunctions.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'destination_state.dart';

class DestinationCubit extends Cubit<DestinationState> {
  DestinationCubit() : super(DestinationState(destination: initialState()));

  Future<void> getPlaces({required String value}) async {
    emit(DestinationState(destination: {
      ...state.destination!,
      "gettingPlaces": true,
    }));
    // PickPlaces()
    List? places = await pickPlaces(value);

    emit(DestinationState(destination: {
      ...state.destination!,
      "places": places ?? [],
      "gettingPlaces": false,
    }));
  }

  Future<void> saveEmplacementValue({required Map value}) async {
    // final Position startPosition = await determinePosition();
    // print("current position got: $startPosition");

    String emplacementField = state.destination!["emplacementField"];

    emit(DestinationState(destination: {
      ...state.destination!,
      emplacementField: value,
      // "startPoint": startPosition,
      "step": 1,
      'error': '',
    }));
  }

  Future<void> onChangeField({required String field, required value}) async {
    emit(DestinationState(destination: {
      ...state.destination!,
      field: value,
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
      final Position? currentPosition = state.destination!["startPoint"];

      // final Position startPosition = await determinePosition();
      // print("current position got: ${Geolocator.getCurrentPosition()}");

      // Prepare map data to request like
      final Map endPoint = {
        "longitude": destination![0],
        "latitude": destination[1],
      };
      final Map startPoint = {
        "longitude": currentPosition!.longitude,
        "latitude": currentPosition.latitude,
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
        await Future.delayed(const Duration(seconds: 10));
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
