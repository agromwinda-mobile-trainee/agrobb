import 'dart:convert';
import 'dart:developer';
import 'package:agrobeba/commons/home/routestack.dart';
import 'package:geolocator/geolocator.dart';
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
      savePhoneNumber(phoneNumber);
      Get.to(OtpScreen(phoneNumber));
    } else {}
  } catch (e) {
    print(' erreur $e');
  }
}

otpVerify(String code, String phoneNumber) async {
  try {
    var url = Uri.parse(
        "http://api.agrobeba.com/api/customers/opts/verify-code?code=$code");
    var response =
        await http.get(url, headers: {"content-type": "application/json"});
    print('response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      print('response : ${jsonDecode(response.body)}');
      saveToken(jsonDecode(response.body));
      // savePhoneNumber(phoneNumber);
      // save credential on local storage
      Get.to(const RouteStack());
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
      Get.to(const RouteStack());
    } else {}
  } catch (e) {
    print('$e');
  }
}

void saveToken(Map userProfile) async {
  var userdb = await Hive.openBox('userdb');

  userdb.put('token', jsonEncode(userProfile));
  userdb.put('jwt', userProfile["hydra:member"][0]["jwt"]);
  print('token saved: ${userProfile["hydra:member"][0]["jwt"]}');
}

void savePhoneNumber(String phoneNumber) async {
  var userdb = await Hive.openBox('userdb');

  userdb.put('phoneNumber', phoneNumber);
  print('PhoneNumber saved: $phoneNumber');
}

Future<void> logout() async {
  try {
    var userdb = await Hive.openBox('userdb');

    userdb.put('phoneNumber', null);
    userdb.put('jwt', null);
    userdb.put('token', null);
    print('PhoneNumber & token removed');
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

    print('showtoken $token');
    // print(_token["hydra:member"][0]["jwt"]);

    return token;

    // if (token == null) {
    //   return null;
    // }

    // return jsonDecode(token);
  } catch (e) {
    print('erreur $e');
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
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      log('reponse');
      print(jsonDecode(response.body));
      final Map data = jsonDecode(response.body) as Map;
      return data["data"];
    } else {
      log("Erreur");
      return null;
    }
  } catch (e) {
    print("erreur pick $e");
    return null;
  }
}

//send latlong for destination and depart point
Future<Map?>? sendCourseRequest(
    {required Map endPoint,
    required Map startPoint,
    required String token}) async {
  log("on send request");
  print("startPoint: $startPoint");
  print("endPoint: $endPoint");

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
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(jsonDecode(response.body));
      return jsonDecode(response.body) as Map;
    } else {
      print("Fail on send service-request: ${response.body} ");
      return null;
    }
  } catch (e) {
    print("erreur on send service-request: $e");
    return null;
  }
}

Future<Map?> findDrivers(int idRequest) async {
  print("*** find driver. Id request: $idRequest");
  try {
    var url =
        Uri.parse('http://api.agrobeba.com/api/personal_requests/$idRequest');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      log('reponse');
      print(jsonDecode(response.body));
      final Map data = jsonDecode(response.body) as Map;
      return data;
    } else {
      print("Request Failed: ${response.statusCode} - ${response.body}");
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

Future<List?> getCommandes({required String token}) async {
  try {
    var url = Uri.parse('http://api.agrobeba.com/api/personal_requests');
    var response = await http.get(url, headers: {
      "content-type": "application/json",
      "Authorization": "Bearer $token"
    });
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      log('reponse');
      print(jsonDecode(response.body));
      final Map data = jsonDecode(response.body);
      return data["hydra:member"];
    } else {
      print("Request Failed: ${response.statusCode} - ${response.body}");
      return null;
    }
  } catch (e) {
    print("erreur pick " + e.toString());
    return null;
  }
}

Future<void> sendCurrentPosition({required Map data}) async {
  try {
    var url = Uri.parse('https://eppt.graciasgroup.com/api/sms/send');
    var response = await http
        .post(url,
            headers: {
              "content-type": "application/json",
              // "Content-Length": "220",
            },
            body: jsonEncode(data))
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('*** Send Driver Position Response: ${response.statusCode}');
      print('*** Send Driver Position Response: ${response.body}');
    } else {
      print('*** Send Driver Position Response: ${response.statusCode}');
      print('*** Send Driver Position Response: ${response.body}');
    }
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
    print('Response status: ${response.statusCode}');
    print('Response status: ${response.body}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.statusCode;
    }
    print('Response status: ${response.body}');

    return 400;
  } catch (e) {
    print("erreur pick " + e.toString());
    return 500;
  }
}

// Future<Position> determinePosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   // Test if location services are enabled.
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     // Location services are not enabled don't continue
//     // accessing the position and request users of the
//     // App to enable the location services.
//     return Future.error('Location services are disabled.');
//   }

//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       // Permissions are denied, next time you could try
//       // requesting permissions again (this is also where
//       // Android's shouldShowRequestPermissionRationale
//       // returned true. According to Android guidelines
//       // your App should show an explanatory UI now.
//       return Future.error('Location permissions are denied');
//     }
//   }

//   if (permission == LocationPermission.deniedForever) {
//     // Permissions are denied forever, handle appropriately.
//     return Future.error(
//         'Location permissions are permanently denied, we cannot request permissions.');
//   }

//   // When we reach here, permissions are granted and we can
//   // continue accessing the position of the device.
//   return await Geolocator.getCurrentPosition();
// }
