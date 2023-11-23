import 'package:agrobeba/commons/home/authLogic/cubit/login_process_cubit.dart';
import 'package:agrobeba/driver-app/screens/cubits/driver_cubit.dart';
import 'package:agrobeba/driver-app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AwaitForCommands extends StatefulWidget {
  const AwaitForCommands({super.key});

  @override
  State<AwaitForCommands> createState() => _AwaitForCommandsState();
}

class _AwaitForCommandsState extends State<AwaitForCommands> {
  @override
  void initState() {
    super.initState();
    String token = BlocProvider.of<LoginProcessCubit>(context, listen: true)
        .state
        .usercontent!["token"];
    String phoneNumber =
        BlocProvider.of<LoginProcessCubit>(context, listen: true)
            .state
            .usercontent!["Telephone"];

    BlocProvider.of<DriverCubit>(context)
        .onSendPermanentRequests(token, phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return awaitForCommandes(context);
  }
}
