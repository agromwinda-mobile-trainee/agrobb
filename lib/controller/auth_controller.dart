import 'dart:developer';
import 'package:agrobeba/customer-app/screens/home.dart';
import 'package:agrobeba/commons/home/profil_Screen.dart';
import 'package:agrobeba/driver-app/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  String userUid = '';
  var verId = '';
  int? resendTokenId;
  bool phoneAuthCheck = false;
  dynamic credentials;

  phoneAuth(String phone) async {
    try {
      credentials = null;
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phone,
          timeout: const Duration(seconds: 60),
          verificationCompleted: (PhoneAuthCredential credential) async {
            log('completed');
            credentials = credential;
            await FirebaseAuth.instance.signInWithCredential(credential);
          },
          forceResendingToken: resendTokenId,
          verificationFailed: (FirebaseAuthException e) {
            log('failed');
            if (e.code == 'invalide-phone-number') {
              debugPrint('numero de telephone non valide');
            }
          },
          codeSent: (String verificationId, int? resendToken) async {
            log('code sent');
            verId = verificationId;
            resendTokenId = resendToken;
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
    } catch (e) {
      log('Error occured  $e');
    }
  }

  verifyOtp(String otpNumber) async {
    try {
      log('called');
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verId, smsCode: otpNumber);
      print('loggedId');
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      print("Error on otp verify: $error");
    }
  }

  decideRoute() {
    //step 1: check user login
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      //step 1.1 : check wether user profil exist
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((value) {
        if (value.exists) {
          Get.to(() => const HomeCustomer());
        } else {
          Get.to(() => const ProfileSreen());
        }
      });
    }

    //stp2 : check profil completed
  }
}
