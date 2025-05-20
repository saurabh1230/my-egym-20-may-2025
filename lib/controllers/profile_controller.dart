import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:myegym/app/widgets/custom_snackbar.dart';
import 'package:myegym/app/widgets/loading_dialog.dart';
import 'package:myegym/controllers/auth_controller.dart';
import 'package:myegym/data/models/member_model.dart';
import 'package:myegym/data/models/trainer_model.dart';
import 'package:myegym/data/repo/member_repo.dart';
import 'package:myegym/data/repo/profile_repo.dart';
import 'package:myegym/data/repo/trainer_repo.dart'; // For date formatting
import 'package:http/http.dart' as http;
import 'package:myegym/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http_parser/http_parser.dart';

import 'owner_controller.dart';

class ProfileController extends GetxController {
  final ProfileRepo profileRepo;

  ProfileController({required this.profileRepo});

  // TrainerModel? _trainerDetails;
  // TrainerModel? get trainerDetails => _trainerDetails;

  // Future<TrainerModel?> getTrainerDetails({required String? id}) async {
  //   print('munchies details APi ================>');
  //   LoadingDialog.showLoading();
  //   _trainerDetails = null;
  //   update();

  //   try {
  //     Response response = await profileRepo.getOwnerDetails();

  //     if (response.statusCode == 200) {
  //       final data = response.body['data'];

  //       _trainerDetails = TrainerModel.fromJson(data);
  //     } else {
  //       // Handle non-200 status codes
  //       print("Failed to load data getTrainerDetails : ${response.statusCode}");
  //       // ApiChecker.checkApi(response);
  //     }
  //   } catch (e) {
  //     // Handle exceptions
  //     print("Exception occurred getTrainerDetails: $e");
  //   }

  //   LoadingDialog.hideLoading();
  //   update();
  //   return _trainerDetails;
  // }


  Future<void> updateProfile({
    required String name,
    required String phone,
    required String email,
    File? profilePhoto,
  }) async {
    final uri = Uri.parse('${AppConstants.baseUrl}addowner');
    var request = http.MultipartRequest('POST', uri);

    LoadingDialog.showLoading();
    update();

    // Add fields
    request.fields['name'] = name;
    request.fields['phone_number'] = phone;
    request.fields['email'] = email;
    request.fields['password'] = name;


    // Add file if provided
    if (profilePhoto != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'profile',
          profilePhoto.path,
          filename: path.basename(profilePhoto.path),
        ),
      );
    }

    // Add headers
    request.headers.addAll({
      'Authorization': 'Bearer ${Get.find<AuthController>().getUserToken()}',
      'Accept': 'application/json',
    });

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        await Get.find<OwnerController>().getOwnerProfileApi();
        showCustomSnackBar(Get.context!, "Profile Updated Successfully",isError: false);
        Get.back(); // hide loader

      } else {
        print('Failed with status: ${response.statusCode}');
        print(await response.stream.bytesToString());
        Get.back(); // hide loader
      }
    } catch (e) {
      print('Exception during updateProfile: $e');
      Get.back(); // hide loader
    } finally {
      update();
    }
  }
}