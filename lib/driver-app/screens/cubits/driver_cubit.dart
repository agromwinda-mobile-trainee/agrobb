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

  // final Position startPosition = await determinePosition();
  // print("current position got: ${Geolocator.getCurrentPosition()}");

}
