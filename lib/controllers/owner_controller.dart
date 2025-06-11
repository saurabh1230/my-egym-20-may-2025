import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:myegym/app/widgets/custom_snackbar.dart';
import 'package:myegym/app/widgets/loading_dialog.dart';
import 'package:myegym/controllers/auth_controller.dart';
import 'package:myegym/controllers/member_controller.dart';
import 'package:myegym/controllers/plans_controller.dart';
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
      Response response = await ownerRepo.getGymDetails();

      if (response.statusCode == 200) {
        final data = response.body;
        if (data != null && data['status'] == 'success') {
          ownerProfileDetails = data; // <-- fix here
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

    // ➕ Add form fields
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

    // 🔁 Add 'days' list with nested subactivities
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

    // 📷 Attach photo if provided
    if (photoFilePath.isNotEmpty) {
      try {
        File imageFile = File(photoFilePath);
        request.files.add(await http.MultipartFile.fromPath('photo', imageFile.path));
      } catch (e) {
        print('❗ Error reading image file: $e');
      }
    }

    // 🧾 Print entire payload as raw JSON (for debugging)
    Map<String, dynamic> requestJson = {
      "activity_id": activitiesId,
      "start_date": startDate,
      "end_date": endDate,
      "notes": notes,
      "goals": goals,
      "level": level,
      "injury": "2",
      "time": time,
      "activitie": activitie,
      "subactivity": subactivity,
      "activities_id": activitiesId,
      "subactivity_id": subactivityId,
      "times": times,
      "session": session,
      "frequency": frequency,
      "days": days,
      "photo": photoFilePath.isNotEmpty ? photoFilePath : null,
    };

    print("📦 Raw JSON being sent:");
    print(jsonEncode(requestJson));

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        showCustomSnackBar(Get.context!, "Workout Added Successfully");
        Get.find<PlansController>().getWorkoutListing();
        Get.back();
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

        // Ensure 'activities' is a List
        List<dynamic> data = responseData["activities"] ?? [];

        if (data.isNotEmpty) {
          var firstItem = data[0];

          print("🎯 First getActivityList info: $firstItem");

          selectedActivity.value = firstItem;
          _selectedActivityId = firstItem["id"]; // ✅ store only the ID here
        }

        print("🎯 getActivityList List Length: ${data.length}");
        _activityList = data; // ✅ store entire activity list
      } else {
        print("❌ Non-200 response");
        var responseData = response.body;
        showCustomSnackBar(
          Get.context!,
          responseData["message"] ?? 'Error fetching activity list',
          isError: true,
        );
      }
    } catch (e) {
      print("🚨 Exception: $e");
      showCustomSnackBar(Get.context!, 'Something went wrong: $e', isError: true);
    } finally {
      LoadingDialog.hideLoading();
      update();
    }
  }

  // Future<void> getActivityList() async {
  //   try {
  //     LoadingDialog.showLoading();
  //     update();
  //
  //     print("🔥 Calling getActivityList API...");
  //     Response response = await ownerRepo.getWorkoutActivityRepo();
  //
  //     print("📥 Full response getActivityList: ${response.bodyString}");
  //     print("📡 Status code getActivityList: ${response.statusCode}");
  //
  //     if (response.statusCode == 200) {
  //       var responseData = response.body;
  //
  //       // Directly access 'data' as a List<dynamic>
  //       List<dynamic> data = responseData["activities"];
  //
  //       if (data.isNotEmpty) {
  //         var firstItem = data[0];
  //
  //         print("🎯 First getActivityList info: $firstItem");
  //
  //         selectedActivity.value = firstItem;
  //         _personalPlan = firstItem["id"];
  //       }
  //
  //       print("🎯 getActivityList List Length: ${data.length}");
  //       _activityList = data; // Store the entire trainer list
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

  Future<void> getSubActivityList({required String activityID}) async {
    try {
      LoadingDialog.showLoading();
      update();

      print("🔥 Calling getSubActivityList API...");
      Response response = await ownerRepo.getWorkoutSubActivityRepo(activityID);

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


  Rx<dynamic> selectedGoal = Rx<dynamic>({});
  // final Rx<TrainerModel?> selectedTrainer = Rx<TrainerModel?>(null);
  int _selectedGoalID = 0;


  int get selectedGoalID => _selectedGoalID;

  void selectGoalId(int val) {
    _selectedGoalID = val;
    update();
  }

  List<dynamic>? _workoutGoalList;
  List<dynamic>? get workoutGoalList => _workoutGoalList;

  Future<void> getWorkoutGoalApi() async {
    try {
      LoadingDialog.showLoading();
      update();

      print("🔥 Calling getWorkoutGoalApi API...");
      Response response = await ownerRepo.getWorkoutGoalRepo();

      print("📥 Full response getWorkoutGoalApi: ${response.bodyString}");
      print("📡 Status code getWorkoutGoalApi: ${response.statusCode}");

      if (response.statusCode == 200) {
        var responseData = response.body;

        // Directly access 'data' as a List<dynamic>
        List<dynamic> data = responseData["goals"];

        if (data.isNotEmpty) {
          var firstItem = data[0];

          print("🎯 First getWorkoutGoalApi info: $firstItem");

          selectedGoal.value = firstItem;
          _selectedGoalID = firstItem["id"];
        }

        print("🎯 getSubActivityList List Length: ${data.length}");
        _workoutGoalList = data; // Store the entire trainer list
      } else {
        print("❌ Non-200 response getWorkoutGoalApi");
        var responseData = response.body;
        showCustomSnackBar(
          Get.context!,
          responseData["message"] ?? 'Error fetching getWorkoutGoalApi',
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



  Future<void> addWorkoutGoal({String? name,}) async {
    print('Fetching addWorkoutGoal ================>');
    LoadingDialog.showLoading();

    try {
      Response response = await ownerRepo.addWorkoutGoal(name, "1");

      if (response.statusCode == 200) {

        showCustomSnackBar(Get.context!, "Goal Added Successfully");
        Get.back();
      } else {
        showCustomSnackBar(Get.context!, "Goal Added Successfully");
        Get.back();
        print("Failed to addWorkoutGoal: ${response.statusCode}");
      }
    } catch (e) {
      showCustomSnackBar(Get.context!, "Goal Added Successfully");
      Get.back();
      print("Exception occurred addWorkoutGoal: $e");
    }
    LoadingDialog.hideLoading();
    update();
  }

  List<dynamic>? _foodList;
  List<dynamic>? get foodList => _foodList;


  Rx<dynamic> selectedFood = Rx<dynamic>({});
  // final Rx<TrainerModel?> selectedTrainer = Rx<TrainerModel?>(null);
  int _selectedFoodID = 0;


  int get selectedFoodID => _selectedFoodID;

  void selectFoodId(int val) {
    _selectedFoodID = val;
    update();
  }


  Future<void> getFoodListingApi() async {
    try {
      // LoadingDialog.showLoading();
      // update();

      print("🔥 Calling getFoodListingApi API...");
      Response response = await ownerRepo.getFoodListingRepo();

      print("📥 Full response getFoodListingApi: ${response.bodyString}");
      print("📡 Status code getFoodListingApi: ${response.statusCode}");

      if (response.statusCode == 200) {
        var responseData = response.body;

        // Directly access 'data' as a List<dynamic>
        List<dynamic> data = responseData["foodItem"];

        if (data.isNotEmpty) {
          var firstItem = data[0];

          print("🎯 First getFoodListingApi info: $firstItem");

          selectedFood.value = firstItem;
          _selectedFoodID = firstItem["id"];
        }

        print("🎯 getFoodListingApi List Length: ${data.length}");
        _foodList = data; // Store the entire trainer list
      } else {
        print("❌ Non-200 response getFoodListingApi");
        var responseData = response.body;
        showCustomSnackBar(
          Get.context!,
          responseData["message"] ?? 'Error fetching getWorkoutGoalApi',
          isError: true,
        );
      }
    } catch (e) {
      print("🚨 Exception: $e");
      showCustomSnackBar(Get.context!, 'Something went wrong getSubActivityList: $e',
          isError: true);
    } finally {
      // LoadingDialog.hideLoading();
      // update();
    }
  }



  Future<dynamic> addDietPlanApi({
    required String planName,
    required String preference,
    required String lifestyle,
    required String supplementName,
    required String dose,
    required String time,
    required String remark,
    required String note,
    required String portionControl,
    required String healthyTips,
    required String exercise,
    required String unit,
    required String goal,
    required XFile? photo,
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
      Uri.parse('${AppConstants.baseUrl}${AppConstants.addDietPlanUrl}'),
    );

    request.fields.addAll({
      "plan_name": planName,
      "preference": preference,
      "lifestyle": lifestyle,
      "supplement_name": supplementName,
      "dose": dose,
      "time": time,
      "remark": remark,
      "note": note,
      "portion_control": portionControl,
      "healthy_tips": healthyTips,
      "exercise": exercise,
      "unit":unit,
      "goal": goal,
    });

    if (photo != null && photo.path.isNotEmpty) {
      var mimeType = photo.path.split('.').last; // e.g., jpg, png
      request.files.add(await http.MultipartFile.fromPath(
        'photo',
        photo.path,
        contentType: MediaType('image', mimeType), // Set the correct MIME type
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
        // await getMemberList(); // <-- First update the data

        Get.back();
        update();
        // Get.to(DashboardScreen(pageIndex: 0));

        return jsonDecode(responseBody);
      } else {
        var responseBody = await response.stream.bytesToString();
        print('Error: ${response.reasonPhrase}');
        print('Response Body: $responseBody');
        // await getMemberList(); // <-- First update the data

        Get.back();
        update();
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      // await getMemberList(); // <-- First update the data

      Get.back();
      update();
      return false;
    } finally {
      // Get.find<AuthController>().profileDetailsApi();
      LoadingDialog.hideLoading();
      update();
    }
  }



  Future<void> addFoodItem({required String foodName,
    required String protein,
    required String fats,
    required String carbohydrates,
    required String quantity,
    required String calorie,required String unit,
    required String note,
  }) async {
    print('Fetching addFoodItem ================>');
    LoadingDialog.showLoading();

    try {
      Response response = await ownerRepo.addFoodItem(
          foodName: foodName,
          protein: protein,
          fats: fats,
          carbohydrates: carbohydrates,
          quantity: quantity,
          calorie: calorie,
          unit: unit,
          note: note);

      if (response.statusCode == 200) {

        showCustomSnackBar(Get.context!, "Food Added Successfully");
        Get.back();
      } else {
        showCustomSnackBar(Get.context!, "Food Added Successfully");
        Get.back();
        print("Failed to addFoodItem: ${response.statusCode}");
      }
    } catch (e) {
      showCustomSnackBar(Get.context!, "Goal Added Successfully");
      Get.back();
      print("Exception occurred addFoodItem: $e");
    }
    LoadingDialog.hideLoading();
    update();
  }


  List<dynamic>? _mealPlanList;
  List<dynamic>? get mealPlanList => _mealPlanList;

  Future<void> getMealList() async {
    LoadingDialog.showLoading();
    try {
      Response response = await ownerRepo.getMealPlansApi();

      if (response.statusCode == 200) {
        final data = response.body;
        _mealPlanList = data['mealPlan'];
      } else {
        print(
            "Failed to load data getMealList: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception occurred getMealList: $e");
    }

    LoadingDialog.hideLoading();
    update();
  }




  Rx<dynamic> selectedPersonalPlan = Rx<dynamic>({});
  // final Rx<TrainerModel?> selectedTrainer = Rx<TrainerModel?>(null);
  int _selectedPersonalPlanId = 0;


  int get selectedPersonalPlanId => _selectedPersonalPlanId;

  void selectPersonalPlanId(int val) {
    _selectedPersonalPlanId = val;
    update();
  }

  List<dynamic>? _personalPlan;
  List<dynamic>? get personalPlan => _personalPlan;

  Future<void> getPersonalPlanList() async {
    try {
      LoadingDialog.showLoading();
      update();

      print("🔥 Calling _personalPlan API...");
      Response response = await ownerRepo.getPersonalTrainingPlanRepo();

      print("📥 Full response _personalPlan: ${response.bodyString}");
      print("📡 Status code _personalPlan: ${response.statusCode}");

      if (response.statusCode == 200) {
        var responseData = response.body;

        // Directly access 'data' as a List<dynamic>
        List<dynamic> data = responseData["data"];

        if (data.isNotEmpty) {
          var firstItem = data[0];

          print("🎯 First data _personalPlan: $firstItem");

          selectedPersonalPlan.value = firstItem;
          _selectedPersonalPlanId = firstItem["id"];
        }

        print("🎯 _personalPlan List Length: ${data.length}");
        _personalPlan = data; // Store the entire trainer list
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


  // Future<void> addPersonalTrainerPlan({
  //   required String trainingGoals,
  //   required String trainingPlanName,
  //   required String trainingFrequency,
  //   required String sessionDuration,
  //   required String trainingStartDate,
  //   required String trainingEndDate,
  //   required String paidAmount,
  //   required String dueAmount,
  //   required String discount,
  // }) async {
  //   print('Fetching addPersonalTrainerPlan ================>');
  //   LoadingDialog.showLoading();
  //
  //   // Prepare request body
  //   Map<String, dynamic> requestBody = {
  //     "training_goals": trainingGoals,
  //     "training_plan": trainingPlanName,
  //     "training_frequency": trainingFrequency,
  //     "session_duration": sessionDuration,
  //     "training_start_date": trainingStartDate,
  //     "training_end_date": trainingEndDate,
  //     "paid_amount": paidAmount,
  //     "due_amount": dueAmount,
  //     "discount": discount,
  //
  //   };
  //
  //   // Print request body as JSON
  //   print("Raw Request JSON addPersonalTrainerPlan : ${jsonEncode(requestBody)}");
  //
  //   try {
  //     Response response = await ownerRepo.addPersonalPlanRepo(
  //       trainingGoals: trainingGoals,
  //       trainingPlanName: trainingPlanName,
  //       trainingFrequency: trainingFrequency,
  //       sessionDuration: sessionDuration,
  //       trainingStartDate: trainingStartDate,
  //       trainingEndDate: trainingEndDate,
  //       paidAmount: paidAmount,
  //       dueAmount: dueAmount,
  //       discount: discount,
  //     );
  //
  //     await getPersonalPlanList();
  //     showCustomSnackBar(Get.context!, "Plan Created Successfully");
  //     Get.back();
  //   } catch (e) {
  //     showCustomSnackBar(Get.context!, "Plan Created Successfully");
  //     Get.back();
  //     print("Exception occurred Plan Created Successfully : $e");
  //   }
  //   LoadingDialog.hideLoading();
  //   update();
  // }


  // Future<void> addPersonalTrainerPlan({
  //   required String trainingGoals,
  //   required String trainingPlanName,
  //   required String trainingFrequency,
  //   required String sessionDuration,
  //   required String trainingStartDate,
  //   required String trainingEndDate,
  //   required String paidAmount,
  //   required String dueAmount,
  //   required String discount,
  // }) async {
  //   print('Fetching addPersonalTrainerPlan ================>');
  //   LoadingDialog.showLoading();
  //
  //   try {
  //     Response response = await ownerRepo.addPersonalPlanRepo(
  //         trainingGoals: trainingGoals,
  //         trainingPlanName: trainingPlanName,
  //         trainingFrequency: trainingFrequency,
  //         sessionDuration: sessionDuration,
  //         trainingStartDate: trainingStartDate,
  //         trainingEndDate: trainingEndDate,
  //         paidAmount: paidAmount,
  //         dueAmount: dueAmount,
  //         discount: discount
  //     );
  //
  //     if (response.statusCode == 201) {
  //       await getPersonalPlanList();
  //       showCustomSnackBar(Get.context!, "Plan Created Successfully");
  //       Get.back();
  //     } else {
  //       await getPersonalPlanList();
  //       showCustomSnackBar(Get.context!, "Plan Created Successfully");
  //       Get.back();
  //       print("Failed to Plan Created Successfully: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     showCustomSnackBar(Get.context!, "Plan Created Successfully");
  //     Get.back();
  //     print("Exception occurred Plan Created Successfully : $e");
  //   }
  //   LoadingDialog.hideLoading();
  //   update();
  // }



  Rx<dynamic> selectedPlanDuration = Rx<dynamic>({});
  // final Rx<TrainerModel?> selectedTrainer = Rx<TrainerModel?>(null);
  int _selectedPlanDurationID = 0;


  int get selectedPlanDurationID => _selectedPlanDurationID;

  void selectPlanDurationId(int val) {
    _selectedPlanDurationID = val;
    update();
  }

  List<dynamic>? _planDurationList;
  List<dynamic>? get planDurationList => _planDurationList;

  Future<void> getPlanDurationList() async {
    try {
      LoadingDialog.showLoading();
      update();

      print("🔥 Calling getPlanDurationList API...");
      Response response = await ownerRepo.getPlanDuration();

      print("📥 Full response getPlanDurationList: ${response.bodyString}");
      print("📡 Status code getPlanDurationList: ${response.statusCode}");

      if (response.statusCode == 200) {
        var responseData = response.body;


        List<dynamic> data = responseData["data"];
        if (data.isNotEmpty) {
          var firstItem = data[0];

          print("🎯 First getPlanDurationList info: $firstItem");

          selectedPlanDuration.value = firstItem;
          _selectedPlanDurationID = firstItem["id"];
        }


        _planDurationList = data;

      } else {
        print("❌ Non-200 response getPlanDurationList");
        var responseData = response.body;
        showCustomSnackBar(
          Get.context!,
          responseData["message"] ?? 'Error fetching getPlanDurationList',
          isError: true,
        );
      }
    } catch (e) {
      print("🚨 Exception: $e");
      showCustomSnackBar(Get.context!, 'Something went wrong getPlanDurationList: $e',
          isError: true);
    } finally {
      LoadingDialog.hideLoading();
      update();
    }
  }

  Future<void> addPersonalTrainerPlan({
    required String trainingGoals,
    required String trainingPlanName,
    required String trainingFrequency,
    required String sessionDuration,
    required String trainingStartDate,
    required String trainingEndDate,
    required String paidAmount,
    required String discount,
}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Get.find<AuthController>().getUserToken().toString()}'
    };

    var request = http.Request(
      'POST',
      Uri.parse('${AppConstants.baseUrl}${AppConstants.addPersonalTrainerPlanUrl}'),
    );

    request.body = json.encode({
      "training_goals": trainingGoals,
      "training_plan": trainingPlanName,
      "training_frequency": trainingFrequency,
      "session_duration": sessionDuration,
      "training_start_date": trainingStartDate,
      "training_end_date": trainingEndDate,
      "paid_amount": paidAmount,
      "due_amount":"0",
      "discount": discount,
      "payment_method": "online"
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      final responseData = await response.stream.bytesToString();
      final jsonData = jsonDecode(responseData);

      if (jsonData['status'] == 'success') {
        showCustomSnackBar(Get.context!, jsonData['message'] ?? "Plan Created Successfully");
        await getPersonalPlanList();
                Get.back();
        print(jsonData['message']); // e.g. "Personal Training Plan created successfully!"
      } else {
        print('Unexpected response format or status not success');
      }
    } else {
      print('Request failed: ${response.statusCode} - ${response.reasonPhrase}');
    }
  }

  Future<void> addPackageDuration({required String name}) async {
    print('➡️ Calling addPackageDuration...');
    LoadingDialog.showLoading();

    try {
      Response response = await ownerRepo.addPackageRepo(name: name);

      print("📥 Response Body: ${response.body}");
      print("📡 Status Code: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = response.body;
        if (body != null && body['status'] == 'success') {
          showCustomSnackBar(Get.context!, body['message'] ?? 'Package added!');
          await getPlanDurationList();
          Get.back();
        } else {
          showCustomSnackBar(Get.context!, 'Unexpected response.', isError: true);
        }
      } else {
        showCustomSnackBar(Get.context!, 'Failed with code ${response.statusCode}', isError: true);
      }
    } catch (e) {
      print("🔥 Exception occurred: $e");
      showCustomSnackBar(Get.context!, 'Network error occurred', isError: true);
    } finally {
      LoadingDialog.hideLoading();
      update();
    }
  }


  Future<void> deletePackageDuration({required String id}) async {
    print('➡️ Calling deletePackageDuration...');
    LoadingDialog.showLoading();
    update();

    try {
      Response response = await ownerRepo.deletePackageDuration(id: id);
      print("📥 Response Body: ${response.body}");
      print("📡 Status Code: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = response.body;
        if (body != null && body['status'] == 'success') {
          showCustomSnackBar(Get.context!, body['message'] ?? 'Package Deleted Successfully');
          await getPlanDurationList();
          Get.back();
        } else {

        }
      } else {
        print('Failed with code ${response.statusCode}');
      }
    } catch (e) {
      print("🔥 Exception occurred: $e");
      showCustomSnackBar(Get.context!, 'Network error occurred', isError: true);
    } finally {
      LoadingDialog.hideLoading();
      update();
    }
  }

  Future<void> assignPersonalTraining({
    required String memberId,
    required String trainerId,
    required String planId,
    required String workoutId,
  }) async {
    LoadingDialog.showLoading();
    update();

    var url = Uri.parse('${AppConstants.baseUrl}${AppConstants.personalTrainingAssignUrl}');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Get.find<AuthController>().getUserToken()}',
    };

    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({
      'member_id': memberId,
      'trainer_id': trainerId,
      'plan_id': planId,
      'workout_id': workoutId,
    });

    request.headers.addAll(headers);
    print('📤 Sending JSON body: ${jsonEncode(request.fields)}');

    try {
      http.StreamedResponse response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final decoded = json.decode(responseBody);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (decoded['status'] == 'success') {
          showCustomSnackBar(Get.context!, 'Assigned Successfully');
          Get.find<MemberController>().getMemberList();
          Get.back();
          print('✅ Success: ${decoded['message']}');
          print('📦 Data: ${decoded['data']}');
        } else {
          // Handle logical API error even on 200
          showCustomSnackBar(Get.context!, decoded['message'] ?? 'Something went wrong');
          print('❌ API Error: ${decoded['message']}');
        }
      } else {
        // ❗ Show error message for other HTTP status codes
        showCustomSnackBar(Get.context!, decoded['message'] ?? 'Failed with status ${response.statusCode}');
        print('❌ HTTP Error: ${response.statusCode}');
        print(responseBody);
      }
    } catch (e) {
      print('❌ Exception: $e');
      showCustomSnackBar(Get.context!, 'Something went wrong. Please try again.');
    } finally {
      LoadingDialog.hideLoading();
      update();
    }
  }


  Future<void> assignPersonalTrainingUpdate({
    required String id,
    required String memberId,
    required String trainerId,
    required String planId,
    required String workoutId,
  }) async {
    LoadingDialog.showLoading();
    update();

    var url = Uri.parse('${AppConstants.baseUrl}${AppConstants.personalTrainingUpdateUrl}/$id');
    print('Url:  ${AppConstants.baseUrl}${AppConstants.personalTrainingUpdateUrl}/$id');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Get.find<AuthController>().getUserToken()}',
    };

    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({

      'member_id': memberId,
      'trainer_id': trainerId,
      'plan_id': planId,
      'workout_id': workoutId,
    });

    request.headers.addAll(headers);
    print('📤 Sending JSON body: ${jsonEncode(request.fields)}');

    try {
      http.StreamedResponse response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final decoded = json.decode(responseBody);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (decoded['status'] == 'success') {
          showCustomSnackBar(Get.context!, 'Assigned Successfully');
          Get.find<MemberController>().getMemberList();
          Get.back();
          print('✅ Success: ${decoded['message']}');
          print('📦 Data: ${decoded['data']}');
        } else {
          // Handle logical API error even on 200
          showCustomSnackBar(Get.context!, decoded['message'] ?? 'Something went wrong');
          print('❌ API Error: ${decoded['message']}');
        }
      } else {
        // ❗ Show error message for other HTTP status codes
        showCustomSnackBar(Get.context!, decoded['message'] ?? 'Failed with status ${response.statusCode}');
        print('❌ HTTP Error: ${response.statusCode}');
        print(responseBody);
      }
    } catch (e) {
      print('❌ Exception: $e');
      showCustomSnackBar(Get.context!, 'Something went wrong. Please try again.');
    } finally {
      LoadingDialog.hideLoading();
      update();
    }
  }



  Future<void> assignWorkoutPlan({
    required String memberId,
    required String packageId,
    required String startDate,
    required String endDate,
    required String paidAmount,
    required String dueAmount,
    required String discount,
    required String admissionFees,
    required String paymentMethod,
    required String workoutId,
  }) async {
    LoadingDialog.showLoading();
    update();

    final uri = Uri.parse('${AppConstants.baseUrl}${AppConstants.assignWorkoutPlan}');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Get.find<AuthController>().getUserToken()}',
    };

    final request = http.MultipartRequest('POST', uri);
    request.fields.addAll({
      'member_id': memberId,
      'package_id': packageId,
      'workoutplan_start_date': startDate,
      'workoutplan_end_date': endDate,
      'paid_amount': paidAmount,
      'due_amount': dueAmount,
      'discount': discount,
      'admission_fees': admissionFees,
      'payment_method': paymentMethod,
      'workout_id': workoutId,
    });

    request.headers.addAll(headers);

    print('📤 Sending workout assignment request: ${jsonEncode(request.fields)}');

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print('📥 Response Status Code: ${response.statusCode}');
      print('📥 Response Body: $responseBody');

      Map<String, dynamic> decoded = {};
      try {
        decoded = jsonDecode(responseBody);
      } catch (e) {
        print('❗ JSON Decode Error: $e');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (decoded['status'] == 'success') {
          print("✅ Success: ${decoded['message']}");
          showCustomSnackBar(Get.context!, decoded['message'] ?? 'Workout plan assigned');
          Get.back();
          Get.back();
        } else {
          print("⚠️ API Error: ${decoded['message']}");
          showCustomSnackBar(Get.context!, decoded['message'] ?? 'Something went wrong');
        }
      } else {
        // ⛔ Always show error for non-success status codes
        final errorMsg = decoded['message'] ?? 'Server Error: ${response.statusCode}';
        print("❌ Server Error: $errorMsg");
        showCustomSnackBar(Get.context!, errorMsg);
      }
    } catch (e) {
      print("❗ Exception: $e");
      showCustomSnackBar(Get.context!, 'Something went wrong. Please try again.');
    } finally {
      LoadingDialog.hideLoading();
      update();
    }
  }



  Rx<dynamic> selectedOffer = Rx<dynamic>({});
  // final Rx<TrainerModel?> selectedTrainer = Rx<TrainerModel?>(null);
  int _selectedOfferID = 0;


  int get selectedOfferID => _selectedOfferID;

  void selectOfferId(int val) {
    _selectedOfferID = val;
    update();
  }

  List<dynamic>? _offerListing;
  List<dynamic>? get offerListing => _offerListing;

  Future<void> getOffersApi() async {
    try {
      LoadingDialog.showLoading();
      update();

      print("🔥 Calling getOffersApi API...");
      Response response = await ownerRepo.getOffersListing();

      print("📥 Full response: ${response.bodyString}");
      print("📡 Status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        var responseData = response.body;
        List<dynamic> data = responseData["NewsOffer"];

        if (data.isNotEmpty) {
          var firstItem = data[0];
          print("🎯 First getOffersApi info: $firstItem");

          selectedOffer.value = firstItem;
          _selectedOfferID = firstItem["id"]; // Store the ID if needed
        }

        print("🎯 getOffersApi List Length: ${data.length}");
        _offerListing = data; // ✅ Assigning the whole list here
      } else {
        print("❌ Non-200 response");
        var responseData = response.body;
        showCustomSnackBar(
          Get.context!,
          responseData["message"] ?? 'Error fetching getOffersApi',
          isError: true,
        );
      }
    } catch (e) {
      print("🚨 Exception: $e");
      showCustomSnackBar(Get.context!, 'Something went wrong: $e', isError: true);
    } finally {
      LoadingDialog.hideLoading();
      update();
    }
  }



  Future<dynamic> addOffersApi({
    required String title,
    required String description,
    required XFile? photo,

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
      Uri.parse('${AppConstants.baseUrl}${AppConstants.addOfferUrl}'),
    );

    request.fields.addAll({
      'title': title,
      'description': description
    });



    if (photo != null && photo.path.isNotEmpty) {
      var mimeType = photo.path.split('.').last; // e.g., jpg, png
      request.files.add(await http.MultipartFile.fromPath(
        'photo',
        photo.path,
        contentType: MediaType('image', mimeType), // Set the correct MIME type
      ));
    }

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      print('Request URL: ${request.url}');
      print('Request Method: ${request.method}');
      print('Request Headers: ${request.headers}');
      print('Request Fields: ${request.fields}');
      print('Request Files: ${request.files}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseBody = await response.stream.bytesToString();
        print('Response Body: $responseBody');
        await getOffersApi(); // <-- First update the data

        Get.back();
        update();
        // Get.to(DashboardScreen(pageIndex: 0));

        return jsonDecode(responseBody);
      } else {
        var responseBody = await response.stream.bytesToString();
        print('Error: ${response.reasonPhrase}');
        print('Response Body: $responseBody');
        await getOffersApi(); // <-- First update the data

        Get.back();
        update();
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      await getOffersApi(); // <-- First update the data

      Get.back();
      update();
      return false;
    } finally {
      // Get.find<AuthController>().profileDetailsApi();
      LoadingDialog.hideLoading();
      update();
    }
  }



}






