import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// var SERVER_IP = 'http://192.168.43.77:4000';
var SERVER_IP = 'http://192.168.43.201:4000';

Map<String, dynamic> parseJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('Invalid token');
  }

  final payload = _decodeBase64(parts[1]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('Invalid payload');
  }
  return payloadMap;
}

String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');
  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!');
  }

  return utf8.decode(base64Url.decode(output));
}

bool validateJwt(payload) {
  if (DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000)
      .isAfter(DateTime.now())) {
    return true;
  } else {
    return false;
  }
}

class HelperFunctions {
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";
  static String sharedPreferenceJwtKey = "jwt";

  // Save data to shared preference

  static Future<bool> saveUserLoggedInSharedPreference(
      bool isUserLoggedIn) async {
    SharedPreferences prefs =
        SharedPreferences.getInstance() as SharedPreferences;
    return await prefs.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveJwtSharedPreference(String jwt) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceJwtKey, jwt);
  }

  static Future<String> getJwtSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(sharedPreferenceJwtKey);
    return value;
  }

  // static Future<bool> saveUserNameSharedPreference(String userName) async {
  //   SharedPreferences prefs =
  //       SharedPreferences.getInstance() as SharedPreferences;
  //   return await prefs.setString(sharedPreferenceUserNameKey, userName);
  // }

  // static Future<bool> saveUserEmailSharedPreference(String userEmail) async {
  //   SharedPreferences prefs =
  //       SharedPreferences.getInstance() as SharedPreferences;
  //   return await prefs.setString(sharedPreferenceUserEmailKey, userEmail);
  // }

  // // Get data from shared preference

  // static Future<bool> getUserLoggedInSharedPreference() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool(sharedPreferenceUserLoggedInKey);
  // }

  // static Future<String> getJwtSharedPreference() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString("jwt");
  // }

  // static Future<String> getUserNameSharedPreference() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(sharedPreferenceUserNameKey);
  // }

  // static Future<String> getUserEmailSharedPreference() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(sharedPreferenceUserEmailKey);
  // }
}