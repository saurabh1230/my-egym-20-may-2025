import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:myegym/app/trainer/workouts/components/daily_schedule_dialog.dart';
import 'package:myegym/app/widgets/custom_app.dart';
import 'package:myegym/app/widgets/custom_snackbar.dart';
import 'package:myegym/app/widgets/underline_textfield.dart';
import 'package:myegym/controllers/helper_controller.dart';
import 'package:myegym/controllers/member_controller.dart';
import 'package:myegym/controllers/owner_controller.dart';
import 'package:myegym/controllers/plans_controller.dart';
import 'package:myegym/controllers/trainer_controllers.dart';
import 'package:myegym/data/repo/member_repo.dart';
import 'package:myegym/data/repo/owner_repo.dart';
import 'package:myegym/data/repo/trainer_repo.dart';
import 'package:myegym/utils/date_converter.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import '../../../../utils/styles.dart';

class AddPersonalTrainer extends StatelessWidget {
  final String memberID;
  AddPersonalTrainer({super.key, required this.memberID});



  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Get.put(HelperController());
    Get.put(TrainerRepo(apiClient: Get.find()));
    Get.put(TrainerController(trainerRepo: Get.find()));
    Get.put(OwnerRepo(apiClient: Get.find()));
    Get.put(OwnerController(ownerRepo: Get.find()));
    // Get.put(MemberRepo(apiClient: Get.find()));
    // Get.put(MemberController(memberRepo: Get.find()));

    // Get.put(MemberRepo(apiClient: Get.find()));
    // Get.put(MemberController(memberRepo: Get.find()));

    // Get.put(HelperController());
    WidgetsBinding.instance.addPostFrameCallback((_) {

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
                return   Padding(
                  padding:  EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: GetBuilder<OwnerController>(builder: (ownerControl) {
                    return  SingleChildScrollView(
                      child: Column(
                        children: [
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
                                    : null, // Ensure it's a valid Map<String, dynamic> or null
                                items:
                                (trainerControl.trainerList ?? [])
                                    .map((trainerData) {
                                  return DropdownMenuItem<
                                      Map<String, dynamic>>(
                                    // Use Map<String, dynamic> as value type
                                    value: trainerData[
                                    "trainer"], // Assign the 'trainer' map to the value
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

                        ],
                      ),
                    );
                  })
                );
              });


            })),
      ),
    );
  }
}
