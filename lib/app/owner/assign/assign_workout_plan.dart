import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:myegym/app/trainer/workouts/components/daily_schedule_dialog.dart';
import 'package:myegym/app/widgets/custom_app.dart';
import 'package:myegym/app/widgets/custom_button.dart';
import 'package:myegym/app/widgets/custom_snackbar.dart';
import 'package:myegym/app/widgets/underline_textfield.dart';
import 'package:myegym/controllers/helper_controller.dart';
import 'package:myegym/controllers/member_controller.dart';
import 'package:myegym/controllers/owner_controller.dart';
import 'package:myegym/controllers/plans_controller.dart';
import 'package:myegym/controllers/trainer_controllers.dart';
import 'package:myegym/data/repo/member_repo.dart';
import 'package:myegym/data/repo/owner_repo.dart';
import 'package:myegym/data/repo/plan_repo.dart';
import 'package:myegym/data/repo/trainer_repo.dart';
import 'package:myegym/utils/date_converter.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import '../../../../utils/styles.dart';
import '../../../helper/validations.dart';

class AssignWorkoutPlan extends StatelessWidget {
  final String memberID;
  final String memberName;
  AssignWorkoutPlan({super.key, required this.memberID, required this.memberName});

  final paidAmountController  = TextEditingController();
  final discountController  = TextEditingController();
  final dueAmountController  = TextEditingController();
  final admissionFessController  = TextEditingController();
  final TextEditingController startingDateController = TextEditingController();
  final TextEditingController endingDateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Get.put(HelperController());
    Get.put(TrainerRepo(apiClient: Get.find()));
    final trainerC =  Get.put(TrainerController(trainerRepo: Get.find()));
    Get.put(OwnerRepo(apiClient: Get.find()));
    final ownerC = Get.put(OwnerController(ownerRepo: Get.find()));
    Get.put(PlanRepo(apiClient: Get.find()));
    final planC = Get.put(PlansController(planRepo: Get.find()));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      trainerC.getTrainerList();
      ownerC.getPersonalPlanList();
      planC.getWorkoutListing();
      ownerC.getPlanDurationList();

    });

    return SafeArea(
      child: Form(
        key: formKey,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBar(
              title: "Assign Personal Trainer",
              isLogo: false,
              isBackButtonExist: true,
            ),
            body: GetBuilder<HelperController>(builder: (helperControl) {
              return GetBuilder<TrainerController>(builder: (trainerControl) {
                return  GetBuilder<PlansController>(builder: (planControl) {
                  return Padding(
                      padding:  EdgeInsets.all(Dimensions.paddingSizeDefault),
                      child: GetBuilder<OwnerController>(builder: (ownerControl) {
                        return  Stack(
                          children: [
                            SizedBox(height: Get.size.height,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text('Assing Workout Plan To ${memberName}',
                                      style: notoSansSemiBold.copyWith(
                                          fontSize: Dimensions.fontSize14,
                                          color: Theme.of(context).primaryColor
                                      ),),
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
                                      controller: dueAmountController,
                                      label: 'Due Amount',
                                      hint: 'Due Amount',
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
                                    UnderlineTextfield(
                                      keyboardType: TextInputType.number,
                                      controller: admissionFessController,
                                      label: 'Admission Fees',
                                      hint: 'Admission Fees',
                                      validation: Validators.validate,
                                    ),
                                    sizedBoxDefault(),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Workout Plans',
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
                                              value: planControl
                                                  .selectedWorkoutPlan.value.isNotEmpty
                                                  ? planControl.selectedWorkoutPlan.value
                                                  : null, // Ensure it's a valid Map<String, dynamic> or null
                                              items: (planControl.workoutListing ?? [])
                                                  .map((trainerData) {
                                                return DropdownMenuItem<Map<String, dynamic>>(
                                                  value:
                                                  trainerData,
                                                  child: Text(
                                                      trainerData?["goals"]['name'] ?? "Unknown"),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) {
                                                planControl.selectedWorkoutPlan.value =
                                                    newValue ??
                                                        {}; // Store raw data directly
                                                planControl.selectWorkoutPlanId(newValue?[
                                                "id"]); // Access data directly as map

                                                print(planControl.selectedWorkoutPlanId);
                                              },
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Please select Workout Plan';
                                                }
                                                return null;
                                              },
                                            ))

                                      ],
                                    ),


                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: Dimensions.paddingSizeDefault,
                              left: 0,
                              right:  0,
                              child: CustomButtonWidget(buttonText: "Assing Personal Training",
                                onPressed: () {
                                  ownerControl.assignWorkoutPlan(
                                      memberId: memberID,
                                      packageId: ownerControl.selectedPlanDurationID.toString(),
                                      startDate: startingDateController.text.trim(),
                                      endDate: endingDateController.text.trim(),
                                      paidAmount: paidAmountController.text.trim(),
                                      dueAmount:  dueAmountController.text.trim(),
                                      discount: discountController.text.trim(),
                                      admissionFees: admissionFessController.text.trim(),
                                      paymentMethod: 'online',
                                      workoutId: planControl.selectedWorkoutPlanId.toString());

                                },),
                            )

                          ],
                        );
                      })
                  );
                }) ;
              });


            })),
      ),
    );
  }
}
