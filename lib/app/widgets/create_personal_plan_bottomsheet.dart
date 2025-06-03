import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myegym/app/widgets/underline_textfield.dart';
import 'package:myegym/controllers/helper_controller.dart';
import 'package:myegym/controllers/owner_controller.dart';
import 'package:myegym/helper/validations.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';
import 'package:get/get.dart';
import '../../data/repo/owner_repo.dart';
import '../../utils/date_converter.dart';


class CreatePersonalPlanBottomSheet extends StatelessWidget {
  final RxString preference = 'Vegetarian'.obs;

  final RxString lifeStyle = 'job'.obs;
  final RxString time = 'Morning'.obs;
  final RxString unit = 'grm'.obs;
  final RxString mealTime = 'Breakfast'.obs;
  final RxString quantity = '100'.obs;

  final planNameController = TextEditingController();
  final trainingFrequencyController = TextEditingController();
  final sessionDurationController  = TextEditingController();
  final paidAmountController  = TextEditingController();
  final discountController  = TextEditingController();
  final TextEditingController startingDateController = TextEditingController();
  final TextEditingController endingDateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  CreatePersonalPlanBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => OwnerRepo(apiClient: Get.find()));
    Get.lazyPut(() => OwnerController(ownerRepo: Get.find()));
    Get.lazyPut(() => HelperController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("Fetching data for CreatePlanBottomsheet");
      Get.find<OwnerController>().getWorkoutGoalApi();
      Get.find<OwnerController>().getFoodListingApi();
      Get.find<OwnerController>().getPlanDurationList();
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
                    Text('Create Personal Plan',
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
                              capitalization: TextCapitalization.words,
                              controller: planNameController,
                              label: 'Personal Plan Name',
                              hint: 'Personal Plan Name',
                              validation: Validators.validate,
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
                            UnderlineTextfield(
                              keyboardType: TextInputType.number,
                              controller: sessionDurationController,
                              label: 'Session Duration in Hours',
                              hint: 'Session Duration in Hours',
                              validation: Validators.validate,
                            ),
                            sizedBoxDefault(),
                            UnderlineTextfield(
                              keyboardType: TextInputType.number,
                              controller: paidAmountController,
                              label: 'Paid Amount',
                              hint: 'Paid Amount',
                              validation: Validators.validate,
                            ),

                            sizedBoxDefault(),
                            UnderlineTextfield(
                              keyboardType: TextInputType.number,
                              controller: discountController,
                              label: 'Discount Amount',
                              hint: 'Discount Amount',
                              validation: Validators.validate,
                            ),
                            sizedBoxDefault(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Plan Duration',
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
                                          .selectedPlanDuration.value.isNotEmpty
                                          ? ownerControl.selectedPlanDuration.value
                                          : null, // Ensure it's a valid Map<String, dynamic> or null
                                      items: (ownerControl.planDurationList ?? [])
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
                                        ownerControl.selectedPlanDuration.value =
                                            newValue ??
                                                {}; // Store raw data directly
                                        ownerControl.selectPlanDurationId(newValue?[
                                        "id"]); // Access data directly as map

                                        print(ownerControl.selectedPlanDurationID);
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please select an Plan Duration Goal';
                                        }
                                        return null;
                                      },
                                    ))
                              ],
                            ),

                            sizedBoxDefault(),
                            Row(
                              children: [
                                Expanded(
                                  child: UnderlineTextfield(
                                    readOnly: true,
                                    onTap: () async {
                                      await helperControl
                                          .selectStartDateDateFunction(context);
                                      startingDateController.text = DateConverter.formatDateToYMD(helperControl.selectedStartDate);
                                    },
                                    label: 'Starting Date',
                                    hint: 'Starting Date',
                                    controller: startingDateController,
                                    showSuffixIcon: false,
                                    validation: helperControl.validateDate,
                                  ),
                                ),
                                SizedBox(width: 16.0),
                                Expanded(
                                  child: UnderlineTextfield(
                                    readOnly: true,
                                    onTap: () async {
                                      await helperControl
                                          .selectEndDDateFunction(context);
                                      endingDateController.text = DateConverter.formatDateToYMD(helperControl.selectedEndDate);
                                    },
                                    label: 'Ending Date',
                                    hint: 'Ending Date',
                                    controller: endingDateController,
                                    showSuffixIcon: false,
                                    validation: helperControl.validateDate,
                                  ),
                                ),
                              ],
                            ),







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
                                      ownerControl.addPersonalTrainerPlan(
                                          trainingGoals: ownerControl.selectedGoalID.toString(),
                                          trainingPlanName: planNameController.text.trim(),
                                          trainingFrequency: ownerControl.selectedPlanDurationID.toString(),
                                          sessionDuration:sessionDurationController.text.trim(),
                                          trainingStartDate: startingDateController.text.trim(),
                                          trainingEndDate: endingDateController.text.trim(),
                                          paidAmount: paidAmountController.text.trim(),

                                          discount: discountController.text.trim());
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      Theme.of(context).primaryColor),
                                  child: Text('Add Plan',
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
