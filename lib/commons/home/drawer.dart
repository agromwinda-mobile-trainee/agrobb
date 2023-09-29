import 'package:agrobeba/commons/home/home.dart';
import 'package:agrobeba/commons/home/profil_Screen.dart';
import 'package:agrobeba/utils/colors.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
      double fontSize = 12,
      FontWeight fontWeight = FontWeight.w700,
      double height = 39,
      bool isVisible = false}) {
    return SizedBox(
      height: height,
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
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
                buildDrawerItem(
                    title: 'Services', onPressed: () {}, isVisible: true),
                buildDrawerItem(title: 'moyens de paiement', onPressed: () {}),
                buildDrawerItem(title: 'Codes promo', onPressed: () {}),
                buildDrawerItem(title: 'Parametres', onPressed: () {}),
                buildDrawerItem(title: 'conditions ', onPressed: () {}),
                buildDrawerItem(title: 'se deconnecter', onPressed: () {}),
                buildDrawerItem(
                    title: 'Retour',
                    onPressed: () {
                      Get.to(HomeScreen());
                    })
              ],
            ),
          ),
          Spacer(),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                buildDrawerItem(
                    title: 'Nos rx sociaux',
                    onPressed: () {},
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.15),
                    height: 20),
                buildDrawerItem(
                    title: 'conditions et politiques',
                    onPressed: () {},
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.15),
                    height: 20),
                buildDrawerItem(
                  title: 'By Agromwinda',
                  onPressed: () {},
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.15),
                  height: 20,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
