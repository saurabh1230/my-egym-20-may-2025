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




}
