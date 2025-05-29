import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myegym/app/widgets/custom_textfield.dart';
import 'package:myegym/app/widgets/specialization_dialog.dart';
import 'package:myegym/app/widgets/underline_textfield.dart';
import 'package:myegym/controllers/data_controller.dart';
import 'package:myegym/controllers/helper_controller.dart';
import 'package:myegym/controllers/owner_controller.dart';
import 'package:myegym/controllers/trainer_controllers.dart';
import 'package:myegym/data/models/qualification_model.dart';
import 'package:myegym/data/models/specialization_model.dart';
import 'package:myegym/data/repo/data_repo.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';
import 'package:get/get.dart';

import '../../data/repo/owner_repo.dart';

class CreatePlanBottomsheet extends StatelessWidget {



  final RxString preference = 'Vegetarian'.obs;

  final RxString lifeStyle = 'job'.obs;
  final RxString time = 'Morning'.obs;
  final RxString unit = 'grm'.obs;
  final RxString mealTime = 'Breakfast'.obs;
  final RxString quantity = '100'.obs;
  final doseController = TextEditingController();
  final planNameController = TextEditingController();
  final supplementController = TextEditingController();
  final remarksController = TextEditingController();
  final noteController = TextEditingController();
  final quantityController = TextEditingController();
  final portionController = TextEditingController();
  final healthTipsController = TextEditingController();
  final exerciseController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  CreatePlanBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => OwnerRepo(apiClient: Get.find()));
    Get.lazyPut(() => OwnerController(ownerRepo: Get.find()));
    Get.lazyPut(() => HelperController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("Fetching data for CreatePlanBottomsheet");
      Get.find<OwnerController>().getWorkoutGoalApi();
      Get.find<OwnerController>().getFoodListingApi();
    });
    return SafeArea(
      child: Form(
          key: formKey,
          child: GetBuilder<OwnerController>(builder: (ownerControl) {
            return GetBuilder<HelperController>(builder: (helperControl) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(Dimensions.radius10)),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Create Diet Plan',
                        style: notoSansSemiBold.copyWith(
                            color: Theme.of(context).primaryColor)),
                    sizedBox10(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sizedBoxDefault(),
                            UnderlineTextfield(
                              controller: planNameController,
                              label: 'Plan Name',
                              hint: 'Plan Name',
                            ),
                            sizedBoxDefault(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Preference',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.grey[600])),
                                Obx(() => DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder()),
                                  value: preference.value,
                                  items: ['Vegetarian', 'Non-Vegetarian','Vegan','Others'].map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) =>
                                  preference.value = newValue ?? 'Vegetarian',
                                )),
                              ],
                            ),
                            sizedBoxDefault(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Goals',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color:
                                      const Color.fromRGBO(117, 117, 117, 1)),
                                ),
                                Obx(() =>
                                    DropdownButtonFormField<Map<String, dynamic>>(
                                      decoration: const InputDecoration(
                                        border: UnderlineInputBorder(),
                                      ),
                                      value: ownerControl
                                          .selectedGoal.value.isNotEmpty
                                          ? ownerControl.selectedGoal.value
                                          : null, // Ensure it's a valid Map<String, dynamic> or null
                                      items: (ownerControl.workoutGoalList ?? [])
                                          .map((trainerData) {
                                        return DropdownMenuItem<
                                            Map<String, dynamic>>(
                                          // Use Map<String, dynamic> as value type
                                          value:
                                          trainerData, // Assign the 'trainer' map to the value
                                          child: Text(
                                              trainerData?["name"] ?? "Unknown"),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        ownerControl.selectedGoal.value =
                                            newValue ??
                                                {}; // Store raw data directly
                                        ownerControl.selectGoalId(newValue?[
                                        "id"]); // Access data directly as map

                                        print(ownerControl.selectedGoalID);
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please select an Workout Goal';
                                        }
                                        return null;
                                      },
                                    ))
                              ],
                            ),
                            sizedBoxDefault(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('LifeStyle',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.grey[600])),
                                Obx(() => DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder()),
                                  value: lifeStyle.value,
                                  items: ['job', 'Stress Levels','Activity Level'].map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) =>
                                  lifeStyle.value = newValue ?? 'job',

                                )),
                              ],
                            ),
                            sizedBoxDefault(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Time',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.grey[600])),
                                Obx(() => DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder()),
                                  value: time.value,
                                  items: ['Morning', 'Afternoon','Night'].map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) =>
                                  time.value = newValue ?? 'Morning',


                                )),
                              ],
                            ),
                            sizedBoxDefault(),
                            Row(
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Unit',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.grey[600])),
                                      Obx(() => DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                            border: UnderlineInputBorder()),
                                        value: unit.value,
                                        items: ['grm', 'litre',].map((value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) =>
                                        unit.value = newValue ?? 'grm',
                                      )),
                                    ],
                                  ),
                                ),
                                sizedBoxW7(),
                                Flexible(flex: 3,
                                  child: UnderlineTextfield(keyboardType: TextInputType.number,
                                    controller: doseController,
                                    label: 'Dose In Grams',
                                    hint: 'Dose In Grams',
                                  ),
                                ),
                              ],
                            ),
                            sizedBoxDefault(),
                            UnderlineTextfield(
                              controller: supplementController,
                              label: 'Supplement Name',
                              hint: 'Supplement Name',
                            ),
                            sizedBoxDefault(),
                            UnderlineTextfield(
                              maxLines: 2,
                              controller: remarksController,
                              label: 'Remarks',
                              hint: 'Remarks',
                            ),
                            sizedBoxDefault(),
                            UnderlineTextfield(
                              maxLines: 3,
                              controller: noteController,
                              label: 'Note',
                              hint: 'Note',
                            ),
                            // sizedBoxDefault(),
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     Text('Meal Time',
                            //         style: TextStyle(
                            //             fontSize: 12.0,
                            //             color: Colors.grey[600])),
                            //     Obx(() => DropdownButtonFormField<String>(
                            //       decoration: InputDecoration(
                            //           border: UnderlineInputBorder()),
                            //       value: mealTime.value,
                            //       items: ['Breakfast', 'Lunch','Dinner'].map((value) {
                            //         return DropdownMenuItem<String>(
                            //           value: value,
                            //           child: Text(value),
                            //         );
                            //       }).toList(),
                            //       onChanged: (newValue) =>
                            //       mealTime.value = newValue ?? 'Breakfast',
                            //     )),
                            //   ],
                            // ),
                            // sizedBoxDefault(),
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     Text(
                            //       'Food Item',
                            //       style: TextStyle(
                            //           fontSize: 12.0,
                            //           color:
                            //           const Color.fromRGBO(117, 117, 117, 1)),
                            //     ),
                            //     Obx(() =>
                            //         DropdownButtonFormField<Map<String, dynamic>>(
                            //           decoration: const InputDecoration(
                            //             border: UnderlineInputBorder(),
                            //           ),
                            //           value: ownerControl
                            //               .selectedFood.value.isNotEmpty
                            //               ? ownerControl.selectedFood.value
                            //               : null, // Ensure it's a valid Map<String, dynamic> or null
                            //           items: (ownerControl.foodList ?? [])
                            //               .map((trainerData) {
                            //             return DropdownMenuItem<
                            //                 Map<String, dynamic>>(
                            //               // Use Map<String, dynamic> as value type
                            //               value:
                            //               trainerData, // Assign the 'trainer' map to the value
                            //               child: Text(
                            //                   trainerData?["food_name"] ?? "Unknown"),
                            //             );
                            //           }).toList(),
                            //           onChanged: (newValue) {
                            //             ownerControl.selectedFood.value =
                            //                 newValue ??
                            //                     {}; // Store raw data directly
                            //             ownerControl.selectFoodId(newValue?[
                            //             "id"]); // Access data directly as map
                            //
                            //             print(ownerControl.selectedFoodID);
                            //           },
                            //           validator: (value) {
                            //             if (value == null || value.isEmpty) {
                            //               return 'Please select a Food Item';
                            //             }
                            //             return null;
                            //           },
                            //         ))
                            //   ],
                            // ),
                            // sizedBoxDefault(),
                            // UnderlineTextfield(
                            //   controller: quantityController,
                            //   label: 'Quantity',
                            //   hint: 'Quantity',
                            // ),
                            sizedBoxDefault(),
                            UnderlineTextfield(
                              controller: portionController,
                              label: 'Portions Instructions',
                              hint: 'Portions',
                            ), sizedBoxDefault(),
                            UnderlineTextfield(
                              controller: healthTipsController,
                              label: 'Healthy Tips',
                              hint: 'Healthy Tips',
                            ),
                            sizedBoxDefault(),
                            UnderlineTextfield(
                              controller: exerciseController,
                              label: 'Exercise',
                              hint: 'Exercise',
                            ),
                            sizedBoxDefault(),
                            Center(
                              child: SizedBox(
                                height: 120,
                                width: Get.size.width,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Center(
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: 120,
                                              width: Get.size.width,
                                              clipBehavior: Clip.hardEdge,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 0.5,
                                                  color: Theme.of(context)
                                                      .primaryColor
                                                      .withOpacity(0.40),
                                                ),
                                                color: Theme.of(context)
                                                    .primaryColor
                                                    .withOpacity(0.1),
                                              ),
                                              // alignment: Alignment.center,
                                              child: helperControl
                                                  .pickedDocument !=
                                                  null
                                                  ? Image.file(
                                                File(
                                                  helperControl
                                                      .pickedDocument!
                                                      .path,
                                                ),
                                                height: 90,
                                                width: 90,
                                                fit: BoxFit.cover,
                                              )
                                                  : Stack(
                                                children: [
                                                  Container(
                                                      height: 120,
                                                      width: Get
                                                          .size.width,
                                                      clipBehavior:
                                                      Clip.hardEdge,
                                                      decoration:
                                                      BoxDecoration(
                                                        color: Theme.of(
                                                            context)
                                                            .primaryColor
                                                            .withOpacity(
                                                            0.1),
                                                      ),
                                                      child: Icon(Icons
                                                          .person)),
                                                  // Image.asset(Images.profilePlaceholder,)
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              right: 0,
                                              top: 0,
                                              left: 0,
                                              child: InkWell(
                                                onTap: () => helperControl
                                                    .pickDocument(
                                                    isRemove: false),
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.3),
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Theme.of(
                                                            context)
                                                            .primaryColor),
                                                  ),
                                                  child: Container(
                                                    height: 50,
                                                    width: 50,
                                                    margin:
                                                    const EdgeInsets.all(
                                                        25),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 2,
                                                          color:
                                                          Colors.white),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: const Icon(
                                                        Icons
                                                            .insert_drive_file,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            sizedBox10(),
                            Center(child: Text("Add Plan Image")),


                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     Text('Quantity',
                            //         style: TextStyle(
                            //             fontSize: 12.0,
                            //             color: Colors.grey[600])),
                            //     Obx(() => DropdownButtonFormField<String>(
                            //       decoration: InputDecoration(
                            //           border: UnderlineInputBorder()),
                            //       value: quantity.value,
                            //       items: ['100', '200','250' ,'300','500','600','700','800','900','1000'].map((value) {
                            //         return DropdownMenuItem<String>(
                            //           value: value,
                            //           child: Text(value),
                            //         );
                            //       }).toList(),
                            //       onChanged: (newValue) =>
                            //       quantity.value = newValue ?? '100',
                            //     )),
                            //   ],
                            // ),








                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () => Get.back(),
                                  child: Text('Cancel',
                                      style: notoSansRegular.copyWith(
                                          color:
                                          Theme.of(context).primaryColor)),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      print("Form is valid! Calling API...");
                                      ownerControl.addDietPlanApi(preference: preference.value ==
                                          "Vegetarian" ? "1" : preference.value ==
                                          "Non-Vegetarian" ? "2" : preference.value ==
                                          "Vegan" ? "3" : "4" ,
                                          lifestyle:     lifeStyle.value == "job" ? "1" : lifeStyle.value == "Stress Levels" ? "2" :"3",
                                          supplementName: supplementController.text.trim(),
                                          dose: doseController.text.trim(),
                                          time:   time.value == "Morning" ? "1" : time.value == "Afternoon" ? "2" : "3",
                                          remark: remarksController.text.trim(),
                                          note: noteController.text.trim(),
                                          portionControl: portionController.text.trim(),
                                          healthyTips: healthTipsController.text.trim(),
                                          exercise: exerciseController.text.trim(),
                                          unit:  unit.value == "grm" ? "1" : "2",
                                          goal:ownerControl.selectedGoalID.toString(),
                                          photo: helperControl
                                              .pickedDocument!, planName:planNameController.text.trim());

                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      Theme.of(context).primaryColor),
                                  child: Text('Add Diet Plan',
                                      style: notoSansRegular.copyWith(
                                          color: Colors.white)),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });


          })),
    );
  }
}
