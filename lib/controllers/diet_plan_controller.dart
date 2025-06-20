// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:myegym/helper/constant/constant.dart';
//
// import '../data/models/month_model.dart';
// import '../data/models/week_model.dart';
// import 'auth_controller.dart';
//
// class DietPlanController extends GetxController {
//   final planNameController = TextEditingController();
//   final planPriceController = TextEditingController();
//   final planDescriptionController = TextEditingController();
//
//   var selectedMonth = 0.obs;
//   var durations = <MonthModel>[].obs;
//   var selectedDuration = Rxn<MonthModel>();
//   RxInt allowedMonthCount = 0.obs;
//   var weeks = <WeekModel>[].obs;
//
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchDurations();
//   }
//
//   Future<void> fetchDurations() async {
//     final url = Uri.parse(Constant.monthTypeUrl);
//     try {
//       final token = Get.find<AuthController>().getUserToken();
//       final response = await http.get(
//         url,
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Accept': 'application/json',
//         },
//       );
//
//       final data = jsonDecode(response.body);
//
//       if (response.statusCode == 200 && data['status'] == 'success') {
//         durations.value = List<MonthModel>.from(
//           data['data'].map((month) => MonthModel.fromJson(month)),
//         );
//         selectedDuration.value = durations.first;
//       } else {
//         Get.snackbar("Error", "Failed to load durations");
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Exception occurred: $e");
//     }
//   }
//
//
//   void submitPlan() {
//     final name = planNameController.text.trim();
//     final price = planPriceController.text.trim();
//     final desc = planDescriptionController.text.trim();
//
//     if (name.isEmpty || price.isEmpty || desc.isEmpty) {
//       Get.snackbar("Error", "Please fill all fields");
//       return;
//     }
//
//     Get.snackbar("Success", "Plan Added Successfully!");
//   }
//
//   Future<void> fetchWeeks(int month) async {
//     final url = Uri.parse("${Constant.weekTypeUrl}?month=$month");
//     try {
//       final token = Get.find<AuthController>().getUserToken();
//       final response = await http.get(
//         url,
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Accept': 'application/json',
//         },
//       );
//
//       final data = jsonDecode(response.body);
//
//       if (response.statusCode == 200 && data['status'] == 'success') {
//         weeks.value = List<WeekModel>.from(
//           data['data'].map((week) => WeekModel.fromJson(week)),
//         );
//       } else {
//         Get.snackbar("Error", "Failed to load weeks");
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Exception occurred: $e");
//     }
//   }
//
//   @override
//   void onClose() {
//     planNameController.dispose();
//     planPriceController.dispose();
//     planDescriptionController.dispose();
//     super.onClose();
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:myegym/helper/constant/constant.dart';

import '../data/models/month_model.dart';
import '../data/models/week_model.dart';
import 'auth_controller.dart';

class DietPlanController extends GetxController {
  final planNameController = TextEditingController();
  final planPriceController = TextEditingController();
  final planDescriptionController = TextEditingController();

  var selectedMonth = 0.obs;
  var durations = <MonthModel>[].obs;
  var selectedDuration = Rxn<MonthModel>();
  RxInt allowedMonthCount = 0.obs;
  var weeks = <WeekModel>[].obs;

  var allDishes = <String>[].obs;
  var filteredDishes = <String>[].obs;
  var mealTypes = <String>[].obs;
  var units = <String>[].obs;

  final foodController = ''.obs;

  var mealsData = <String, List<Map<String, dynamic>>>{}.obs;
  // var mealsData = <String, Map<String, dynamic>>{}.obs;


  @override
  void onInit() {
    super.onInit();
    fetchDurations();
    fetchMealTypes();
    fetchFoodItems();
    fetchUnits();
    ever(foodController, filterDishes);
  }

