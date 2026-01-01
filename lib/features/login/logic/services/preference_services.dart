import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:zanadu/core/constants.dart';

class Preferences {
  static Future<void> saveUserDetails(
      String email, String password) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setString("email", email);
    await instance.setString("password", password);
    await instance.setBool("remember_me", true);
  
    log("Details saved!");
  }

  static Future<void> saveUserEmail(String email) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setString("user_email", email);
    userEmail = email;
    log("User email saved!");
  }

  static Future<Map<String, dynamic>> fetchUserDetails() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    String? email = instance.getString("email");
    String? password = instance.getString("password");
    bool? rememberMe = instance.getBool("remember_me");
  
    return {"email": email, "password": password, "remember_me": rememberMe ?? false};
  }

  static Future<String?> fetchUserEmail() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    return instance.getString("user_email");
  }

  static Future<void> saveAccessToken(String token) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setString("token", token);
    accessToken = token;
    log("Access token saved!");
  }

  static Future<String?> fetchAccessToken() async {
    SharedPreferences instance = await SharedPreferences.getInstance();

    return instance.getString("token");
  }

  static Future<void> clear() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.clear();
  }

  static Future<void> clearUserDetails() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.remove("email");
    await instance.remove("password");
    await instance.remove("remember_me");
    log("User details cleared!");
  }
}