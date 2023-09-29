// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:agrobeba/commons/home/api_contents/controller/user.dart';
// import 'package:flutter/foundation.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Authentification extends ChangeNotifier {
//   String errorMessage = "";

//   bool _rememberMe = false;
//   bool _stayLoggedIn = true;
//   User _user;

//   bool get rememberMe => _rememberMe;

//   void handleRememberMe(bool value) {
//     _rememberMe = value;
//     notifyListeners();
//     SharedPreferences.getInstance().then((prefs) {
//       prefs.setBool("remember_me", value);
//     });
//   }

//   bool get stayLoggedIn => _stayLoggedIn;

//   void handleStayLoggedIn(bool value) {
//     _stayLoggedIn = value;
//     notifyListeners();
//     SharedPreferences.getInstance().then((prefs) {
//       prefs.setBool("stay_logged_in", value);
//     });
//   }

//   void loadSettings() async {
//     var _prefs = await SharedPreferences.getInstance();

//     try {
//       _rememberMe = _prefs.getBool("remember_me") ?? false;
//     } catch (e) {
//       print(e);
//       _rememberMe = false;
//     }
//     try {
//       _stayLoggedIn = _prefs.getBool("stay_logged_in") ?? false;
//     } catch (e) {
//       print(e);
//       _stayLoggedIn = false;
//     }

//     if (_stayLoggedIn) {
//       User _savedUser;
//       try {
//         String? _saved = _prefs.getString("user_data");
//         print("Saved: $_saved");
//         _savedUser = User.fromJson(json.decode(_saved!));
//       } catch (e) {
//         print("User Not Found: $e");
//       }
//     }
//     notifyListeners();
//   }

//   User get user => _user;

//   Future<User?> getInfo(String token) async {
//     try {
//     var url= Uri.parse('http://api.agrobeba.com/api/users');
//       var _data = await http.get(url);
//       // var _json = json.decode(json.encode(_data));
//       var _newUser = User.fromJson(json.decode(_data.body)["data"]);
//       _newUser?.token = token;
//       return _newUser;
//     } catch (e) {
//       print("Could Not Load Data: $e");
//       return null;
//     }
//   }

//   Future<bool> login({
//     @required String username,
//     @required String password,
//   }) async {
//     var uuid = new Uuid();
//     String _username = username;
//     String _password = password;

//     // TODO: API LOGIN CODE HERE
//     await Future.delayed(Duration(seconds: 3));
//     print("Logging In => $_username, $_password");

//     if (_rememberMe) {
//       SharedPreferences.getInstance().then((prefs) {
//         prefs.setString("saved_username", _username);
//       });
//     }

//     // Get Info For User
//     User _newUser = await getInfo(uuid.v4().toString());
//     if (_newUser != null) {
//       _user = _newUser;
//       notifyListeners();

//       SharedPreferences.getInstance().then((prefs) {
//         var _save = json.encode(_user.toJson());
//         print("Data: $_save");
//         prefs.setString("user_data", _save);
//       });
//     }

//     if (_newUser?.token == null || _newUser.token.isEmpty) return false;
//     return true;
//   }

//   Future<void> logout() async {
//     _user = null;
//     notifyListeners();
//     SharedPreferences.getInstance().then((prefs) {
//       prefs.setString("user_data", null);
//     });
//     return;
//   }
// }
