import 'dart:convert';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:myegym/data/api/api_client.dart';
import 'package:myegym/utils/app_constants.dart';

class OwnerRepo {
  final ApiClient apiClient;
  OwnerRepo({required this.apiClient});

  Future<Response> getOwnerDashboardDetails() async {
    return await apiClient.getData(AppConstants.ownerDashboardDetailUrl,
        method: "GET");
  }

  Future<Response> getOwnerProfileDetails() async {
    return await apiClient.getData(AppConstants.ownerprofileUrl, method: "GET");
  }


  Future<Response> getWorkoutActivityRepo() async {
    return await apiClient.getData(AppConstants.workOutActivity, method: "GET");
  }

  Future<Response> getWorkoutSubActivityRepo() async {
    return await apiClient.getData(AppConstants.subworkOutActivity, method: "GET");
  }
}
