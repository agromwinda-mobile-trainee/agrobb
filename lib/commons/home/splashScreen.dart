import 'package:agrobeba/commons/home/authLogic/cubit/login_process_cubit.dart';
import 'package:agrobeba/customer-app/screens/home.dart';
import 'package:agrobeba/commons/home/welcomewidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    BlocProvider.of<LoginProcessCubit>(context).checkUser();
    super.initState();
  }

  Widget build(BuildContext context) {
    return BlocBuilder<LoginProcessCubit, LoginProcessState>(
        builder: (context, state) {
      int? statusCode = state.usercontent!['code'];
      if (statusCode == 200) return const HomeScreen();
      if (statusCode == 404 || statusCode == 400 || statusCode == 500) {
        return const Welcome();
      }
      return SizedBox();
    });
  }
}
