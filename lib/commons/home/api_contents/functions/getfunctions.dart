import 'dart:convert';
import 'dart:developer';
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
  try {
    var userdb = await Hive.openBox('userdb');
    String? token = userdb.get('token');
    bool data = await checkData();
    if (data) {
      final String token = userdb.get("token");
      if (data == null) {
        return {'code': 404, 'message': 'utilisateur non trouvé'};
      }
    } else {
      return {
        'code': 404,
        'message': 'utilisateur non trouvé',
      };
    }
    print('showtoken $token');

    print(jsonDecode(token!).runtimeType);
    return jsonDecode(token) as Map;

    // if (token == null) {
    //   return null;
    // }

    // return jsonDecode(token);
  } catch (e) {
    print('erreur $e');
  }
}

//

Future<Map?> getCredentials() async {
  try {
    final savetoken = await Hive.openBox("userdb");
    bool data = await checkData();
    if (data) {
      final String token = savetoken.get("token");

      if (data == null) {
        return {'code': 404, 'message': 'utilisateur non trouvé'};
      }
    } else {
      return {
        'code': 404,
        'message': 'utilisateur non trouvé',
      };
    }
  } catch (error) {
    return {
      'code': 500,
      'message': "Error on get user data: ${error.toString()}",
    };
  }
}

//

Future<bool> checkData() async {
  final savetoken = await Hive.openBox("userdb");
  var result = await savetoken.get("token");
  if (result == null) return false;
  return true;
}

//places

//get function for destination

Future<List?> pickPlaces(String places) async {
  try {
    var url = Uri.parse(
        'http://places.graciasgroup.com/places?page=1&search=$places');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      log('reponse');
      print(jsonDecode(response.body));
      final Map? data = jsonDecode(response.body) as Map;
      return data!["data"];
    } else {
      log("Erreur");
      return null;
    }
  } catch (e) {
    print("erreur pick " + e.toString());
    return null;
  }
  ;
}

//send latlong for destination and depart point
sendCourseRequest() async {
  try {
    String lat1 = "-4.267778";
    String long1 = "15.291944";
    String lat2 = "-4.325";
    String long2 = "15.322222";
    var url = Uri.parse('api.agrobeba.com/api/personal_requests HTTP/1.1');
    var response = await http.post(url, body: {
      "service": "",
      "customer": "",
      "endPoint": {
        'Longitude': long1,
        'latitude': lat1,
      },
      "sartpoint": {
        "Longitude": long2,
        "latitude": lat2,
      },
    });
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      log('reponse');
      print(jsonDecode(response.body));
      final data = jsonDecode(response.body);
      return data!["data"];
    } else {
      log("Erreur eeeeeeeeeeee");
      return null;
    }
  } catch (e) {
    print("erreur $e");
  }
}
