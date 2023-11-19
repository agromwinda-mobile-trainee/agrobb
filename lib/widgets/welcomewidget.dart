import 'package:agrobeba/commons/home/loginscreen.dart';
import 'package:agrobeba/widgets/loginWidget.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../commons/home/authLogic/cubit/login_process_cubit.dart';
import '../commons/home/home.dart';
import '../utils/colors.dart';

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
      if (statusCode == 200) return const HomeScreen();
      if (statusCode == 404 || statusCode == 400 || statusCode == 500) {
        return const Welcomeboard();
      }
      return const SizedBox();
    });
  }
}

// textmoov

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
      duration: Duration(seconds: 2),
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, -1.0),
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
        backgroundColor: Color.fromARGB(255, 253, 250, 250),
        body: Container(
          padding: EdgeInsets.all(20),
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
                      Get.to(LoginScreen());
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
