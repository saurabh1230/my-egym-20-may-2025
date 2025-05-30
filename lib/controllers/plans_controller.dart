import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myegym/app/widgets/custom_snackbar.dart';
import 'package:myegym/app/widgets/loading_dialog.dart';
import 'package:myegym/controllers/auth_controller.dart';
import 'package:myegym/data/models/trainer_details_model.dart';
import 'package:myegym/data/models/trainer_model.dart';
import 'package:myegym/data/repo/owner_repo.dart';
import 'package:myegym/data/repo/plan_repo.dart';
import 'package:myegym/data/repo/trainer_repo.dart'; // For date formatting
import 'package:http/http.dart' as http;
import 'package:myegym/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlansController extends GetxController {
  final PlanRepo planRepo;

  PlansController({required this.planRepo});

  List<dynamic>? _ptPlanListing;
  List<dynamic>? get ptPlanListing => _ptPlanListing;

  Future<void> getPtPlanApi() async {
    try {
      LoadingDialog.showLoading();
      update();

      print("🔥 Calling getPtPlanApi API...");
      Response response = await planRepo.getPtPlanListing();

      print("📥 Full response: ${response.bodyString}");
      print("📡 Status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        var responseData = response.body;

        if (responseData["status"] == "success") {
          print("✅ API returned success");

          // Directly access 'data' as a List<dynamic>
          List<dynamic> data = responseData["data"];

          print("🎯 getPtPlanApi List Length: ${data.length}");
          _ptPlanListing = data; // Store the entire trainer list
        } else {
          print("⚠️ Response status is not success");
          showCustomSnackBar(
            Get.context!,
            responseData["message"] ?? 'Failed to fetch getPtPlanApi',
            isError: true,
          );
        }
      } else {
        print("❌ Non-200 response");
        var responseData = response.body;
        showCustomSnackBar(
          Get.context!,
          responseData["message"] ?? 'Error fetching getPtPlanApi',
          isError: true,
        );
      }
    } catch (e) {
      print("🚨 Exception: $e");
      showCustomSnackBar(Get.context!, 'Something went wrong: $e',
          isError: true);
    } finally {
      LoadingDialog.hideLoading();
      update();
    }
  }

  List<dynamic>? _workoutListing;
  List<dynamic>? get workoutListing => _workoutListing;

  Future<void> getWorkoutListing() async {
    try {
      LoadingDialog.showLoading();
      update();

      print("🔥 Calling getWorkoutListing API...");
      Response response = await planRepo.getWorkoutListing();

      print("📥 Full response: ${response.bodyString}");
      print("📡 Status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        var responseData = response.body;

        if (responseData["success"] == true) {
          print("✅ API returned success");

          // Directly access 'data' as a List<dynamic>
          List<dynamic> data = responseData["workouts"];

          print("🎯 getWorkoutListing List Length: ${data.length}");
          _workoutListing = data; // Store the entire trainer list
        } else {
          print("⚠️ Response status is not success");
          showCustomSnackBar(
            Get.context!,
            responseData["message"] ?? 'Failed to fetch getWorkoutListing',
            isError: true,
          );
        }
      } else {
        print("❌ Non-200 response");
        var responseData = response.body;
        showCustomSnackBar(
          Get.context!,
          responseData["message"] ?? 'Error fetching getWorkoutListing',
          isError: true,
        );
      }
    } catch (e) {
      print("🚨 Exception: $e");
      showCustomSnackBar(Get.context!, 'Something went wrong: $e',
          isError: true);
    } finally {
      LoadingDialog.hideLoading();
      update();
    }
  }


  Rx<dynamic> selectedDietPlan = Rx<dynamic>({});
  // final Rx<TrainerModel?> selectedTrainer = Rx<TrainerModel?>(null);
  int _selectedDietPlanId = 0;


  int get selectedDietPlanId => _selectedDietPlanId;

  void selectDietPlanId(int val) {
    _selectedDietPlanId = val;
    update();
  }


  List<dynamic>? _dietPlanListing;
  List<dynamic>? get dietPlanListing => _dietPlanListing;

  Future<void> getDietPlan() async {
    try {
      LoadingDialog.showLoading();
      update();

      print("🔥 Calling _dietListing API...");
      Response response = await planRepo.getDietPlanListing();

      print("📥 Full response: ${response.bodyString}");
      print("📡 Status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        var responseData = response.body;

        if (responseData["status"] == "success") {
          print("✅ API returned success");

          // Directly access 'data' as a List<dynamic>
          List<dynamic> data = responseData["data"];

          if (data.isNotEmpty) {
            var firstItem = data[0];

            print("🎯 First _dietListing info: $firstItem");

            selectedDietPlan.value = firstItem;
            _selectedDietPlanId = firstItem["id"];
          }

          print("🎯 _dietListing List Length: ${data.length}");
          _dietPlanListing = data;
        } else {
          print("⚠️ Response status is not success");
          showCustomSnackBar(
            Get.context!,
            responseData["message"] ?? 'Failed to fetch _dietListing',
            isError: true,
          );
        }
      } else {
        print("❌ Non-200 response");
        var responseData = response.body;
        showCustomSnackBar(
          Get.context!,
          responseData["message"] ?? 'Error fetching _dietListing',
          isError: true,
        );
      }
    } catch (e) {
      print("🚨 Exception: $e");
      showCustomSnackBar(Get.context!, 'Something went wrong: $e',
          isError: true);
    } finally {
      LoadingDialog.hideLoading();
      update();
    }
  }

  Future<void> addMealPlan({required List<dynamic> mealPlans}) async {
    LoadingDialog.showLoading();
    update();
    print('📤 Starting API Call: Add Meal Plan');

    var url = Uri.parse('${AppConstants.baseUrl}meal-plan/store');
    print('🔗 URL: $url');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Get.find<AuthController>().getUserToken()}',
    };
    print('🧾 Headers: $headers');

    var body = jsonEncode(mealPlans);
    print('📦 Request Body: $body');

    try {
      final response = await http.post(url, headers: headers, body: body);

      print('📬 Response Status: ${response.statusCode}');
      print('📨 Response Headers: ${response.headers}');
      print('📄 Response Body: ${response.body}');

      final data = jsonDecode(response.body);

      if (data['success'] == true) {
        LoadingDialog.hideLoading();
        showCustomSnackBar(Get.context!, "Meal Plan Added Successfully");
      } else {
        // Optional: Parse and display errors
        String errorMsg = "Something went wrong";
        if (data['errors'] != null && data['errors'].isNotEmpty) {
          errorMsg = data['errors'].map((e) => e['message']).join("\n");
        } else if (data['message'] != null) {
          errorMsg = data['message'];
        }

        LoadingDialog.hideLoading();
        showCustomSnackBar(Get.context!, errorMsg, isError: true);
      }

      update();
    } catch (e) {
      print("⚠️ Exception: $e");
      LoadingDialog.hideLoading();
      showCustomSnackBar(Get.context!, "Failed to add meal plan. Please try again.", isError: true);
    } finally {
      update();
      print('🏁 API Call Finished');
    }
  }



}
