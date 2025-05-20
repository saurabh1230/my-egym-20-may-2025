import 'dart:convert';

import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:myegym/app/views/auth/login.dart';
import 'package:myegym/app/widgets/custom_snackbar.dart';
import 'package:myegym/app/widgets/loading_dialog.dart';

import 'package:myegym/data/repo/auth_repo.dart';
import 'package:myegym/helper/route_helper.dart';
import 'package:myegym/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  final SharedPreferences sharedPreferences;
  AuthController({
    required this.authRepo,
    required this.sharedPreferences,
  });

  int _loginType = 0;
  int get loginType => _loginType;

  void selectLoginType(int index) {
    _loginType = index;
    print(loginType);
    update();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  XFile? _pickedImage;
  XFile? get pickedImage => _pickedImage;

  void pickImage({required bool isRemove}) async {
    if (isRemove) {
      _pickedImage = null;
    } else {
      _pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    }
    update();
  }

  Future<bool> clearSharedData() async {
    return await authRepo.clearSharedData();
  }

  String _fcmToken = '';
  String get fcmToken => _fcmToken;

  Future<bool> saveLoginType(
    String token,
  ) async {
    return await sharedPreferences.setString(AppConstants.loginType, token);
  }

  String getLoginType() {
    return sharedPreferences.getString(AppConstants.loginType) ?? "";
  }

  void selectFcmToken(String val) {
    _fcmToken = val;
    update();
  }

  Future<void> loginApi({
    required String email,
    required String gymId,
    required String password,
  }) async {
    try {
      LoadingDialog.showLoading();
      update();

      Response response = await authRepo.loginRepo(email, gymId, password);
      var responseData = response.body;

      if (responseData == null) {
        LoadingDialog.hideLoading();
        update();
        showCustomSnackBar(Get.context!, "Invalid email, gym ID, or password",
            isError: true);
        return;
      }

      if (responseData["status"] == "error") {
        LoadingDialog.hideLoading();
        update();

        String errorMessage = responseData["message"] ?? "An error occurred.";
        if (responseData["errors"] != null && responseData["errors"] is Map) {
          var errors = responseData["errors"] as Map;
          errorMessage = errors.entries
              .map((e) =>
                  "${e.value is List ? (e.value as List).join(', ') : e.value}")
              .join("\n");
        }

        showCustomSnackBar(Get.context!, errorMessage, isError: true);
        return;
      }

      var token = responseData['data']?['token'];
      var user = responseData['data']?['user'];
      var userType = user?['type'];

      if (token != null && userType != null) {
        authRepo.saveUserToken(token);
        saveLoginType(userType);
        switch (userType) {
          case 'owner':
            Get.offAllNamed(RouteHelper.getOwnerDashboard());
            break;
          case 'trainer':
            Get.offAllNamed(RouteHelper.getTrainerDashboard());
            break;
          case 'user':
            Get.offAllNamed(RouteHelper.getUserDashboard());
            break;
          default:
            showCustomSnackBar(Get.context!, "Unknown user type",
                isError: true);
        }
      } else {
        LoadingDialog.hideLoading();
        update();
        showCustomSnackBar(
            Get.context!, "Login failed, token or user type missing",
            isError: true);
        return;
      }

      LoadingDialog.hideLoading();
      update();
    } catch (e) {
      LoadingDialog.hideLoading();
      update();
      showCustomSnackBar(Get.context!, "Something went wrong: $e",
          isError: true);
    }
  }
}
