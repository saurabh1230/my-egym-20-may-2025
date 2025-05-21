import 'dart:convert';
import 'dart:math';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myegym/app/widgets/custom_snackbar.dart';
import 'package:myegym/app/widgets/loading_dialog.dart';
import 'package:myegym/controllers/auth_controller.dart';
import 'package:myegym/data/models/trainer_details_model.dart';
import 'package:myegym/data/models/trainer_model.dart';
import 'package:myegym/data/repo/trainer_repo.dart'; // For date formatting
import 'package:http/http.dart' as http;
import 'package:myegym/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrainerController extends GetxController {
  final TrainerRepo trainerRepo;

  TrainerController({required this.trainerRepo});
  final _currentMonth = DateTime(2024, 2).obs; // Observable current month
  final _revenueData = <DateTime, RevenueData>{}.obs; // Observable revenue data

  DateTime get currentMonth => _currentMonth.value;
  String get formattedMonth =>
      DateFormat('MMM yyyy').format(_currentMonth.value);
  RevenueData get currentMonthData =>
      _revenueData[_currentMonth.value] ?? RevenueData.empty();

  @override
  void onInit() {
    super.onInit();
    // Initialize with some dummy data
    _revenueData.addAll({
      DateTime(2024, 1): RevenueData(
          totalRevenue: 110000, salaryExpenses: 45000, memberships: 18000),
      DateTime(2024, 2): RevenueData(
          totalRevenue: 120000, salaryExpenses: 50000, memberships: 20000),
      DateTime(2024, 3): RevenueData(
          totalRevenue: 135000, salaryExpenses: 55000, memberships: 22000),
    });
    // In a real app, you might fetch initial data here
  }

  void goToPreviousMonth() {
    _currentMonth.value =
        DateTime(_currentMonth.value.year, _currentMonth.value.month - 1);
    // In a real app, fetch data for the new month
    // fetchRevenueData(_currentMonth.value);
  }

  void goToNextMonth() {
    _currentMonth.value =
        DateTime(_currentMonth.value.year, _currentMonth.value.month + 1);
    // In a real app, fetch data for the new month
    // fetchRevenueData(_currentMonth.value);
  }

  // Example function to simulate fetching revenue data
  Future<void> fetchRevenueData(DateTime month) async {
    // Simulate API call or database query
    await Future.delayed(const Duration(milliseconds: 300));
    final newData = RevenueData(
      totalRevenue: (100000 + Random().nextInt(50000)).toInt(),
      salaryExpenses: (40000 + Random().nextInt(20000)).toInt(),
      memberships: (15000 + Random().nextInt(10000)).toInt(),
    );
    _revenueData[month] = newData;
  }

  String formatAmount(int amount) {
    if (amount >= 100000) {
      return (amount / 100000).toStringAsFixed(1);
    } else if (amount >= 1000) {
      return (amount / 1000).toStringAsFixed(0);
    } else {
      return amount.toString();
    }
  }

  // TrainerMemberResponse? _trainerMemberResponse;
  // TrainerMemberResponse? get trainerMemberResponse => _trainerMemberResponse;

  // List<TrainerModel>? _trainerList;
  // List<TrainerModel>? get trainerList => _trainerList;
  Rx<dynamic> selectedTrainer = Rx<dynamic>({});
  // final Rx<TrainerModel?> selectedTrainer = Rx<TrainerModel?>(null);
  int _selectedTrainerId = 0;
  int get selectedTrainerId => _selectedTrainerId;

  void selectTrainerId(int val) {
    _selectedTrainerId = val;
    update();
  }

  // Future<void> getTrainerList() async {
  //   try {
  //     LoadingDialog.showLoading();
  //     update();

  //     print("🔥 Calling getTrainerList API...");
  //     Response response = await trainerRepo.getTrainerRepo();

  //     print("📥 Full response: ${response.bodyString}");
  //     print("📡 Status code: ${response.statusCode}");

  //     if (response.statusCode == 200) {
  //       var responseData = response.body;

  //       if (responseData["status"] == "success") {
  //         print("✅ API returned success");

  //         _trainerMemberResponse = TrainerMemberResponse.fromJson(responseData);

  //         _trainerList = _trainerMemberResponse?.trainer;
  //         selectedTrainer.value = _trainerList!.first;
  //         _selectedTrainerId = _trainerList!.first.userId;

  //         print("🎯 Parsed trainer list: ${_trainerMemberResponse?.trainer}");

  //         print("🎯 Parsed _trainerList lenght : ${_trainerList!.length}");
  //         print("👥 Parsed member list: ${_trainerMemberResponse?.members}");
  //       } else {
  //         print("⚠️ Response status is not success");
  //         showCustomSnackBar(
  //           Get.context!,
  //           responseData["message"] ?? 'Failed to fetch trainer list',
  //           isError: true,
  //         );
  //       }
  //     } else {
  //       print("❌ Non-200 response");
  //       var responseData = response.body;
  //       showCustomSnackBar(
  //         Get.context!,
  //         responseData["message"] ?? 'Error fetching trainer list',
  //         isError: true,
  //       );
  //     }
  //   } catch (e) {
  //     print("🚨 Exception: $e");
  //     showCustomSnackBar(Get.context!, 'Something went wrong: $e',
  //         isError: true);
  //   } finally {
  //     LoadingDialog.hideLoading();
  //     update();
  //   }
  // }

  List<dynamic>? _trainerList;
  List<dynamic>? get trainerList => _trainerList;

  Future<void> getTrainerList() async {
    try {
      LoadingDialog.showLoading();
      update();

      print("🔥 Calling getTrainerList API...");
      Response response = await trainerRepo.getTrainerRepo();

      print("📥 Full response: ${response.bodyString}");
      print("📡 Status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        var responseData = response.body;

        if (responseData["status"] == "success") {
          print("✅ API returned success");

          // Directly access 'data' as a List<dynamic>
          List<dynamic> trainerDataList = responseData["data"];

          if (trainerDataList.isNotEmpty) {
            var firstTrainer = trainerDataList[0]["trainer"];
            var firstMembers = trainerDataList[0]["members"];

            print("🎯 First trainer info: $firstTrainer");
            print("👥 First trainer's members: $firstMembers");

            // Example: directly accessing trainer name
            print("Trainer Name: ${firstTrainer["full_name"]}");

            // Directly handle the trainer info
            selectedTrainer.value =
                firstTrainer; // Rx<dynamic> now holds trainer data
            _selectedTrainerId = firstTrainer["user_id"];
          }

          print("🎯 Trainer List Length: ${trainerDataList.length}");
          _trainerList = trainerDataList; // Store the entire trainer list
        } else {
          print("⚠️ Response status is not success");
          showCustomSnackBar(
            Get.context!,
            responseData["message"] ?? 'Failed to fetch trainer list',
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

  // TrainerDetailsResponse? _trainerDetails;
  // TrainerDetailsResponse? get trainerDetails => _trainerDetails;

  //   Map<String, dynamic>? trainerDetails;

  // Future<TrainerDetailsResponse?> getTrainerDetails(
  //     {required String? id}) async {
  //   print('munchies details APi ================>');
  //   LoadingDialog.showLoading();
  //   trainerDetails = null;
  //   update();

  //   try {
  //     Response response = await trainerRepo.getTrainerDetails(id: id!);

  //     if (response.statusCode == 200) {
  //       final data = response.body;

  //       trainerDetails = TrainerDetailsResponse.fromJson(data);
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

  Map<String, dynamic>? _trainerDetails;
  Map<String, dynamic>? get trainerDetails => _trainerDetails;

  Future<Map<String, dynamic>?> getTrainerDetails({required String? id}) async {
    print('Fetching trainer details directly...');
    LoadingDialog.showLoading();
    _trainerDetails = null;
    update();

    try {
      Response response = await trainerRepo.getTrainerDetails(id: id!);

      if (response.statusCode == 200) {
        // Assign raw response data directly as a Map
        _trainerDetails = Map<String, dynamic>.from(response.body);
        print(
            " Data Sucess  _trainerDetails!.length: ${_trainerDetails!.length}");
        // _trainerDetails = response.body;
      } else {
        // Handle non-200 status codes
        print("Failed to load data getTrainerDetails: ${response.statusCode}");
      }
    } catch (e) {
      // Handle exceptions
      print("Exception occurred getTrainerDetails: $e");
    }

    LoadingDialog.hideLoading();
    update();
    return _trainerDetails;
  }

  Future<void> addTrainerApi({
    required String fullName,
    required String dateOfBirth,
    required String gender,
    required String phoneNumber,
    required String emailAddress,
    required String address,
    required String instaProfileLink,
    required String facebookProfileLink,
    required List<int> specializations,
    required String qualification,
    required String experienceInYear,
    required String password,
  }) async {
    LoadingDialog.showLoading();
    update();
    final url = Uri.parse('${AppConstants.baseUrl}trainer/store');
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(AppConstants.token);

    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    // Create the body as a Map<String, dynamic>
    final body = {
      'full_name': fullName,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'phone_number': phoneNumber,
      'email_address': emailAddress,
      'address': address,
      'instaProfileLink': instaProfileLink,
      'facebookProfileLink': facebookProfileLink,
      'specializations': specializations, // Send the list directly
      'qualification': qualification,
      'experienceinyear': experienceInYear,
      'password': password,
    };

    // Use http.post to send the request
    try {
      final response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      print('--- API REQUEST ---');
      print('URL: $url');
      print('Method: POST');
      print('Headers: $headers');
      print('Body: $body');

      // Check if the response status code is successful (200)
      if (response.statusCode == 200) {
        print('--- API RESPONSE ---');
        print('Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');

        LoadingDialog.showLoading();
        await getTrainerList(); // Call getTrainerList first
        Get.back();
        update();
      } else {
        print('--- API ERROR ---');
        print('Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        LoadingDialog.hideLoading();
        update();
      }
    } catch (e) {
      // Log any exceptions that occur during the request
      print('--- API ERROR ---');
      print('Exception: $e');
      LoadingDialog.hideLoading();
      update();
    } finally {
      LoadingDialog.hideLoading();
      update();
    }
  }


  Future<void> updateTrainer({
    required String trainerId,
    required String fullName,
    required String dateOfBirth,
    required String gender,
    required String phoneNumber,
    required String emailAddress,
    required String address,
    required String instaProfileLink,
    required String facebookProfileLink,
    required List<int> specializations,
    required String qualification,
    required String experienceInYear,
    required String password,
  }) async {
    final uri = Uri.parse('${AppConstants.baseUrl}${AppConstants.trainerUpdateUrl}/$trainerId');
    print("🔄 Sending Trainer Update to: $uri   Trainer id : $trainerId");

    var request = http.MultipartRequest('POST', uri);

    // Print all values before sending
    print("📝 Request Payload:");
    print("➡ full_name: $fullName");
    print("➡ date_of_birth: $dateOfBirth");
    print("➡ gender: $gender");
    print("➡ phone_number: $phoneNumber");
    print("➡ email_address: $emailAddress");
    print("➡ address: $address");
    print("➡ instaProfileLink: $instaProfileLink");
    print("➡ facebookProfileLink: $facebookProfileLink");
    print("➡ qualification: $qualification");
    print("➡ experienceinyear: $experienceInYear");
    print("➡ password: $password");

    request.fields['full_name'] = fullName;
    request.fields['date_of_birth'] = dateOfBirth;
    request.fields['gender'] = gender;
    request.fields['phone_number'] = phoneNumber;
    request.fields['email_address'] = emailAddress;
    request.fields['address'] = address;
    request.fields['instaProfileLink'] = instaProfileLink;
    request.fields['facebookProfileLink'] = facebookProfileLink;
    request.fields['qualification'] = qualification;
    request.fields['experienceinyear'] = experienceInYear;
    request.fields['password'] = password;

    for (int i = 0; i < specializations.length; i++) {
      request.fields['specializations[$i]'] = specializations[i].toString();
      print("➡ specializations[$i]: ${specializations[i]}");
    }

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
        await getTrainerList();
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

  Map<String, dynamic>? _trainerProfile;
  Map<String, dynamic>? get trainerProfile => _trainerProfile;

  Future<Map<String, dynamic>?> getTrainerProfile() async {
    print('Fetching getTrainerProfile directly...');
    LoadingDialog.showLoading();
    _trainerDetails = null;
    update();

    try {
      Response response = await trainerRepo.getTrainerProfile();

      if (response.statusCode == 200) {
        // Assign raw response data directly as a Map
        _trainerProfile = Map<String, dynamic>.from(response.body['data']);
        print(
            " Data Sucess  getTrainerProfile!.length: ${_trainerProfile!.length}");
        // _trainerDetails = response.body;
      } else {
        // Handle non-200 status codes
        print("Failed to load data getTrainerProfile: ${response.statusCode}");
      }
    } catch (e) {
      // Handle exceptions
      print("Exception occurred getTrainerProfile: $e");
    }

    LoadingDialog.hideLoading();
    update();
    return _trainerProfile;
  }

}

class RevenueData {
  final int totalRevenue;
  final int salaryExpenses;
  final int memberships;

  RevenueData({
    required this.totalRevenue,
    required this.salaryExpenses,
    required this.memberships,
  });

  factory RevenueData.empty() {
    return RevenueData(totalRevenue: 0, salaryExpenses: 0, memberships: 0);
  }
}
