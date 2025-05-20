import 'dart:convert';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:myegym/data/api/api_client.dart';
import 'package:myegym/utils/app_constants.dart';

class TrainerRepo {
  final ApiClient apiClient;
  TrainerRepo({required this.apiClient});

  Future<Response> getTrainerRepo() async {
    return await apiClient.getData(AppConstants.trainerUrl, method: "GET");
  }

  Future<Response> getTrainerDetails({required String id}) async {
    return await apiClient.getData('${AppConstants.trainerUrl}/show/$id',
        method: "GET");
  }

  Future<Response> addTrainerRepo({
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
    return await apiClient.getData(
      '${AppConstants.trainerUrl}/store',
      method: "POST",
      body: {
        "full_name": fullName,
        "date_of_birth": dateOfBirth,
        "gender": gender,
        "phone_number": phoneNumber,
        "email_address": emailAddress,
        "address": address,
        "instaProfileLink": instaProfileLink,
        "facebookProfileLink": facebookProfileLink,
        "specializations": specializations, // 👈 Send as List<int>
        "qualification": qualification,
        "experienceinyear": experienceInYear,
        "password": password,
      },
    );
  }
}
