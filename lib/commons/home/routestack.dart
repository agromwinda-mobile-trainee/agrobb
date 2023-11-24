import 'package:agrobeba/commons/home/authLogic/cubit/login_process_cubit.dart';
import 'package:agrobeba/customer-app/screens/home.dart';
import 'package:agrobeba/driver-app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteStack extends StatelessWidget {
  const RouteStack({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginProcessCubit, LoginProcessState>(
        builder: (context, state) {
      bool isDriver = state.usercontent!['isDriver'];

      return isDriver ? const HomeDriver() : const HomeCustomer();
    });
  }
}
