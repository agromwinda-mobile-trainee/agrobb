import 'package:agrobeba/commons/home/authLogic/cubit/login_process_cubit.dart';
import 'package:agrobeba/customer-app/screens/home.dart';
import 'package:agrobeba/driver-app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'api_contents/functions/autolocation.dart';

class RouteStack extends StatefulWidget {
  const RouteStack({super.key});

  @override
  State<RouteStack> createState() => _RouteStackState();
}

class _RouteStackState extends State<RouteStack> {
  @override
  void initState() {
    super.initState();
    determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginProcessCubit, LoginProcessState>(
        builder: (context, state) {
      // bool isDriver = state.usercontent!['isDriver'];

      return const HomeDriver();
    });
  }
}
