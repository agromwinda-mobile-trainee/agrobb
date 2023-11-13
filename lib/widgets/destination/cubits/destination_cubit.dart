// ignore_for_file: avoid_print, depend_on_referenced_packages
import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:agrobeba/commons/home/api_contents/functions/getfunctions.dart';
import 'package:flutter/material.dart';
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
      var destination = state.destination!['destinationValue']['coordinates'];
      var startPosition = await determinePosition();
      print("$destination + $startPosition");
    } catch (e) {
      print("erreur affichage $e");
    }
  }
}