  void saveMeal({
    required int monthId,
    required int weekId,
    required String dayName,
    required Map<String, dynamic> mealData,
  }) {
    final key = "${monthId}_${weekId}_$dayName";

    if (!mealsData.containsKey(key)) {
      mealsData[key] = [];
    }

    mealsData[key]!.add(mealData);
  }
  void copyMondayToTuesday(int monthId, int weekId) {
    final mondayKey = '${monthId}_${weekId}_Monday';
    final tuesdayKey = '${monthId}_${weekId}_Tuesday';

    final mondayMeals = mealsData[mondayKey];
    if (mondayMeals != null && mondayMeals.isNotEmpty) {
      // Deep copy to prevent reference issues
      mealsData[tuesdayKey] = mondayMeals.map((meal) => Map<String, dynamic>.from(meal)).toList();
    } else {
      mealsData[tuesdayKey] = [];
    }
  }


  // void saveMeal({
  //   required int monthId,
  //   required int weekId,
  //   required String dayName,
  //   required Map<String, dynamic> mealData,
  // }) {
  //   final key = "${monthId}_${weekId}_$dayName";
  //   mealsData[key] = mealData;
  //   print("Saved meal for $key: ${mealsData[key]}");
  // }

  Future<void> fetchDurations() async {
    final url = Uri.parse(Constant.monthTypeUrl);
    try {
      final token = Get.find<AuthController>().getUserToken();
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == 'success') {
        durations.value = List<MonthModel>.from(
          data['data'].map((month) => MonthModel.fromJson(month)),
        );
        selectedDuration.value = durations.first;
      } else {
        Get.snackbar("Error", "Failed to load durations");
      }
    } catch (e) {
      Get.snackbar("Error", "Exception occurred: $e");
    }
  }

  void submitPlan() {
    final name = planNameController.text.trim();
    final price = planPriceController.text.trim();
    final desc = planDescriptionController.text.trim();

    if (name.isEmpty || price.isEmpty || desc.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    Get.snackbar("Success", "Plan Added Successfully!");
  }

  Future<void> fetchWeeks(int month) async {
    final url = Uri.parse("${Constant.weekTypeUrl}?month=$month");
    try {
      final token = Get.find<AuthController>().getUserToken();
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == 'success') {
        weeks.value = List<WeekModel>.from(
          data['data'].map((week) => WeekModel.fromJson(week)),
        );
      } else {
        Get.snackbar("Error", "Failed to load weeks");
      }
    } catch (e) {
      Get.snackbar("Error", "Exception occurred: $e");
    }
  }

  void fetchFoodItems() async {
    const String apiUrl = Constant.foodItemUrl;

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer ${Get.find<AuthController>().getUserToken()}',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List items = data['foodItem'] ?? [];

        allDishes.value = items.map<String>((item) => item['name'].toString()).toList();
        filteredDishes.value = allDishes;
      } else {
        throw Exception("Failed to load food");
      }
    } catch (e) {
      print("Error fetching food items: $e");
    }
  }

  void filterDishes(String query) {
    if (query.isEmpty) {
      filteredDishes.value = allDishes;
    } else {
      filteredDishes.value = allDishes
          .where((dish) => dish.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void fetchMealTypes() async {
    try {
      final response = await http.get(
        Uri.parse(Constant.mealTypeUrl),
        headers: {
          'Authorization': 'Bearer ${Get.find<AuthController>().getUserToken()}',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List items = data['data'] ?? [];

        mealTypes.value = items.map<String>((item) => item['name'].toString()).toList();
      } else {
        throw Exception("Failed to load meal types");
      }
    } catch (e) {
      print("Error fetching meal types: $e");
    }
  }

  void fetchUnits() async {
    const String unitsUrl = Constant.unitTypeUrl;

    try {
      final response = await http.get(
        Uri.parse(unitsUrl),
        headers: {
          'Authorization': 'Bearer ${Get.find<AuthController>().getUserToken()}',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List unitList = data['data'] ?? [];

        units.value = unitList.map<String>((unit) => unit['name'].toString()).toList();
      } else {
        throw Exception('Failed to load units');
      }
    } catch (e) {
      print('Error fetching units: $e');
    }
  }

  void clearFoodController() {
    foodController.value = '';
    filteredDishes.clear();
  }

  @override
  void onClose() {
    planNameController.dispose();
    planPriceController.dispose();
    planDescriptionController.dispose();
    super.onClose();
  }
}
