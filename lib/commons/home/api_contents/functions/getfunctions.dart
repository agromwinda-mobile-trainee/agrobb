import 'dart:convert';
import 'dart:ffi';

import 'package:agrobeba/commons/home/home.dart';
import 'package:agrobeba/commons/home/profil_Screen.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../../otpscreen.dart';

sendCode(String phoneNumber) async {
  // print(phoneNumber.runtimeType);
  try {
    var url = Uri.parse(
        'http://api.agrobeba.com/api/customers/opts/send-code?phonenumber=$phoneNumber');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      Get.to(OtpScreen(phoneNumber));
    } else {}
  } catch (e) {
    print(' erreur $e');
  }
}

otpVerify(String code) async {
  try {
    var url = Uri.parse(
        "http://api.agrobeba.com/api/customers/opts/verify-code?code=$code");
    var response = await http.get(url);
    print('response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      saveToken(jsonDecode(response.body));
      // save credential on local storage
      Get.to(HomeScreen());
    } else {}
  } catch (e) {
    print("$e");
  }
}

customCreate(String firstname, String lastname) async {
  try {
    var url = Uri.parse('http://api.agrobeba.com/api/users');
    var response = await http.post(
      url,
      body: {
        'phoneNumber': '',
        'firstname': '$firstname',
        'lastname': '$lastname'
      },
    );
    print('response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      Get.to(HomeScreen());
    } else {}
  } catch (e) {
    print('$e');
  }
}

void saveToken(Map userProfile) async {
  var userdb = await Hive.openBox('userdb');

  userdb.put('token', jsonEncode(userProfile));
  print('succes');
}

Future<Map?>? getToken() async {
  var userdb = await Hive.openBox('userdb');
  String? token = userdb.get('token');
  print('showtoken $token');

  return token ?? jsonDecode(token!);

  // if (token == null) {
  //   return null;
  // }

  // return jsonDecode(token);
}

// decideRoute() async{

//   //step 1: check user login
//   User? user = FirebaseAuth.instance.currentUser;
//   if (user != null) {
//     //step 1.1 : check wether user profil exist
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(user.uid)
//         .get()
//         .then((value) {
//       if (value.exists) {
//         Get.to(() => HomeScreen());
//       } else {
//         Get.to(() => ProfileSreen());
//       }
//     });
//   }

//   //stp2 : check profil completed
// }

