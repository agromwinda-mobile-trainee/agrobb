import 'package:agrobeba/commons/home/authLogic/cubit/login_process_cubit.dart';
import 'package:agrobeba/commons/home/loginscreen.dart';
import 'package:agrobeba/customer-app/screens/home.dart';
import 'package:agrobeba/driver-app/screens/home.dart';
import 'package:agrobeba/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  initState() {
    BlocProvider.of<LoginProcessCubit>(context).checkUser();
    super.initState();
  }

  Widget build(BuildContext context) {
    return BlocBuilder<LoginProcessCubit, LoginProcessState>(
        builder: (context, state) {
      int? statusCode = state.usercontent!['code'];
      String? role = state.usercontent!['role'];
      if (statusCode == 200 && role == "customer") return const HomeScreen();
      if (statusCode == 200 && role == "driver") return const HomeDriver();
      if (statusCode == 404 || statusCode == 400 || statusCode == 500) {
        return const Welcomeboard();
      }
      return const SizedBox();
    });
  }
}

class MovingText extends StatefulWidget {
  @override
  _MovingTextState createState() => _MovingTextState();
}

class _MovingTextState extends State<MovingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: const Center(
        child: Text(
          "Offrez-vous la meilleure experience dans un temps record",
          style: TextStyle(fontSize: 45, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class Welcomeboard extends StatefulWidget {
  const Welcomeboard({super.key});

  @override
  State<Welcomeboard> createState() => _WelcomeboardState();
}

class _WelcomeboardState extends State<Welcomeboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 253, 250, 250),
        body: Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/images/logo.jpg",
                    height: 45, fit: BoxFit.cover),
                MovingText(),
                const SizedBox(
                  height: 50,
                ),
                FittedBox(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(const LoginScreen());
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 26,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Appcolors.blackColor,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Continuer',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: Appcolors.whiteColor,
                                ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.arrow_forward,
                            color: Appcolors.redColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ]),
        ));
  }
}
