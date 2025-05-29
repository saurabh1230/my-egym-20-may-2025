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

  Future<Response> getWorkoutGoalRepo() async {
    return await apiClient.getData(AppConstants.workoutGoalUrl, method: "GET");
  }

  Future<Response> addWorkoutGoal(name, status,) {
    return apiClient.getData(
        '${AppConstants.addWorkoutGoal}?name=$name&status=$status',
     );
  }

  Future<Response> getFoodListingRepo() async {
    return await apiClient.getData(AppConstants.foodListingUrl, method: "GET");
  }

  Future<Response> addFoodItem({
    required String foodName,
    required String protein,
    required String fats,
    required String carbohydrates,
    required String quantity,
    required String calorie,
    required String unit,
    required String note,
}) {
    return apiClient.getData(
      AppConstants.addFoodUrl,
      body:  {
        'food_name': foodName,
        'protein': protein,
        'fats': fats,
        'carbohydrates': carbohydrates,
        'quantity': quantity,
        'calorie': calorie,
        'unit': unit,
        'note': note
      }
    );
  }

  Future<Response> getMealPlansApi() async {
    return await apiClient.getData(AppConstants.getMealPlanUrl, method: "GET");
  }

}
