// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:myegym/app/widgets/custom_app.dart';
// import 'package:myegym/controllers/member_controller.dart';
// import 'package:myegym/controllers/owner_controller.dart';
// import 'package:myegym/controllers/plans_controller.dart';
// import 'package:myegym/data/repo/member_repo.dart';
// import 'package:myegym/helper/validations.dart';
// import 'package:myegym/utils/dimensions.dart';
// import 'package:myegym/utils/sizeboxes.dart';
//
// import '../../../data/repo/owner_repo.dart';
// import '../../../data/repo/plan_repo.dart';
// import '../../widgets/underline_textfield.dart';
//
// class AddMealPlan extends StatelessWidget {
//    AddMealPlan({super.key});
//  final _quantityController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     Get.lazyPut(() => OwnerRepo(apiClient: Get.find()));
//     Get.lazyPut(() => OwnerController(ownerRepo: Get.find()));
//     Get.lazyPut(() => MemberRepo(apiClient: Get.find()));
//     Get.lazyPut(() => MemberController(memberRepo: Get.find()));
//     Get.lazyPut(() => PlanRepo(apiClient: Get.find()));
//     Get.lazyPut(() => PlansController(planRepo: Get.find()));
//     final RxString time = 'Morning'.obs;
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Get.find<MemberController>().getMemberList();
//       Get.find<PlansController>().getDietPlan();
//     });
//
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: CustomAppBar(title: "Add Meal Plan",isBackButtonExist: true,),
//       body: SingleChildScrollView(
//         child: GetBuilder<MemberController>(builder: (ownerControl) {
//           return  GetBuilder<PlansController>(builder: (dietPlan) {
//             return GetBuilder<OwnerController>(builder: (control) {
//               return   Padding(
//                 padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
//                 child: Column(
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Time',
//                             style: TextStyle(
//                                 fontSize: 12.0,
//                                 color: Colors.grey[600])),
//                         Obx(() => DropdownButtonFormField<String>(
//                           decoration: InputDecoration(
//                               border: UnderlineInputBorder()),
//                           value: time.value,
//                           items: ['Morning', 'Afternoon','Night'].map((value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value),
//                             );
//                           }).toList(),
//                           onChanged: (newValue) =>
//                           time.value = newValue ?? 'Morning',
//
//
//                         )),
//                       ],
//                     ),
//                     Obx(() => DropdownButtonFormField<Map<String, dynamic>>(
//                           decoration: const InputDecoration(
//                             border: UnderlineInputBorder(),
//                           ),
//                           value: ownerControl
//                               .selectedMember.value.isNotEmpty
//                               ? ownerControl.selectedMember.value
//                               : null, // Ensure it's a valid Map<String, dynamic> or null
//                           items: (ownerControl.memberList ?? [])
//                               .map((trainerData) {
//                             return DropdownMenuItem<
//                                 Map<String, dynamic>>(
//                               // Use Map<String, dynamic> as value type
//                               value:
//                               trainerData, // Assign the 'trainer' map to the value
//                               child: Text(
//                                   trainerData?["full_name"] ?? "N/A"),
//                             );
//                           }).toList(),
//                           onChanged: (newValue) {
//                             ownerControl.selectedMember.value =
//                                 newValue ??
//                                     {}; // Store raw data directly
//                             ownerControl.selectMemberId(newValue?[
//                             "id"]); // Access data directly as map
//
//                             print(ownerControl.selectedMemberID);
//                           },
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please select an Member';
//                             }
//                             return null;
//                           },
//                         )),
//                     sizedBoxDefault(),
//                     Obx(() =>
//                         DropdownButtonFormField<Map<String, dynamic>>(
//                           decoration: const InputDecoration(
//                             border: UnderlineInputBorder(),
//                           ),
//                           value: dietPlan
//                               .selectedDietPlan.value.isNotEmpty
//                               ? dietPlan.selectedDietPlan.value
//                               : null, // Ensure it's a valid Map<String, dynamic> or null
//                           items: (dietPlan.dietPlanListing ?? [])
//                               .map((trainerData) {
//                             return DropdownMenuItem<
//                                 Map<String, dynamic>>(
//                               // Use Map<String, dynamic> as value type
//                               value:
//                               trainerData, // Assign the 'trainer' map to the value
//                               child: Text(
//                                   trainerData?["plan_name"].toString() ?? "N/A"),
//                             );
//                           }).toList(),
//                           onChanged: (newValue) {
//                             dietPlan.selectedDietPlan.value =
//                                 newValue ??
//                                     {}; // Store raw data directly
//                             dietPlan.selectDietPlanId(newValue?[
//                             "id"]); // Access data directly as map
//
//                             print(dietPlan.selectedDietPlanId);
//                           },
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please select an Diet Plan';
//                             }
//                             return null;
//                           },
//                         )),
//                     sizedBoxDefault(),
//                     Obx(() =>
//                         DropdownButtonFormField<Map<String, dynamic>>(
//                           decoration: const InputDecoration(
//                             border: UnderlineInputBorder(),
//                           ),
//                           value: control.selectedFood.value.isNotEmpty
//                               ? control.selectedFood.value
//                               : null, // Ensure it's a valid Map<String, dynamic> or null
//                           items: (control.foodList ?? [])
//                               .map((trainerData) {
//                             return DropdownMenuItem<
//                                 Map<String, dynamic>>(
//                               // Use Map<String, dynamic> as value type
//                               value:
//                               trainerData, // Assign the 'trainer' map to the value
//                               child: Text(
//                                   trainerData?["food_name"].toString() ?? "N/A"),
//                             );
//                           }).toList(),
//                           onChanged: (newValue) {
//                             control.selectedFood.value =
//                                 newValue ??
//                                     {};
//                             control.selectFoodId(newValue?[
//                             "id"]);
//
//                             print(control.selectedFoodID);
//                           },
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please select an Diet Plan';
//                             }
//                             return null;
//                           },
//                         )),
//                     sizedBoxDefault(),
//                     UnderlineTextfield(
//                       controller: _quantityController,
//                       label: 'Quantity',
//                       hint: 'Portions',
//                       validation: Validators.validate,
//                     ), sizedBoxDefault(),
//                   ],
//                 ),
//               );
//             });
//           });
//         })
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myegym/app/widgets/custom_app.dart';
import 'package:myegym/app/widgets/custom_button.dart';
import 'package:myegym/controllers/member_controller.dart';
import 'package:myegym/controllers/owner_controller.dart';
import 'package:myegym/controllers/plans_controller.dart';
import 'package:myegym/data/repo/member_repo.dart';
import 'package:myegym/data/repo/owner_repo.dart';
import 'package:myegym/data/repo/plan_repo.dart';
import 'package:myegym/helper/validations.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/app/widgets/underline_textfield.dart';

