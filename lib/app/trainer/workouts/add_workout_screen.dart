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
import 'package:myegym/data/repo/trainer_repo.dart';
import 'package:myegym/utils/date_converter.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';

import '../../../../utils/styles.dart';

class AddWorkoutScreen extends StatelessWidget {
  AddWorkoutScreen({super.key});
  final TextEditingController memberNameController = TextEditingController();

  final TextEditingController startingDateController = TextEditingController();
  final TextEditingController endingDateController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController goalController = TextEditingController(text: 'weight loss');
  final TextEditingController emailController = TextEditingController();
  final RxString contactRelation = 'Other'.obs;
  final RxString relation = 'Single'.obs;
  final RxString level = 'Beginner'.obs;
  final RxString time = '5-10'.obs;
  final RxString times = '5'.obs;
  final RxString sessions = '5'.obs;
  final RxString frequency = '5'.obs;
  final TextEditingController amountController =
      TextEditingController(text: '₹ 20000');
  final TextEditingController joiningDateController =
      TextEditingController(text: '10-01-2025');
  final TextEditingController addressController = TextEditingController();
  final TextEditingController createPasswordController =
      TextEditingController(text: '');
  final TextEditingController confirmPasswordController =
      TextEditingController(text: '');
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController emergencyNameController = TextEditingController();
  final TextEditingController emergencyPhoneController =
      TextEditingController();
  List<Map<String, dynamic>> scheduleData = [];
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Get.put(MemberRepo(apiClient: Get.find()));
    Get.put(MemberController(memberRepo: Get.find()));
    Get.put(TrainerRepo(apiClient: Get.find()));
    Get.put(TrainerController(trainerRepo: Get.find())); // <--- ADD THIS LINE
    Get.put(HelperController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<OwnerController>().getActivityList();
      Get.find<OwnerController>().getSubActivityList();
  Get.find<OwnerController>().getWorkoutGoalApi();
    });

    return SafeArea(
      child: Form(
        key: formKey,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBar(
              title: "Add Workout",
              isLogo: false,
              isBackButtonExist: true,
            ),
            body: GetBuilder<HelperController>(builder: (helperControl) {
              return GetBuilder<OwnerController>(builder: (ownerControl) {
                return GetBuilder<PlansController>(builder: (planControl) {
                  return Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          sizedBoxDefault(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Activity',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color:
                                        const Color.fromRGBO(117, 117, 117, 1)),
                              ),
                              Obx(() =>
                                  DropdownButtonFormField<Map<String, dynamic>>(
                                    // Use Map<String, dynamic> instead of TrainerModel
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                    ),
                                    value: ownerControl
                                            .selectedActivity.value.isNotEmpty
                                        ? ownerControl.selectedActivity.value
                                        : null, // Ensure it's a valid Map<String, dynamic> or null
                                    items: (ownerControl.activityList ?? [])
                                        .map((trainerData) {
                                      return DropdownMenuItem<
                                          Map<String, dynamic>>(
                                        // Use Map<String, dynamic> as value type
                                        value:
                                            trainerData, // Assign the 'trainer' map to the value
                                        child: Text(
                                            trainerData?["title"] ?? "Unknown"),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      ownerControl.selectedActivity.value =
                                          newValue ??
                                              {}; // Store raw data directly
                                      ownerControl.selectActivityId(newValue?[
                                          "id"]); // Access data directly as map

                                      print(ownerControl.selectedActivityId);
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select an activity';
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
                              Text(
                                'Sub Activity',
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
                                        .selectedSubActivity.value.isNotEmpty
                                        ? ownerControl.selectedSubActivity.value
                                        : null, // Ensure it's a valid Map<String, dynamic> or null
                                    items: (ownerControl.subActivityList ?? [])
                                        .map((trainerData) {
                                      return DropdownMenuItem<
                                          Map<String, dynamic>>(
                                        // Use Map<String, dynamic> as value type
                                        value:
                                        trainerData, // Assign the 'trainer' map to the value
                                        child: Text(
                                            trainerData?["title"] ?? "Unknown"),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      ownerControl.selectedSubActivity.value =
                                          newValue ??
                                              {}; // Store raw data directly
                                      ownerControl.selectSubActivityId(newValue?[
                                      "id"]); // Access data directly as map

                                      print(ownerControl.selectedSubActivityId);
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select an sub activity';
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
                                    startingDateController.text = DateConverter.formatDateToYMD(helperControl.selectedStartDate.replaceAll("/", "-"));
                                    // startingDateController.text = helperControl.selectedStartDate.replaceAll("/", "-");
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
                                    endingDateController.text = DateConverter.formatDateToYMD(helperControl.selectedEndDate.replaceAll("/", "-"));
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
                            maxLength: 10,
                            label: 'Notes',
                            hint: 'Notes',
                            maxLines: 3,
                            controller: noteController,
                            showSuffixIcon: false,
                            validation: helperControl.validate,
                          ),
                          sizedBoxDefault(),
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
                          // UnderlineTextfield(
                          //
                          //   label: 'Goals',
                          //   hint: 'Goals',
                          //   controller: goalController,
                          //   showSuffixIcon: false,
                          //   validation: helperControl.validate,
                          // ),
                          sizedBoxDefault(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('level',
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.grey[600])),
                              Obx(() => DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                        border: UnderlineInputBorder()),
                                    value: level.value,
                                    items: [
                                      'Beginner',
                                      'Intermediate',
                                      'Advanced'
                                    ].map((value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) =>
                                        level.value = newValue ?? 'Beginner',
                                  )),
                            ],
                          ),
                          sizedBoxDefault(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Time',
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.grey[600])),
                              Obx(() => DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                        border: UnderlineInputBorder()),
                                    value: time.value,
                                    items: [
                                      // '1-5',
                                      '5-10',
                                      // '10-15'
                                    ].map((value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) =>
                                        time.value = newValue ?? '5-10',
                                  )),
                            ],
                          ),
                          sizedBoxDefault(),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Times',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.grey[600])),
                                    Obx(() => DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                              border: UnderlineInputBorder()),
                                          value: times.value,
                                          items: [
                                            // '1-5',
                                            '5',
                                            // '10-15'
                                          ].map((value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) =>
                                              times.value = newValue ?? '5',
                                        )),
                                  ],
                                ),
                              ),
                              sizedBoxW10(),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Sessions',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.grey[600])),
                                    Obx(() => DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                              border: UnderlineInputBorder()),
                                          value: sessions.value,
                                          items: [
                                            // '1-5',
                                            '5',
                                            // '10-15'
                                          ].map((value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) =>
                                              sessions.value = newValue ?? '5',
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          sizedBoxDefault(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Frequency',
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.grey[600])),
                              Obx(() => DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                        border: UnderlineInputBorder()),
                                    value: frequency.value,
                                    items: [
                                      // '1-5',
                                      '5',
                                      // '10-15'
                                    ].map((value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) =>
                                        frequency.value = newValue ?? '5',
                                  )),
                            ],
                          ),
                          sizedBoxDefault(),
                          ElevatedButton(
                            onPressed: () {
                          Get.to(() => DailyScheduleDialog(
                            onSave: (scheduleList) {
                              // Send this list to your API:
                              print('Final Schedule: $scheduleList');

                              scheduleData = scheduleList;

                            },
                          ));

                              // Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                            child: Text(
                              'Add Schedule',
                              style:
                                  notoSansRegular.copyWith(color: Colors.white),
                            ),
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
                                                          .pickedDocument!.path,
                                                    ),
                                                    height: 90,
                                                    width: 90,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Stack(
                                                    children: [
                                                      Container(
                                                          height: 120,
                                                          width: Get.size.width,
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
                                                          child: Icon(
                                                              Icons.person)),
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
                                              onTap: () =>
                                                  helperControl.pickDocument(
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
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  margin:
                                                      const EdgeInsets.all(25),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 2,
                                                        color: Colors.white),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                      Icons.insert_drive_file,
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
                          Text("Add Identity Document"),
                          SizedBox(height: 24.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text(
                                  'Cancel',
                                  style: notoSansRegular.copyWith(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    if (
                                        (helperControl.pickedDocument == null || helperControl.pickedDocument!.path.isEmpty)) {
                                      showCustomSnackBar(context, "Workout Image");
                                    } else {

                                      ownerControl.createWorkoutApi(
                                          startDate: startingDateController.text,
                                          endDate: endingDateController.text,
                                          notes: noteController.text,
                                          goals: ownerControl.selectedGoalID.toString(),
                                          level: level.value == "Beginner" ?
                                          "1" : level.value == "intermediate" ? "2" :
                                          "3",
                                          time: times.value,
                                          activitie: ownerControl.selectedActivityId.toString(),
                                          subactivity: ownerControl.selectedSubActivityId.toString(),
                                          activitiesId: ownerControl.selectedActivityId.toString(),
                                          subactivityId: ownerControl.selectedSubActivityId.toString(),
                                          times: times.toString(),
                                          session: sessions.toString(),
                                          frequency: frequency.toString(),
                                          days: scheduleData, photoFilePath:  helperControl
                                          .pickedDocument!.path);
                                    }
                                  } else {
                                    showCustomSnackBar(context, "Please Add Required Fields");
                                  }

                                  // Get.back();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).primaryColor,
                                ),
                                child: Text(
                                  'Add Workout',
                                  style: notoSansRegular.copyWith(color: Colors.white),
                                ),
                              ),

                            ],
                          ),
                          sizedBox40(),
                        ],
                      ),
                    ),
                  );
                });
              });
            })),
      ),
    );
  }
}
