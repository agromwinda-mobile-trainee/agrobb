// ignore_for_file: avoid_print, depend_on_referenced_packages
import 'dart:async';
import 'dart:developer';
import 'package:agrobeba/commons/home/api_contents/functions/getfunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
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

    print("place picked: $places");

    emit(DestinationState(destination: {
      ...state.destination!,
      "places": places,
      "gettingPlaces": false,
    }));
  }

  Future<void> saveEmplacementValue({required Map value}) async {
    // final Position startPosition = await determinePosition();
    // print("current position got: $startPosition");
    print("save emplacement: ${value.toString()}");

    String emplacementField = state.destination!["emplacementField"];
    Map emplacementForm = {
      ...state.destination!["emplacementForm"],
      emplacementField: value["name"],
    };

    print("emplacementForm: ${emplacementForm.toString()}");
    print("emplacementField: ${emplacementField.toString()}");
    emit(DestinationState(destination: {
      ...state.destination!,
      emplacementField: value,
      "emplacementForm": emplacementForm,
      'error': '',
    }));
  }

  Future<void> onChangeField({required String field, required value}) async {
    emit(DestinationState(destination: {
      ...state.destination!,
      field: value,
    }));
  }

  Future<void> onCancelCommande() async {
    try {
      emit(DestinationState(destination: {
        ...state.destination!,
        'step': 0,
        'loading': false,
        'selectedServiceID': 0,
        'destinationValue': null,
        'startPoint': null,
        'emplacementField': '',
        'sendRequest': {},
        'currentService': {},
      }));
      Get.back();
    } catch (error) {
      log("cancle failled: $error");
      emit(DestinationState(destination: {
        ...state.destination!,
        'error': "Annulation echouée !",
      }));
      return;
    }
  }

  Future<void> sendRequest({required String token}) async {
    print("send request. Token: $token");
    try {
      emit(DestinationState(destination: {
        ...state.destination!,
        "loading": true,
      }));

      // Retrieve map data
      final Map destinationCoordinates = {
        "longitude": state.destination!['destinationValue']['coordinates'][0],
        "latitude": state.destination!['destinationValue']['coordinates'][1],
      };

      final Map startPointCoordinates = {
        "longitude": state.destination!['startPoint']['coordinates'][0],
        "latitude": state.destination!['startPoint']['coordinates'][1],
      };

      Map? currentService = await sendCourseRequest(
          token: token,
          endPoint: destinationCoordinates,
          startPoint: startPointCoordinates);

      if (currentService != null) {
        emit(DestinationState(destination: {
          ...state.destination!,
          'currentService': currentService,
          'step': 1,
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

  Future<void> waittingCarConfirmation() async {
    print("waitting for card confirmation");
    try {
      emit(DestinationState(destination: {
        ...state.destination!,
        'loading': true,
        'error': '',
      }));

      int requestID = state.destination!["currentService"]["id"];
      Map? drivers;

      if (state.destination!["driver"] == null) {
        print("search driver confirmation");
        do {
          drivers = await findDrivers(requestID);

          if (drivers!["confirm"]) {
            print("***driver found: ${drivers['providerAccept']}");
            emit(DestinationState(destination: {
              ...state.destination!,
              "loading": false,
              "driver": drivers,
              "step": 3,
              'error': '',
            }));
          }

          print(
              "***no driver found yet. Confirmation Status: ${drivers['confirm']}");
          await Future.delayed(const Duration(seconds: 5));
        } while (state.destination!["driver"] == null);
      }

      // print("***driver found: $drivers");
      // emit(DestinationState(destination: {
      //   ...state.destination!,
      //   "loading": false,
      //   "driver": drivers,
      //   "step": 3,
      //   'error': '',
      // }));
    } catch (e) {
      log("error on finding car: $e ");
      emit(DestinationState(destination: {
        ...state.destination!,
        'loading': false,
        "error": "Une erreur est survenue  !"
      }));
    }
  }

  Future<void> onChooseDriver(int serviceID) async {
    try {
      emit(DestinationState(destination: {
        ...state.destination!,
        "loading": true,
        'error': '',
      }));

      Map? driver = await chooseDriver(serviceID);

      if (driver != null) {
        emit(DestinationState(destination: {
          ...state.destination!,
          "driver": driver,
          "loading": false,
          "step": 2,
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
