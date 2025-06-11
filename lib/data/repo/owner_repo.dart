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

  Future<Response> getGymDetails() async {
    return await apiClient.getData(AppConstants.memberGymDetails, method: "GET");
  }


  Future<Response> getWorkoutActivityRepo() async {
    return await apiClient.getData(AppConstants.workOutActivity, method: "GET");
  }

  Future<Response> getWorkoutSubActivityRepo(String? activityId) async {
    return await apiClient.getData('${AppConstants.subworkOutActivity}?activity_id=$activityId', method: "GET");
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

  Future<Response> addPersonalTraining({
    required String memberId,
    required String trainerId,
    required String trainingGoals,
    required String trainingPlan,
    required String trainingFrequency,
    required String sessionDuration,
    required String trainingStartDate,
    required String trainingEndDate,
    required String paidAmount,
    required String dueAmount,
    required String discount,
    required String paymentMethod,

  }) {
    return apiClient.getData(
        AppConstants.addFoodUrl,
        body:  {
          'member_id': memberId,
          'trainer_id':trainerId,
          'training_goals': trainingGoals,
          'training_plan': trainingPlan,
          'training_frequency':trainingFrequency,
          'session_duration': sessionDuration,
          'training_start_date': trainingStartDate,
          'training_end_date': trainingEndDate,
          'paid_amount': paidAmount,
          'due_amount': dueAmount,
          'discount': discount,
          'payment_method': paymentMethod
        }
    );
  }

  Future<Response> getPersonalTrainingPlanRepo() async {
    return await apiClient.getData(AppConstants.personalTrainingPlanListingUrl, method: "GET");
  }



  Future<Response> addPersonalPlanRepo({
    required String trainingGoals,
    required String trainingPlanName,
    required String trainingFrequency,
    required String sessionDuration,
    required String trainingStartDate,
    required String trainingEndDate,
    required String paidAmount,
    required String dueAmount,
    required String discount,
    required String paymentMethod,
  }) {
    return apiClient.getData(
        AppConstants.addPersonalTrainerPlanUrl,
        body:  {
          'training_goals': trainingGoals,
          'training_plan': trainingPlanName,
          'training_frequency': trainingFrequency,
          'session_duration': sessionDuration,
          'training_start_date': trainingStartDate,
          'training_end_date': trainingEndDate,
          'paid_amount': paidAmount,
          'due_amount': dueAmount,
          'discount': dueAmount,
          'payment_method': paymentMethod
        }
    );
  }

  Future<Response> getPlanDuration() async {
    return await apiClient.getData(AppConstants.packageDurationUrl, method: "GET");
  }


  Future<Response> addPackageRepo({
    required String name,

  }) {
    return apiClient.getData(
        AppConstants.packageDurationStoreUrl,
        body:  {
          'name': name,
        }
    );
  }


  Future<Response> deletePackageDuration({
    required String id,

  }) {
    return apiClient.getData(
        "${AppConstants.packageDurationDeleteUrl}/$id",
      method: "DELETE"

    );
  }


  Future<Response> assignPersonalPlanRepo({
    required String memberId,
    required String trainerId,
    required String planId,
    required String workoutId,

  }) {
    return apiClient.getData(
        AppConstants.personalTrainingAssignUrl,
        body:  {
          'member_id': memberId,
          'trainer_id': trainerId,
          'plan_id': planId,
          'workout_id': workoutId
        }
    );
  }

  Future<Response> getOffersListing() async {
    return await apiClient.getData(AppConstants.getOffersUrl, method: "GET");
  }

  Future<Response> assignPersonalPlanUpdateRepo({
    required String id,
    required String memberId,
    required String trainerId,
    required String planId,
    required String workoutId,

  }) {
    return apiClient.getData(
        "${AppConstants.personalTrainingUpdateUrl}/$id",
        body:  {
          'member_id': memberId,
          'trainer_id': trainerId,
          'plan_id': planId,
          'workout_id': workoutId
        }
    );
  }

}
