import 'package:hive/hive.dart';

class AuthentificationRepository {
  static Future<bool> checkdata() async {
    final token = await Hive.openBox('userdb');
    var result = await token.get('token');
    if (result == null) {
      return false;
    }
    return true;
  }
}
