import 'dart:convert';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:myegym/data/api/api_client.dart';
import 'package:myegym/utils/app_constants.dart';

class PlanRepo {
  final ApiClient apiClient;
  PlanRepo({required this.apiClient});

  Future<Response> getPtPlanListing() async {
    return await apiClient.getData(AppConstants.personalTraining,
        method: "GET");
  }



  Future<Response> getWorkoutListing() async {
    return await apiClient.getData(AppConstants.workout, method: "GET");
  }

  Future<Response> getDietPlanListing() async {
    return await apiClient.getData(AppConstants.dietUrl, method: "GET");
  }

}
