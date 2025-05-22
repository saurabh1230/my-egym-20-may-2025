import 'dart:convert';
import 'dart:io';
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
    required String photoFilePath,
  }) async {
    var url = Uri.parse('https://lab7.invoidea.in/egym/api/workout/store');

    var headers = {
      'Authorization': 'Bearer ${Get.find<AuthController>().getUserToken()}',
    };

    var request = http.MultipartRequest('POST', url);
    request.headers.addAll(headers);

    // 🧠 Add form fields
    request.fields['activity_id'] = activitiesId;
    request.fields['start_date'] = startDate;
    request.fields['end_date'] = endDate;
    request.fields['notes'] = notes;
    request.fields['goals'] = goals;
    request.fields['level'] = level;
    request.fields['injury'] = "2";
    request.fields['time'] = time;
    request.fields['activitie'] = activitie;
    request.fields['subactivity'] = subactivity;
    request.fields['activities_id'] = activitiesId;
    request.fields['subactivity_id'] = subactivityId;
    request.fields['times'] = times;
    request.fields['session'] = session;
    request.fields['frequency'] = frequency;

    // 🔁 Add complex 'days' structure manually
    for (int i = 0; i < days.length; i++) {
      var day = days[i];
      request.fields['days[$i][day]'] = day['day'];
      request.fields['days[$i][activity]'] = day['activity'].toString();

      List subactivities = day['subactivities'];
      for (int j = 0; j < subactivities.length; j++) {
        var sub = subactivities[j];
        request.fields['days[$i][subactivities][$j][id]'] = sub['id'].toString();
        request.fields['days[$i][subactivities][$j][sets]'] = sub['sets'].toString();
        request.fields['days[$i][subactivities][$j][reps]'] = sub['reps'].toString();
        request.fields['days[$i][subactivities][$j][weight]'] = sub['weight'].toString();
        request.fields['days[$i][subactivities][$j][rest]'] = sub['rest'].toString();
      }
    }

    // 📷 Attach photo if present
    if (photoFilePath.isNotEmpty) {
      try {
        File imageFile = File(photoFilePath);
        request.files.add(await http.MultipartFile.fromPath('photo', imageFile.path));
      } catch (e) {
        print('❗ Error reading image file: $e');
      }
    }

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        print('✅ Success: $responseData');
      } else {
        final errorData = await response.stream.bytesToString();
        print('❌ Failed with status: ${response.statusCode}');
        print('Response: $errorData');
      }
    } catch (e) {
      print('❗ Error sending request: $e');
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
