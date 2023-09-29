import 'package:agrobeba/commons/home/api_contents/functions/getfunctions.dart';
import 'package:agrobeba/commons/home/home.dart';
import 'package:agrobeba/commons/home/loginscreen.dart';
import 'package:agrobeba/utils/colors.dart';
import 'package:agrobeba/widgets/introwidget.dart';
import 'package:agrobeba/widgets/loginWidget.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

import '../../widgets/textWidget.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<dynamic, dynamic>?>(
        future: getToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map? user = snapshot.data;
            if (user == null) {
              return Scaffold(
                body: Column(
                  children: [
                    introWidget(),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textWidget(
                              text: '',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          textWidget(
                              text:
                                  '    Votre plus belle experience    commence maintenant',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          FittedBox(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 26,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Color.fromARGB(255, 14, 4, 4),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Continuez',
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
                                      color: Color.fromARGB(255, 231, 54, 54),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            return const HomeScreen();
          }

          return SizedBox();
        });
  }
}
