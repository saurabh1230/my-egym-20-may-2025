import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:myegym/app/widgets/custom_app.dart';
import 'package:myegym/app/widgets/custom_snackbar.dart';
import 'package:myegym/app/widgets/underline_textfield.dart';
import 'package:myegym/controllers/helper_controller.dart';
import 'package:myegym/controllers/member_controller.dart';
import 'package:myegym/controllers/trainer_controllers.dart';
import 'package:myegym/data/models/trainer_model.dart';
import 'package:myegym/data/repo/member_repo.dart';
import 'package:myegym/data/repo/trainer_repo.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';

import '../../../../utils/styles.dart';

class AddMemberScreen extends StatelessWidget {
  final bool? isByTrainer;
  AddMemberScreen({super.key, this.isByTrainer = false});
  final TextEditingController memberNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final RxString contactRelation = 'Other'.obs;
  final RxString relation = 'Single'.obs;
  final RxString gender = 'male'.obs;
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

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Get.put(MemberRepo(apiClient: Get.find()));
    Get.put(MemberController(memberRepo: Get.find()));
    Get.put(TrainerRepo(apiClient: Get.find()));
    Get.put(TrainerController(trainerRepo: Get.find())); // <--- ADD THIS LINE
    Get.put(HelperController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<TrainerController>().getTrainerList();
    });

    return SafeArea(
      child: Form(
        key: formKey,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBar(
              title: "Add Member",
              isLogo: false,
              isBackButtonExist: true,
            ),
            body: GetBuilder<HelperController>(builder: (helperControl) {
              return GetBuilder<MemberController>(builder: (memberControl) {
                return GetBuilder<TrainerController>(builder: (trainerControl) {
                  return Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          sizedBox10(),
                          Center(
                            child: SizedBox(
                              height: 100,
                              width: 100,
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
                                            height: 100, width: 100,
                                            clipBehavior: Clip.hardEdge,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
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
                                            child: helperControl.pickedImage !=
                                                    null
                                                ? Image.file(
                                                    File(
                                                      helperControl
                                                          .pickedImage!.path,
                                                    ),
                                                    height: 90,
                                                    width: 90,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Stack(
                                                    children: [
                                                      Container(
                                                          height: 100,
                                                          width: 100,
                                                          clipBehavior:
                                                              Clip.hardEdge,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
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
                                              onTap: () => helperControl
                                                  .pickImage(isRemove: false),
                                              child: Container(
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
                                                  margin:
                                                      const EdgeInsets.all(25),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 2,
                                                        color: Colors.white),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                      Icons.camera_alt,
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
                          Text("Add Profile Image"),
                          sizedBoxDefault(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: UnderlineTextfield(
                                      label: 'Member Name',
                                      hint: 'Member Full Name',
                                      controller: memberNameController,
                                      showSuffixIcon: false,
                                      validation: helperControl.validateName,
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Expanded(
                                    child: UnderlineTextfield(
                                      readOnly: true,
                                      onTap: () async {
                                        await helperControl
                                            .selectDateBirthFunction(context);
                                        dobController.text =
                                            helperControl.selectedDateBirth;
                                      },
                                      label: 'Date of Birth',
                                      hint: 'D.O.B',
                                      controller: dobController,
                                      showSuffixIcon: false,
                                      validation: helperControl.validateDOB,
                                    ),
                                  ),
                                ],
                              ),
                              sizedBoxDefault(),
                              Row(
                                children: [
                                  Expanded(
                                    child: UnderlineTextfield(
                                      maxLength: 10,
                                      label: 'Phone Number',
                                      hint: 'Phone Number',
                                      controller: phoneController,
                                      keyboardType: TextInputType.phone,
                                      showSuffixIcon: false,
                                      validation: helperControl.validatePhone,
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Expanded(
                                    child: UnderlineTextfield(
                                      label: 'Email Address',
                                      hint: 'Email Address',
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      showSuffixIcon: false,
                                      validation: helperControl.validateEmail,
                                    ),
                                  ),
                                ],
                              ),
                              sizedBoxDefault(),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Gender',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.grey[600])),
                                        Obx(() =>
                                            DropdownButtonFormField<String>(
                                              decoration: InputDecoration(
                                                  border:
                                                      UnderlineInputBorder()),
                                              value: gender.value,
                                              items: ['male', 'female']
                                                  .map((value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) => gender
                                                  .value = newValue ?? 'male',
                                            )),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Expanded(
                                    child: UnderlineTextfield(
                                      maxLength: 6,
                                      keyboardType: TextInputType.number,
                                      label: 'Zip Code',
                                      hint: 'Zip Code',
                                      controller: zipCodeController,
                                      showSuffixIcon: false,
                                      validation: helperControl.validateZipCode,
                                    ),
                                  ),
                                ],
                              ),
                              sizedBoxDefault(),
                              UnderlineTextfield(
                                label: 'Address',
                                hint: 'Write address here...',
                                controller: addressController,
                                maxLines: 2,
                                showSuffixIcon: false,
                                validation: helperControl.validateAddress,
                              ),
                              sizedBoxDefault(),
                              Row(
                                children: [
                                  Expanded(
                                    child: UnderlineTextfield(
                                      label: 'Emergency Contact Name',
                                      hint: 'Emergency Contact Name',
                                      controller: emergencyNameController,
                                      maxLines: 2,
                                      showSuffixIcon: false,
                                      validation: helperControl.validateName,
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Emergency Contact Relationship',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        Obx(
                                          () => DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                            ),
                                            value: contactRelation.value,
                                            items: <String>[
                                              'Father',
                                              'Mother',
                                              'Sister',
                                              'Friend',
                                              'Other',
                                              'Spouse',
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              if (newValue != null) {
                                                contactRelation.value =
                                                    newValue;
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              sizedBoxDefault(),
                              UnderlineTextfield(
                                maxLength: 10,
                                label: 'Emergency Contact Number',
                                hint: 'Emergency Contact Number',
                                controller: emergencyPhoneController,
                                keyboardType: TextInputType.phone,
                                showSuffixIcon: false,
                                validation: helperControl.validatePhone,
                              ),
                              sizedBoxDefault(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Emergency Contact Relationship Status',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Obx(
                                    () => DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                      ),
                                      value: relation.value,
                                      items: <String>[
                                        'Single',
                                        'Married',
                                        'Divorced',
                                        'Separated',
                                        'Engaged',
                                        'Widowed',
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        if (newValue != null) {
                                          relation.value = newValue;
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              sizedBoxDefault(),
                              isByTrainer! ?
                                  SizedBox() :
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

                                  // Obx(() =>
                                  //     DropdownButtonFormField<TrainerModel>(
                                  //       decoration: const InputDecoration(
                                  //         border: UnderlineInputBorder(),
                                  //       ),
                                  //       value: trainerControl
                                  //           .selectedTrainer.value,
                                  //       items:
                                  //           (trainerControl.trainerList ?? [])
                                  //               .map((model) {
                                  //         return DropdownMenuItem<TrainerModel>(
                                  //           value: model,
                                  //           child: Text(model.fullName),
                                  //         );
                                  //       }).toList(),
                                  //       onChanged: (newValue) {
                                  //         trainerControl.selectedTrainer.value =
                                  //             newValue;
                                  //         trainerControl.selectTrainerId(
                                  //             newValue!.userId);

                                  //         print(
                                  //             trainerControl.selectedTrainerId);

                                  //         // dataControl.selectedQualificationId.value = newValue.id;
                                  //       },
                                  //     ))
                                ],
                              ),
                              sizedBoxDefault(),
                              UnderlineTextfield(
                                label: 'Password',
                                hint: '',
                                controller: createPasswordController,
                                obscureText: true, // Initially obscure
                                showSuffixIcon: true, // Show eye icon
                                validation: helperControl.validatePassword,
                              ),
                              sizedBoxDefault(),
                              UnderlineTextfield(
                                label: 'Confirm Password',
                                hint: '',
                                controller: confirmPasswordController,
                                obscureText: true, // Initially obscure
                                showSuffixIcon: true, //
                                validation: (value) =>
                                    helperControl.validateConfirmPassword(
                                        value, createPasswordController.text),
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
                              Text("Add Identity Document"),
                              SizedBox(height: 24.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      'Cancel',
                                      style: notoSansRegular.copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        if ((helperControl.pickedImage == null || helperControl.pickedImage!.path.isEmpty) &&
                                            (helperControl.pickedDocument == null || helperControl.pickedDocument!.path.isEmpty)) {
                                          showCustomSnackBar(context,
                                              "Please Add Profile Image and Identity Document");
                                        } else {
                                          memberControl.addMemberApi(
                                            isAddedByTrainer: isByTrainer,
                                            fullName: memberNameController.text,
                                            dateOfBirth: dobController.text,
                                            gender: gender.value,
                                            phoneNumber: phoneController.text,
                                            emailAddress: emailController.text,
                                            address: addressController.text,
                                            trainerId: trainerControl
                                                .selectedTrainerId
                                                .toString(),
                                            zipCode: zipCodeController.text,
                                            emergencyContactName:
                                                emergencyNameController.text,
                                            emergencyContactPhone:
                                                emergencyPhoneController.text,
                                            contactRelationship:
                                                contactRelation.value,
                                            relationship: relation.value,
                                            password:
                                                confirmPasswordController.text,
                                            photo: helperControl.pickedImage !=
                                                        null &&
                                                    helperControl.pickedImage!
                                                        .path.isNotEmpty
                                                ? helperControl.pickedImage
                                                : null,
                                            identityproof: helperControl
                                                            .pickedDocument !=
                                                        null &&
                                                    helperControl
                                                        .pickedDocument!
                                                        .path
                                                        .isNotEmpty
                                                ? helperControl.pickedDocument
                                                : null,
                                          );
                                        }
                                      } else {
                                        showCustomSnackBar(context,
                                            "Please Add Required Fields");
                                      }

                                      // Get.back();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                    child: Text(
                                      'Add Member',
                                      style: notoSansRegular.copyWith(
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              sizedBox40(),
                            ],
                          ),
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
