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
import 'package:myegym/data/repo/trainer_repo.dart'; // For date formatting
import 'package:http/http.dart' as http;
import 'package:myegym/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class OwnerController extends GetxController {
  final OwnerRepo ownerRepo;

  OwnerController({required this.ownerRepo});

  Map<String, dynamic>? OwnerDashboardDetails;

  Future<void> getOwnerDashboardDetailsApi() async {
    print('Fetching Owner Dashboard Details ================>');
    LoadingDialog.showLoading();

    try {
      Response response = await ownerRepo.getOwnerDashboardDetails();

      if (response.statusCode == 200) {
        final data = response.body;
        if (data != null && data['status'] == 'success') {
          OwnerDashboardDetails = data['data'];
          print('Dashboard Details: $OwnerDashboardDetails');
        } else {
          print('Unexpected data format: $data');
        }
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception occurred: $e");
    }

    LoadingDialog.hideLoading();
    update();
  }

  Map<String, dynamic>? ownerProfileDetails;

  Future<void> getOwnerProfileApi() async {
    LoadingDialog.showLoading();
    try {
      Response response = await ownerRepo.getOwnerProfileDetails();

      if (response.statusCode == 200) {
        final data = response.body;
        if (data != null && data['status'] == 'success') {
          ownerProfileDetails = data['user']; // <-- fix here
          print('OwnerProfileDetails: $ownerProfileDetails');
        } else {
          print('Unexpected data format OwnerProfileDetails: $data');
        }
      } else {
        print(
            "Failed to load data OwnerProfileDetails: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception occurred OwnerProfileDetails: $e");
    }

    LoadingDialog.hideLoading();
    update();
  }
  Future<void> createWorkoutApi({
    required String startDate,
    required String endDate,
    required String notes,
    required String goals,
    required String level,
    required String time,
    required String activitie,
    required String subactivity,
    required String activitiesId,
    required String subactivityId,
    required String times,
    required String session,
    required String frequency,
    required List<Map<String, dynamic>> days,
  }) async {
    var headers = {
      'Authorization': 'Bearer ${Get.find<AuthController>().getUserToken()}',
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://lab7.invoidea.in/egym/api/workout/store'),
    );

    // Add static fields
    request.fields.addAll({
      'start_date': startDate,
      'end_date': endDate,
      'notes': notes,
      'goals': goals,
      'level': level,
      'injury': "2",
      'time': time,
      'activitie': activitie,
      'subactivity': subactivity,
      'activities_id': activitiesId,
      'subactivity_id': subactivityId,
      'times': times,
      'session': session,
      'frequency': frequency,
    });

    // Add dynamic days and subactivities
    for (int i = 0; i < days.length; i++) {
      final day = days[i];

      if (day.containsKey('day')) {
        request.fields['days[$i][day]'] = day['day'];
      }
      if (day.containsKey('activity')) {
        request.fields['days[$i][activity]'] = day['activity'];
      }

      if (day.containsKey('subactivities')) {
        List subactivities = day['subactivities'];
        for (int j = 0; j < subactivities.length; j++) {
          final sub = subactivities[j];
          if (sub['id'] != null) {
            request.fields['days[$i][subactivities][$j][id]'] = sub['id'];
          }
          if (sub['sets'] != null) {
            request.fields['days[$i][subactivities][$j][sets]'] = sub['sets'];
          }
          if (sub['reps'] != null) {
            request.fields['days[$i][subactivities][$j][reps]'] = sub['reps'];
          }
          if (sub['weight'] != null) {
            request.fields['days[$i][subactivities][$j][weight]'] = sub['weight'];
          }
          if (sub['rest'] != null) {
            request.fields['days[$i][subactivities][$j][rest]'] = sub['rest'];
          }
        }
      }
    }

    request.headers.addAll(headers);

    // Print request payload for debugging
    print("📤 Sending the following data to the API:");
    request.fields.forEach((key, value) {
      print('$key: $value');
    });

    try {
      http.StreamedResponse response = await request.send();

      String responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        print("✅ Success: $responseBody");
      } else {
        print("❌ Error ${response.statusCode}: ${response.reasonPhrase}");
        print("🧾 Response Body: $responseBody");
      }
    } catch (e) {
      print("❗ Exception occurred: $e");
    }
  }

  Rx<dynamic> selectedActivity = Rx<dynamic>({});
  // final Rx<TrainerModel?> selectedTrainer = Rx<TrainerModel?>(null);
  int _selectedActivityId = 0;


  int get selectedActivityId => _selectedActivityId;

  void selectActivityId(int val) {
    _selectedActivityId = val;
    update();
  }

  List<dynamic>? _activityList;
  List<dynamic>? get activityList => _activityList;

  Future<void> getActivityList() async {
    try {
      LoadingDialog.showLoading();
      update();

      print("🔥 Calling getActivityList API...");
      Response response = await ownerRepo.getWorkoutActivityRepo();

      print("📥 Full response getActivityList: ${response.bodyString}");
      print("📡 Status code getActivityList: ${response.statusCode}");

      if (response.statusCode == 200) {
        var responseData = response.body;

        // Directly access 'data' as a List<dynamic>
        List<dynamic> data = responseData["activities"];

        if (data.isNotEmpty) {
          var firstItem = data[0];

          print("🎯 First getActivityList info: $firstItem");

          selectedActivity.value = firstItem;
          _selectedActivityId = firstItem["id"];
        }

        print("🎯 getActivityList List Length: ${data.length}");
        _activityList = data; // Store the entire trainer list
      } else {
        print("❌ Non-200 response");
        var responseData = response.body;
        showCustomSnackBar(
          Get.context!,
          responseData["message"] ?? 'Error fetching trainer list',
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




  Rx<dynamic> selectedSubActivity = Rx<dynamic>({});
  // final Rx<TrainerModel?> selectedTrainer = Rx<TrainerModel?>(null);
  int _selectedSubActivityId = 0;


  int get selectedSubActivityId => _selectedSubActivityId;

  void selectSubActivityId(int val) {
    _selectedSubActivityId = val;
    update();
  }

  List<dynamic>? _subActivityList;
  List<dynamic>? get subActivityList => _subActivityList;

  Future<void> getSubActivityList() async {
    try {
      LoadingDialog.showLoading();
      update();

      print("🔥 Calling getSubActivityList API...");
      Response response = await ownerRepo.getWorkoutSubActivityRepo();

      print("📥 Full response getSubActivityList: ${response.bodyString}");
      print("📡 Status code getSubActivityList: ${response.statusCode}");

      if (response.statusCode == 200) {
        var responseData = response.body;

        // Directly access 'data' as a List<dynamic>
        List<dynamic> data = responseData["activities"];

        if (data.isNotEmpty) {
          var firstItem = data[0];

          print("🎯 First getSubActivityList info: $firstItem");

          selectedSubActivity.value = firstItem;
          _selectedSubActivityId = firstItem["id"];
        }

        print("🎯 getSubActivityList List Length: ${data.length}");
        _subActivityList = data; // Store the entire trainer list
      } else {
        print("❌ Non-200 response getSubActivityList");
        var responseData = response.body;
        showCustomSnackBar(
          Get.context!,
          responseData["message"] ?? 'Error fetching trainer list',
          isError: true,
        );
      }
    } catch (e) {
      print("🚨 Exception: $e");
      showCustomSnackBar(Get.context!, 'Something went wrong getSubActivityList: $e',
          isError: true);
    } finally {
      LoadingDialog.hideLoading();
      update();
    }
  }


}
