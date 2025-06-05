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

class AddPersonalTrainer extends StatelessWidget {
  final String memberID;
  final String memberName;
  final bool? isUpdate;
  final String? personalPlanId;
  final String? trainerId;
  final String? trainingPlanId;
  AddPersonalTrainer({super.key, required this.memberID, required this.memberName, this.isUpdate = false,  this.personalPlanId, this.trainerId, this.trainingPlanId});
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    print('Trainer ID :${trainerId}');
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

      // if (isUpdate == true) {
      //   print("👉 isUpdate mode: trainerId = $trainerId");
      //
      //   /// ✅ Set Trainer Dropdown
      //   if (trainerId != null && trainerId!.isNotEmpty) {
      //     final matchedTrainer = trainerC.trainerList?.firstWhereOrNull(
      //           (trainer) => trainer["trainer"]["user_id"].toString() == trainerId,
      //     );
      //
      //     if (matchedTrainer != null) {
      //       print("✅ Matched Trainer: ${matchedTrainer["trainer"]["full_name"]}");
      //       trainerC.selectedTrainer.value = matchedTrainer["trainer"];
      //       trainerC.selectTrainerId(int.parse(matchedTrainer["trainer"]["user_id"].toString()));
      //     } else {
      //       print("❌ No matching trainer found for trainerId = $trainerId");
      //     }
      //   }
      //
      //   /// ✅ Set Plan Dropdown
      //   if (trainingPlanId != null && trainingPlanId!.isNotEmpty) {
      //     final matchedPlan = ownerC.personalPlan?.firstWhereOrNull(
      //           (plan) => plan["id"].toString() == trainingPlanId,
      //     );
      //
      //     if (matchedPlan != null) {
      //       print("✅ Matched Plan: ${matchedPlan["plan_name"] ?? matchedPlan["name"]}");
      //       ownerC.selectedPersonalPlan.value = matchedPlan;
      //       ownerC.selectPersonalPlanId(int.parse(matchedPlan["id"].toString()));
      //     } else {
      //       print("❌ No matching plan found for trainingPlanId = $trainingPlanId");
      //     }
      //   }
      // }

    });

    return SafeArea(
      child: Form(
        key: formKey,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBar(
              title: isUpdate!  ? "Update Personal Trainer" : "Assign Personal Trainer",
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
                                    Text('Assing Trainer To ${memberName}',
                                    style: notoSansSemiBold.copyWith(
                                      fontSize: Dimensions.fontSize14,
                                      color: Theme.of(context).primaryColor
                                    ),),

                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Trainers',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: const Color.fromRGBO(
                                                  117, 117, 117, 1)),
                                        ),
                                        Obx(() => DropdownButtonFormField<
                                            Map<String, dynamic>>(
                                          // Use Map<String, dynamic> instead of TrainerModel
                                          decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                          ),
                                          value: trainerControl.selectedTrainer
                                              .value.isNotEmpty
                                              ? trainerControl
                                              .selectedTrainer.value
                                              : null,
                                          items:
                                          (trainerControl.trainerList ?? [])
                                              .map((trainerData) {
                                            return DropdownMenuItem<
                                                Map<String, dynamic>>(
                                              value: trainerData[
                                              "trainer"],
                                              child: Text(trainerData["trainer"]
                                              ?["full_name"] ??
                                                  "Unknown"),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            trainerControl.selectedTrainer.value =
                                                newValue ??
                                                    {}; // Store raw data directly
                                            trainerControl.selectTrainerId(newValue?[
                                            "user_id"]); // Access data directly as map

                                            print(
                                                trainerControl.selectedTrainerId);
                                          },
                                        ))
                                      ],
                                    ),
                                    sizedBoxDefault(),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Personal Training Plans',
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
                                                  .selectedPersonalPlan.value.isNotEmpty
                                                  ? ownerControl.selectedPersonalPlan.value
                                                  : null, // Ensure it's a valid Map<String, dynamic> or null
                                              items: (ownerControl.personalPlan ?? [])
                                                  .map((trainerData) {
                                                return DropdownMenuItem<Map<String, dynamic>>(
                                                  value:
                                                  trainerData,
                                                  child: Text(
                                                      trainerData?["training_plan"] ?? "Unknown"),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) {
                                                ownerControl.selectedPersonalPlan.value =
                                                    newValue ??
                                                        {}; // Store raw data directly
                                                ownerControl.selectPersonalPlanId(newValue?[
                                                "id"]); // Access data directly as map

                                                print(ownerControl.selectedPersonalPlanId);
                                              },
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Please select Personal Training Plan';
                                                }
                                                return null;
                                              },
                                            ))
                                      ],
                                    ),
                                    sizedBoxDefault(),
                                    planControl.addWorkoutBool ?
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
                                              // validator: (value) {
                                              //   if (value == null || value.isEmpty) {
                                              //     return 'Please select Workout Plan';
                                              //   }
                                              //   return null;
                                              // },
                                            ))

                                      ],
                                    ) : SizedBox(),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: WidgetStateProperty.all(Theme.of(context).primaryColor)
                                        ),
                                          onPressed: () {
                                            planControl.selectAddWorkout(!planControl.addWorkoutBool);

                                          }, child: Text(planControl.addWorkoutBool  ? "Remove Workout Plan" : "Add Workout Plan")),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: Dimensions.paddingSizeDefault,
                              left: 0,
                              right:  0,
                              child: CustomButtonWidget(buttonText:  isUpdate! ?
                                  "Update Personal Training" :
                              "Assing Personal Training",
                                onPressed: () {
                                if(isUpdate == true) {
                                  print('check this');
                                  ownerControl.assignPersonalTrainingUpdate(memberId: memberID,
                                    trainerId:  trainerControl.selectedTrainerId.toString(),
                                    planId: ownerControl.selectedPersonalPlanId.toString(),
                                    workoutId:  planControl.addWorkoutBool ?
                                    planControl.selectedWorkoutPlanId.toString() : "",
                                      id: personalPlanId.toString());
                                } else{
                                  ownerControl.assignPersonalTraining(memberId: memberID,
                                      trainerId:  trainerControl.selectedTrainerId.toString(),
                                      planId: ownerControl.selectedPersonalPlanId.toString(),
                                      workoutId:  planControl.addWorkoutBool ?
                                      planControl.selectedWorkoutPlanId.toString() : ""
                                  );
                                }
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
