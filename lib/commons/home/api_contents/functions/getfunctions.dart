import 'dart:convert';
import 'dart:developer';
import 'package:agrobeba/commons/home/home.dart';
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
}

//send latlong for destination and depart point
Future<Map?> sendCourseRequest(
    {required Map endPoint, required Map startPoint}) async {
  print("on send request");
  try {
    var url = Uri.parse('api.agrobeba.com/api/personal_requests HTTP/1.1');
    var response = await http.post(url, body: {
      "service": "",
      "customer": "",
      "endPoint": endPoint,
      "sartpoint": startPoint,
    });
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(jsonDecode(response.body));
      return jsonDecode(response.body) as Map;
    } else {
      print("Fail on send service-request: ${response.body.toString()} ");
      return null;
    }
  } catch (e) {
    print("erreur on send service-request: $e");
    return null;
  }
}

Future<List?> findDrivers(int idRequest) async {
  try {
    var url = Uri.parse(
        'http://api.agrobeba.com/api/drivers/personal-requests/$idRequest');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      log('reponse');
      print(jsonDecode(response.body));
      final Map? data = jsonDecode(response.body) as Map;
      return data!["data"];
    } else {
      log("Request Failed: ${response.statusCode} - ${response.body}");
      return null;
    }
  } catch (e) {
    print("erreur pick " + e.toString());
    return null;
  }
}

Future<Map?> chooseDriver(int driverID) async {
  try {
    var url = Uri.parse('http://api.agrobeba.com/api/drivers/$driverID/choose');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      log('reponse');
      print(jsonDecode(response.body));
      final Map? data = jsonDecode(response.body) as Map;
      return data!;
    } else {
      log("Request Failed: ${response.statusCode} - ${response.body}");
      return null;
    }
  } catch (e) {
    print("erreur pick " + e.toString());
    return null;
  }
}