import '../../../utils/styles.dart';

class AddMealPlan extends StatelessWidget {
  AddMealPlan({super.key});

  final _quantityController = TextEditingController();
  final RxString time = 'Morning'.obs;

  final RxList<Map<String, dynamic>> mealPlanData = <Map<String, dynamic>>[].obs;
  final RxList<int> selectedFoodIds = <int>[].obs;
  final RxList<int> selectedQuantities = <int>[].obs;
  final _formKey = GlobalKey<FormState>();
  int getMealTimeId(String value) {
    switch (value) {
      case 'Morning':
        return 1;
      case 'Afternoon':
        return 2;
      case 'Night':
        return 3;
      default:
        return 1;
    }
  }

  void addMealItem(MemberController memberController, PlansController planController, OwnerController ownerController) {
    final memberId = memberController.selectedMemberID;
    final planId = planController.selectedDietPlanId;
    final foodId = ownerController.selectedFoodID;
    final quantity = int.tryParse(_quantityController.text);

    if (memberId == null || planId == null || foodId == null || quantity == null) {
      Get.snackbar("Error", "Please complete all selections before adding");
      return;
    }

    selectedFoodIds.add(foodId);
    selectedQuantities.add(quantity);

    _quantityController.clear();
  }

  void finalizeMeal(MemberController memberController, PlansController planController) {
    final memberId = memberController.selectedMemberID;
    final planId = planController.selectedDietPlanId;
    final mealTime = getMealTimeId(time.value);

    if (selectedFoodIds.isEmpty || selectedQuantities.isEmpty) {
      // Get.snackbar("Error", "Please add at least one food item");
      return;
    }

    final meal = {
      "plan_id": planId,
      "food_id": selectedFoodIds.toList(),
      "quantity": selectedQuantities.toList(),
    };

    final existingEntry = mealPlanData.firstWhereOrNull(
          (e) => e["member_id"] == memberId && e["meal_time"] == mealTime,
    );

    if (existingEntry != null) {
      existingEntry["meals"].add(meal);
    } else {
      mealPlanData.add({
        "member_id": memberId,
        "meal_time": mealTime,
        "meals": [meal]
      });
    }

    selectedFoodIds.clear();
    selectedQuantities.clear();
    Get.find<PlansController>().addMealPlan(mealPlans: mealPlanData);
    Get.snackbar("Success", "Meal added to plan");
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => OwnerRepo(apiClient: Get.find()));
    Get.lazyPut(() => OwnerController(ownerRepo: Get.find()));
    Get.lazyPut(() => MemberRepo(apiClient: Get.find()));
    Get.lazyPut(() => MemberController(memberRepo: Get.find()));
    Get.lazyPut(() => PlanRepo(apiClient: Get.find()));
    Get.lazyPut(() => PlansController(planRepo: Get.find()));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<MemberController>().getMemberList();
      Get.find<PlansController>().getDietPlan();
      Get.find<OwnerController>().getFoodListingApi();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Add Meal Plan", isBackButtonExist: true),
      body: Form(key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: GetBuilder<MemberController>(
            builder: (memberController) {
              return GetBuilder<PlansController>(
                builder: (planController) {
                  return GetBuilder<OwnerController>(
                    builder: (ownerController) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Meal Time Dropdown
                          Text('Time', style: TextStyle(fontSize: 12.0, color: Colors.grey[600])),
                          Obx(() => DropdownButtonFormField<String>(
                            decoration: const InputDecoration(border: UnderlineInputBorder()),
                            value: time.value,
                            items: ['Morning', 'Afternoon', 'Night']
                                .map((value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ))
                                .toList(),
                            onChanged: (newValue) => time.value = newValue ?? 'Morning',
                          )),
                          sizedBoxDefault(),

                          // Member Dropdown
                          Obx(() => DropdownButtonFormField<Map<String, dynamic>>(
                            decoration: const InputDecoration(border: UnderlineInputBorder()),
                            value: memberController.selectedMember.value.isNotEmpty ? memberController.selectedMember.value : null,
                            items: (memberController.memberList ?? []).map((member) {
                              return DropdownMenuItem<Map<String, dynamic>>(
                                value: member,
                                child: Text(member?["full_name"] ?? "N/A"),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              memberController.selectedMember.value = newValue ?? {};
                              memberController.selectMemberId(newValue?["id"]);
                            },
                          )),
                          sizedBoxDefault(),

                          // Diet Plan Dropdown
                          Obx(() => DropdownButtonFormField<Map<String, dynamic>>(
                            decoration: const InputDecoration(border: UnderlineInputBorder()),
                            value: planController.selectedDietPlan.value.isNotEmpty ? planController.selectedDietPlan.value : null,
                            items: (planController.dietPlanListing ?? []).map((plan) {
                              return DropdownMenuItem<Map<String, dynamic>>(
                                value: plan,
                                child: Text(plan?["plan_name"].toString() ?? "N/A"),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              planController.selectedDietPlan.value = newValue ?? {};
                              planController.selectDietPlanId(newValue?["id"]);
                            },
                          )),
                          sizedBoxDefault(),

                          // Food Dropdown
                          Obx(() => DropdownButtonFormField<Map<String, dynamic>>(
                            decoration: const InputDecoration(border: UnderlineInputBorder()),
                            value: ownerController.selectedFood.value.isNotEmpty ? ownerController.selectedFood.value : null,
                            items: (ownerController.foodList ?? []).map((food) {
                              return DropdownMenuItem<Map<String, dynamic>>(
                                value: food,
                                child: Text(food?["food_name"].toString() ?? "N/A"),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              ownerController.selectedFood.value = newValue ?? {};
                              ownerController.selectFoodId(newValue?["id"]);
                            },
                          )),
                          sizedBoxDefault(),

                          // Quantity Field
                          UnderlineTextfield(
                            keyboardType: TextInputType.number,
                            controller: _quantityController,
                            label: 'Quantity',
                            hint: 'Quantity',
                            validation: Validators.validate,
                          ),
                          sizedBoxDefault(),

                          // Add Meal Button
                          SizedBox(
                            width: Get.size.width,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(Theme.of(context).primaryColor),
                              ),
                              onPressed: () {

                                if(_formKey.currentState!.validate()) {
                                  addMealItem(memberController, planController, ownerController);
                                }
                              },
                              child: const Text("Add Meal Item"),
                            ),
                          ),
                          sizedBoxDefault(),

                          // Show Temporary Added Items
                          Obx(() {
                            return selectedFoodIds.isEmpty
                                ?  Center(child: Text("No food items added.",style:notoSansMedium,))
                                : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(selectedFoodIds.length, (index) {
                                final foodId = selectedFoodIds[index];
                                final quantity = selectedQuantities[index];

                                final food = ownerController.foodList!.firstWhereOrNull((f) => f["id"] == foodId);
                                final foodName = food != null ? food["food_name"] : "Unknown Food";

                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  child: Text("• $foodName - $quantity portion(s)"),
                                );
                              }),
                            );
                          }),
                          sizedBoxDefault(),

                          CustomButtonWidget(buttonText: mealPlanData.isEmpty ? "+ Add" : "Added" ,
                          onPressed:() => finalizeMeal(memberController, planController), ),
                          sizedBoxDefault(),


                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
