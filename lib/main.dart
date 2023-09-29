import 'dart:ui';

import 'package:agrobeba/widgets/welcomewidget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'commons/home/loginscreen.dart';
import 'commons/home/profil_Screen.dart';
import 'controller/auth_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path.toString());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    authController.decideRoute();
    final TextTheme = Theme.of(context).textTheme;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agrobeba',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(TextTheme),
      ),
      home: const Welcome(),
    );
  }
}
