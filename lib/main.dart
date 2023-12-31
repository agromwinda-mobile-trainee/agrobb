import 'dart:ui';
import 'package:agrobeba/commons/home/authLogic/cubit/login_process_cubit.dart';
import 'package:agrobeba/customer-app/screens/widgets/destination/cubits/destination_cubit.dart';
import 'package:agrobeba/commons/home/welcomewidget.dart';
import 'package:agrobeba/driver-app/screens/cubits/driver_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'commons/home/loginscreen.dart';
// import 'commons/home/profil_Screen.dart';
import 'controller/auth_controller.dart';
import 'firebase_options.dart';

void main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path.toString());
  runApp(const MyApp());
  // FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    authController.decideRoute();
    final textTheme = Theme.of(context).textTheme;
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginProcessCubit>(
          create: (BuildContext context) => LoginProcessCubit(),
        ),
        BlocProvider<DestinationCubit>(
          create: (BuildContext context) => DestinationCubit(),
        ),
        BlocProvider<DriverCubit>(
          create: (BuildContext context) => DriverCubit(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Agrobeba',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(textTheme).copyWith(
            bodyMedium: const TextStyle(color: Colors.black),
            bodySmall: const TextStyle(color: Colors.black),
            bodyLarge: const TextStyle(color: Colors.black),
          ),
          colorScheme: const ColorScheme.light(
            background: Colors.white,
            primary: Color.fromRGBO(220, 80, 91, 1),
            secondary: Color.fromRGBO(246, 239, 101, 1),
          ),
        ),
        home: const Welcome(),
      ),
    );
  }
}
