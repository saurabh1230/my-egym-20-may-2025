import 'dart:convert';
import 'dart:math';

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
import 'package:myegym/data/repo/trainer_repo.dart'; // For date formatting
import 'package:http/http.dart' as http;
import 'package:myegym/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http_parser/http_parser.dart';

class MemberController extends GetxController {
  final MemberRepo memberRepo;

  MemberController({required this.memberRepo});


  Rx<dynamic> selectedMember = Rx<dynamic>({});
  // final Rx<TrainerModel?> selectedTrainer = Rx<TrainerModel?>(null);
  int _selectedMemberID = 0;


  int get selectedMemberID => _selectedMemberID;

  void selectMemberId(int val) {
    _selectedMemberID = val;
    update();
  }


  List<dynamic>? _memberList;
  List<dynamic>? get memberList => _memberList;

  Future<void> getMemberList() async {
    try {
      LoadingDialog.showLoading();
      update();

      print("🔥 Calling getMemberList API...");
      Response response = await memberRepo.getMemberRepo();

      print("📥 Full response: ${response.bodyString}");
      print("📡 Status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        var responseData = response.body;

        if (responseData["status"] == "success") {
          print("✅ API returned success");

          // Directly access 'data' as a List<dynamic>
          List<dynamic> trainerDataList = responseData["data"];
          if (trainerDataList.isNotEmpty) {
            var firstItem = trainerDataList[0];

            print("🎯 First getMemberList info: $firstItem");

            selectedMember.value = firstItem;
            _selectedMemberID = firstItem["id"];
          }

          print("🎯 getMemberList List Length: ${trainerDataList.length}");

          print("🎯 getMemberList List Length: ${trainerDataList.length}");
          _memberList = trainerDataList; // Store the entire trainer list
        } else {
          print("⚠️ Response status is not success");
          showCustomSnackBar(
            Get.context!,
            responseData["message"] ?? 'Failed to fetch getMemberList list',
            isError: true,
          );
        }
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

  Map<String, dynamic>? _memberDetails;
  Map<String, dynamic>? get memberDetails => _memberDetails;

  Future<void> getMemberDetails({required String id}) async {
    print('Fetching Owner Dashboard Details ================>');
    LoadingDialog.showLoading();

    try {
      Response response = await memberRepo.getMemberDetails(id: id);

      if (response.statusCode == 200) {
        final data = response.body;
        if (data != null && data['status'] == 'success') {
          _memberDetails = data['data'];
          print('Dashboard Details: _memberDetails');
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

  Future<dynamic> addMemberApi({
    required String fullName,
    required String dateOfBirth,
    required String gender,
    required String phoneNumber,
    required String emailAddress,
    required String address,
    required String trainerId,
    required String zipCode,
    required String emergencyContactName,
    required String emergencyContactPhone,
    required String contactRelationship,
    required String relationship,
    required String password,
    required XFile? photo,
    required XFile? identityproof,
     bool? isAddedByTrainer = false,
  }) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(AppConstants.token);
    LoadingDialog.showLoading();
    update();

    if (token == null || token.isEmpty) {
      print('Token is null or empty');
      LoadingDialog.hideLoading();
      update();
      return false;
    }

    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };

    var request = http.MultipartRequest(
      'POST', // Ensure PATCH method is what your API requires
      Uri.parse('${AppConstants.baseUrl}members/store'),
    );

    request.fields.addAll({
      'full_name': fullName,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'phone_number': phoneNumber,
      'email_address': emailAddress,
      'address': address,
      // 'trainer_id': trainerId,
      'password': password,
      'zip_code': zipCode,
      'emergency_contact_name': emergencyContactName,
      'emergency_contact_phone': emergencyContactPhone,
      'emergency_contact_relationship': contactRelationship,
      'relationship': relationship,
    });

    if (isAddedByTrainer == false) {
      request.fields['trainer_id'] = trainerId;
    }


    if (photo != null && photo.path.isNotEmpty) {
      var mimeType = photo.path.split('.').last; // e.g., jpg, png
      request.files.add(await http.MultipartFile.fromPath(
        'photo',
        photo.path,
        contentType: MediaType('image', mimeType), // Set the correct MIME type
      ));
    }

    if (identityproof != null && identityproof.path.isNotEmpty) {
      var mimeType = identityproof.path.split('.').last;
      request.files.add(await http.MultipartFile.fromPath(
        'identity_proof',
        identityproof.path,
        contentType: MediaType('image', mimeType),
      ));
    }

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      // Print the request details for debugging
      print('Request URL: ${request.url}');
      print('Request Method: ${request.method}');
      print('Request Headers: ${request.headers}');
      print('Request Fields: ${request.fields}');
      print('Request Files: ${request.files}');

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        print('Response Body: $responseBody');
        await getMemberList(); // <-- First update the data

        Get.back();
        update();
        // Get.to(DashboardScreen(pageIndex: 0));

        return jsonDecode(responseBody);
      } else {
        var responseBody = await response.stream.bytesToString();
        print('Error: ${response.reasonPhrase}');
        print('Response Body: $responseBody');
        await getMemberList(); // <-- First update the data

        Get.back();
        update();
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      await getMemberList(); // <-- First update the data

      Get.back();
      update();
      return false;
    } finally {
      // Get.find<AuthController>().profileDetailsApi();
      LoadingDialog.hideLoading();
      update();
    }
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> deleteMemberApi({required String id}) async {
    LoadingDialog.showLoading();
    update();
    try {
      Response response = await memberRepo.memberDeleteRepo(id);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.body;
        if (responseData['status'] == true) {
          showCustomSnackBar(Get.context!, responseData['message']);
          LoadingDialog.hideLoading();
          getMemberList();
          Get.back();
          update();
        }
      } else {
        LoadingDialog.hideLoading();
        getMemberList();
        Get.back();
        update();
        // Handle error if status code is not 200
      }
    } catch (error) {
      LoadingDialog.hideLoading();
      print("Error while deleting property: $error");
    } finally {
      LoadingDialog.hideLoading();
      getMemberList();
      Get.back();
      update();
    }

    _isLoading = false;
    update();
  }




  Future<void> updateMember({
    required String memberID,
    required String fullName,
    required String dateOfBirth,
    required String gender,
    required String phoneNumber,
    required String emailAddress,
    required String address,
    required String emergencyContactName,
    required String emergencyContactPhone,
    required String contactRelationship,
    required String relationship,
    required String password,
  }) async {
    final uri = Uri.parse('${AppConstants.baseUrl}${AppConstants.membersUpdateUrl}/$memberID');
    print("🔄 Sending Trainer Update to: $uri   Trainer id : $memberID");

    var request = http.MultipartRequest('POST', uri);



    request.fields['full_name'] = fullName;
    request.fields['date_of_birth'] = dateOfBirth;
    request.fields['gender'] = gender;
    request.fields['phone_number'] = phoneNumber;
    request.fields['email_address'] = emailAddress;
    request.fields['address'] = address;
    request.fields['emergency_contact_name'] = emergencyContactName;
    request.fields['emergency_contact_phone'] = emergencyContactPhone;
    request.fields['emergency_contact_relationship'] = relationship;
    request.fields['relationship'] = password;


    // Set headers
    final token = Get.find<AuthController>().getUserToken();
    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    print('TOKEN : ${token}');
    print("🛡 Headers:");
    request.headers.forEach((key, value) {
      print("➡ $key: $value");
    });

    LoadingDialog.showLoading();

    try {
      http.StreamedResponse response = await request.send();

      // Print response code
      print("📡 Response Status: ${response.statusCode}");

      // Convert stream to string
      final responseData = await response.stream.bytesToString();

      // Log the full response
      print("📦 Response Body: $responseData");

      if (response.statusCode == 200) {
        showCustomSnackBar(Get.context!, "Trainer Updated Successfully");
        // await getTrainerList();
        Get.back(); // Hide loader
        Get.back();
        Get.back();

      } else {
        Get.back(); // Hide loader
        showCustomSnackBar(Get.context!, "Error: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Exception during updateTrainer: $e");
      Get.back(); // Hide loader
      showCustomSnackBar(Get.context!, "Something went wrong");
    } finally {
      update();
    }
  }

}
