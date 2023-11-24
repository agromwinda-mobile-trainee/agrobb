import 'package:agrobeba/commons/home/authLogic/cubit/login_process_cubit.dart';
import 'package:agrobeba/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

enum SingingCharacter { customer, driver }

class BuildDrawer extends StatefulWidget {
  const BuildDrawer({super.key});

  @override
  State<BuildDrawer> createState() => _BuildDrawerState();
}

class _BuildDrawerState extends State<BuildDrawer> {
  buildDrawerItem(
      {required String title,
      required Function onPressed,
      Color color = Colors.black,
      double fontSize = 18,
      FontWeight fontWeight = FontWeight.w700,
      double height = 39,
      bool isVisible = false}) {
    return SizedBox(
      height: height,
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        // minVerticalPadding: 0,
        dense: true,
        onTap: () => onPressed(),
        title: Row(
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                  fontSize: fontSize, fontWeight: fontWeight, color: color),
            ),
            const SizedBox(
              width: 5,
            ),
            isVisible
                ? CircleAvatar(
                    backgroundColor: Appcolors.redColor,
                    radius: 15,
                    child: Text(
                      'taxi',
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                // Positioned(
                //     top: 25,
                //     left: 120,
                //     child: InkWell(
                //       onTap: () {
                //         Get.back();
                //       },
                //       child: Container(
                //         width: 45,
                //         height: 45,
                //         decoration: BoxDecoration(
                //             shape: BoxShape.circle, color: Colors.black),
                //         child: Icon(Icons.arrow_back, color: Colors.white),
                //       ),
                //     )),
                buildDrawerItem(
                    title: 'mon compte', onPressed: () => Get.to(() => null)),
                const SizedBox(
                  height: 4,
                ),
                const Divider(
                  indent: 8,
                  endIndent: 140.0,
                  height: 8,
                  thickness: 3,
                  color: Color.fromARGB(255, 92, 92, 92),
                ),
                buildDrawerItem(
                    title: 'Services', onPressed: () {}, isVisible: true),
                const SizedBox(
                  height: 4,
                ),
                const Divider(
                  color: Color.fromARGB(255, 112, 112, 112),
                ),
                buildDrawerItem(title: 'moyens de paiement', onPressed: () {}),
                const SizedBox(
                  height: 4,
                ),
                const Divider(
                  color: Color.fromARGB(255, 90, 90, 90),
                ),
                buildDrawerItem(title: 'Codes promo', onPressed: () {}),
                const SizedBox(
                  height: 4,
                ),
                const Divider(
                  color: Color.fromARGB(255, 100, 100, 100),
                ),
                buildDrawerItem(title: 'Parametres', onPressed: () {}),
                const SizedBox(
                  height: 4,
                ),
                const Divider(
                  color: Color.fromARGB(255, 109, 108, 108),
                ),
                buildDrawerItem(title: 'conditions ', onPressed: () {}),
                const Divider(
                  color: Color.fromARGB(255, 88, 88, 88),
                ),
                //buildDrawerItem(title: 'se deconnecter', onPressed: () {})
                buildDrawerItem(
                    title: 'Retour',
                    onPressed: () {
                      Get.back();
                    })
              ],
            ),
          ),
          Spacer(),
          Divider(),
          // switchMode(context),
          Divider(
            color: Colors.grey.withOpacity(.2),
            height: 2,
          ),
          ListTile(
            onTap: (() =>
                BlocProvider.of<LoginProcessCubit>(context).onLogout()),
            leading: const Icon(
              Icons.logout_rounded,
              size: 20,
              color: Colors.red,
            ),
            title: const Text(
              'Se déconnecter',
              style: TextStyle(color: Colors.black54),
            ),
          ),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //   child: Column(
          //     children: [
          //       const SizedBox(
          //         height: 20,
          //       ),
          //       buildDrawerItem(
          //           title: 'Nos rx sociaux',
          //           onPressed: () {},
          //           fontSize: 12,
          //           fontWeight: FontWeight.w500,
          //           color: Colors.black.withOpacity(0.15),
          //           height: 20),
          //       buildDrawerItem(
          //           title: 'conditions et politiques',
          //           onPressed: () {},
          //           fontSize: 12,
          //           fontWeight: FontWeight.w500,
          //           color: Colors.black.withOpacity(0.15),
          //           height: 20),
          //       buildDrawerItem(
          //         title: 'By Agromwinda',
          //         onPressed: () {},
          //         fontSize: 12,
          //         fontWeight: FontWeight.w500,
          //         color: Colors.black.withOpacity(0.15),
          //         height: 20,
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

Widget switchMode(context) {
  String mode = BlocProvider.of<LoginProcessCubit>(context, listen: true)
      .state
      .usercontent!["role"];
  return Column(
    children: <Widget>[
      ListTile(
        title: const Text('Passager'),
        leading: Radio<String>(
          value: "customer",
          groupValue: mode,
          onChanged: (String? value) {
            BlocProvider.of<LoginProcessCubit>(context)
                .onChangeusercontent(field: "isDriver", value: false);
          },
        ),
      ),
      ListTile(
        title: const Text('Conducteur'),
        leading: Radio<String>(
          value: "driver",
          groupValue: mode,
          onChanged: (String? value) {
            BlocProvider.of<LoginProcessCubit>(context)
                .onChangeusercontent(field: "isDriver", value: true);
          },
        ),
      ),
    ],
  );
}
