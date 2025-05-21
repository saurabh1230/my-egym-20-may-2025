import 'dart:async';

import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:myegym/data/api/api_client.dart';
import 'package:myegym/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<bool> saveUserToken(
    String token,
  ) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.token, token);
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? "";
  }

  Future<bool> clearSharedData() async {
    await sharedPreferences.remove(AppConstants.token);
    return true;
  }



  Future<Response> loginRepo(email, gymId, password) {
    return apiClient.getData(
        '${AppConstants.ownerLogin}?email=$email&gym_id=$gymId&password=$password');
  }
}
