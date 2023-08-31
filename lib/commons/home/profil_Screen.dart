import 'dart:ffi';

import 'package:agrobeba/commons/home/home.dart';
import 'package:agrobeba/utils/colors.dart';
import 'package:agrobeba/widgets/introwidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:agrobeba/widgets/textFieldWidget.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/setterButton.dart';

class ProfileSreen extends StatefulWidget {
  const ProfileSreen({super.key});

  @override
  State<ProfileSreen> createState() => _ProfileSreenState();
}

class _ProfileSreenState extends State<ProfileSreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController homeController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  // ImagePicker _picker = ImagePicker();
  // late File selectedImage;
  // getImage(ImageSource source) async {
  //   final XFile? image = await _picker.pickImage(source: source);
  //   if (image != null) {
  //     selectedImage = File(image.path);
  //     setState(() {});
  //   }
  // }
  storeUserInfo() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).set({
      'name': nameController.text,
      'home_address': homeController.text,
      'telephone': numberController.text,
    }).then((value) {
      nameController.clear();
      homeController.clear();
      numberController.clear();
      setState(() {
        isLoading = false;
      });
      Get.to(() => HomeScreen());
    });
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Get.height * 0.4,
            child: Stack(children: [
              Container(
                width: double.infinity,
                height: 200,
                color: Appcolors.whiteColor,
                child: Container(
                    width: Get.width * 0.1,
                    height: Get.height * 0.05,
                    child: Center(
                      child: Text(
                        'Parametre compte',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    )),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {
                    // getImage(ImageSource.gallery);
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffD6D6D6),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ]),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 23),
            child: Column(children: [
              TextFieldWidget('Nom', Icons.person_outlined, nameController),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                  'adresse domicile', Icons.home_outlined, homeController),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget('Num tel', Icons.phone, numberController),
              const SizedBox(
                height: 10,
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    )
                  : subButton('soumettre', () {
                      setState(() {
                        isLoading = true;
                      });
                      storeUserInfo();
                    }),
            ]),
          )
        ],
      )),
    );
  }
}
