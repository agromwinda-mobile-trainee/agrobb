import 'dart:convert';
import 'dart:developer';

import 'package:agrobeba/commons/home/routestack.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../../otpscreen.dart';

sendCode(String phoneNumber) async {
  log("****send phonenumber");
  try {
    var url = Uri.parse(
        'http://api.agrobeba.com/api/customers/opts/send-code?phonenumber=$phoneNumber');
    var response = await http.get(url);
    log('*****Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      log('**** Send PhoneNumber Response: ${response.body}');
      savePhoneNumber(phoneNumber);
      Get.to(OtpScreen(phoneNumber));
    } else {
      log('*****Response status: ${response.statusCode}');
      log('**** Send PhoneNumber Response: ${response.body}');
      Get.snackbar("Erreur d'Authentification !", "");
    }
  } catch (e) {
    log(' erreur $e');
    Get.snackbar("Erreur d'Authentification !", "");
  }
}

otpVerify(String code, String phoneNumber) async {
  log("***** on verify otp--");
  try {
    var url = Uri.parse(
        "http://api.agrobeba.com/api/customers/opts/verify-code?code=$code");
    var response =
        await http.get(url, headers: {"content-type": "application/json"});
    log('**** response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      log('*** otp verified : ${jsonDecode(response.body)}');
      saveToken(jsonDecode(response.body));
      // savePhoneNumber(phoneNumber);
      // save credential on local storage
      Get.to(const RouteStack());
    } else {
      log("****otp failled: ${response.body}");
      Get.snackbar("Code de verification erroné", "");
    }
  } catch (e) {
    log("****Error on verify otp: $e");
    Get.snackbar("Erreur de verification du code", "");
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
    log('response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      Get.to(const RouteStack());
    } else {}
  } catch (e) {
    log('$e');
  }
}

void saveToken(Map userProfile) async {
  var userdb = await Hive.openBox('userdb');

  userdb.put('token', jsonEncode(userProfile));
  userdb.put('jwt', userProfile["hydra:member"][0]["jwt"]);
  log('***token saved: ${userProfile["hydra:member"][0]["jwt"]}');
}

void savePhoneNumber(String phoneNumber) async {
  var userdb = await Hive.openBox('userdb');

  userdb.put('phoneNumber', phoneNumber);
  log('PhoneNumber saved: $phoneNumber');
}

Future<void> logout() async {
  try {
    var userdb = await Hive.openBox('userdb');

    userdb.put('phoneNumber', null);
    userdb.put('jwt', null);
    userdb.put('token', null);
    log('PhoneNumber & token removed');
  } catch (error) {
    log(error.toString());
  }
}

Future<String?>? getPhoneNumber() async {
  try {
    var userdb = await Hive.openBox('userdb');
    String? phoneNumber = userdb.get('phoneNumber');
    return phoneNumber;
  } catch (error) {
    log(error.toString());
    return null;
  }
}

Future<String?> getToken() async {
  try {
    var userdb = await Hive.openBox('userdb');
    String? token = userdb.get('jwt');
    // bool data = await checkData();
    // if (data) {
    //   final String token = userdb.get("token");
    //   if (data == null) {
    //     return {'code': 404, 'message': 'utilisateur non trouvé'};
    //   }
    // } else {
    //   return {
    //     'code': 404,
    //     'message': 'utilisateur non trouvé',
    //   };
    // }

    // Map _token = jsonDecode(token!);

    log('showtoken $token');
    // log(_token["hydra:member"][0]["jwt"]);

    return token;

    // if (token == null) {
    //   return null;
    // }

    // return jsonDecode(token);
  } catch (e) {
    log('erreur $e');
    return null;
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
    log('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      log('reponse');
      log(jsonDecode(response.body));
      final Map data = jsonDecode(response.body) as Map;
      return data["data"];
    } else {
      log(response.body.toString());
      return null;
    }
  } catch (e) {
    log("erreur to pick places: $e");
    return null;
  }
}

//send latlong for destination and depart point
Future<Map?>? sendCourseRequest(
    {required Map endPoint,
    required Map startPoint,
    required String token}) async {
  log("on send request");
  log("startPoint: $startPoint");
  log("endPoint: $endPoint");

  try {
    var url = Uri.parse('http://api.agrobeba.com/api/personal_requests');
    var response = await http
        .post(url,
            headers: {
              "content-type": "application/json",
              // "Content-Length": "220",
              "Authorization": "Bearer $token",
            },
            body: jsonEncode({
              "service": "/api/personal_services/1",
              "customer": "/api/users/1",
              "endPoint": endPoint,
              "startPoint": startPoint,
            }))
        .timeout(const Duration(seconds: 5));
    log('Response status: ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      log(jsonDecode(response.body));
      return jsonDecode(response.body) as Map;
    } else {
      log("Fail on send service-request: ${response.body} ");
      return null;
    }
  } catch (e) {
    log("erreur on send service-request: $e");
    return null;
  }
}

Future<Map?> findDrivers(int idRequest) async {
  log("*** find driver. Id request: $idRequest");
  try {
    var url =
        Uri.parse('http://api.agrobeba.com/api/personal_requests/$idRequest');
    var response = await http.get(url);
    log('Response status: ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      log('reponse');
      log(jsonDecode(response.body));
      final Map data = jsonDecode(response.body) as Map;
      return data;
    } else {
      log("Request Failed: ${response.statusCode} - ${response.body}");
      return null;
    }
  } catch (e) {
    log("erreur pick " + e.toString());
    return null;
  }
}

Future<Map?> chooseDriver(int driverID) async {
  try {
    var url = Uri.parse('http://api.agrobeba.com/api/drivers/$driverID/choose');
    var response = await http.get(url);
    log('Response status: ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      log('reponse');
      log(jsonDecode(response.body));
      final Map? data = jsonDecode(response.body) as Map;
      return data!;
    } else {
      log("Request Failed: ${response.statusCode} - ${response.body}");
      return null;
    }
  } catch (e) {
    log("erreur pick " + e.toString());
    return null;
  }
}

Future<List?> getCommandes({required String token}) async {
  try {
    var url = Uri.parse('http://api.agrobeba.com/api/personal_requests');
    var response = await http.get(url, headers: {
      "content-type": "application/json",
      "Authorization": "Bearer $token"
    });
    log('Response status: ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      log('reponse');
      log(jsonDecode(response.body));
      final Map data = jsonDecode(response.body);
      return data["hydra:member"];
    } else {
      log("Request Failed: ${response.statusCode} - ${response.body}");
      return null;
    }
  } catch (e) {
    log("erreur pick " + e.toString());
    return null;
  }
}

Future<void> sendCurrentPosition({required Map data}) async {
  try {
    var url = Uri.parse('http://eppt.graciasgroup.com/api/sms/send');
    var response = await http
        .post(url,
            headers: {
              "content-type": "application/json",
              // "Content-Length": "220",
            },
            body: jsonEncode(data))
        .timeout(const Duration(seconds: 10));
    log('Response status: ${response.statusCode}');
  } catch (e) {
    log("erreur on sendCurrentPosition : $e");
  }
}

Future<int?>? confirmCommande({required String token, required id}) async {
  try {
    var url =
        Uri.parse('http://api.agrobeba.com/api/personal_requests/$id/confirm');
    var response = await http.get(url, headers: {
      "content-type": "application/json",
      "Authorization": "Bearer $token"
    });
    log('Response status: ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.statusCode;
    }
    return 400;
  } catch (e) {
    log("erreur pick " + e.toString());
    return 500;
  }
}
