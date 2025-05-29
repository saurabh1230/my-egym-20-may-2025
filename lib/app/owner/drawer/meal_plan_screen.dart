import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myegym/app/widgets/custom_app.dart';
import 'package:myegym/app/widgets/custom_button.dart';
import 'package:myegym/controllers/owner_controller.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import '../../../data/repo/owner_repo.dart';
import '../widgets/add_meal_plan.dart';

class MealPlanScreen extends StatelessWidget {
  const MealPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => OwnerRepo(apiClient: Get.find()));
    Get.lazyPut(() => OwnerController(ownerRepo: Get.find()));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<OwnerController>().getMealList();
    });

    return Scaffold(
      appBar: CustomAppBar(
        title: "Meal Plans",
        isBackButtonExist: true,
        isHideNotification: true,
      ),
      body: GetBuilder<OwnerController>(builder: (controller) {
        final mealPlans = controller.mealPlanList;

        if (mealPlans == null || mealPlans.isEmpty) {
          return const Center(child: Text("No meal plans available."));
        }

        return Stack(
          children: [
            SizedBox(height: Get.size.height,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: mealPlans.length,
                itemBuilder: (context, index) {
                  final meal = mealPlans[index];
                  final food = meal['food'];

                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Meal Time & Food Name
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Meal Time: ${meal['meal_time']}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                food['food_name'] ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          /// Quantity & Unit
                          Row(
                            children: [
                              Text("Quantity: ${meal['quantity']}"),
                              const SizedBox(width: 10),
                              Text("Unit: ${food['unit'] ?? 'N/A'}"),
                            ],
                          ),

                          /// Nutritional Info
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(child: Text("Protein: ${food['protein']}g")),
                              Flexible(child: Text("Fats: ${food['fats']}g")),
                              Flexible(child: Text("Carbs: ${food['carbohydrates']}g")),
                              Flexible(child: Text("Calories: ${food['calorie']}")),
                            ],
                          ),

                         sizedBox10(),
                          if (food['notes'] != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "Recipe: ${food['notes']}",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: Dimensions.paddingSizeDefault,
              left: Dimensions.paddingSizeDefault,
              right: Dimensions.paddingSizeDefault,
              child: CustomButtonWidget(buttonText: "Add Meals",
              onPressed: () {
                Get.to(() => AddMealPlan());


              },),
            )
          ],
        );
      }),
    );
  }
}
