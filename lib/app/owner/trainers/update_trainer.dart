import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myegym/app/widgets/custom_app.dart';
import 'package:myegym/app/widgets/custom_button.dart';
import 'package:myegym/controllers/helper_controller.dart';
import 'package:myegym/controllers/trainer_controllers.dart';
import 'package:myegym/utils/date_converter.dart';
import 'package:myegym/utils/dimensions.dart';

import '../../../controllers/data_controller.dart';
import '../../../data/models/qualification_model.dart';
import '../../../data/repo/data_repo.dart';
import '../../../utils/images.dart';
import '../../../utils/sizeboxes.dart';
import '../../../utils/styles.dart';
import '../../widgets/custom_network_image.dart';
import '../../widgets/specialization_dialog.dart';
import '../../widgets/underline_textfield.dart';

class UpdateTrainer extends StatefulWidget {
  final bool? isTrainerProfile;
  final String name;
  final  Map<String, dynamic>? data;

   const UpdateTrainer({super.key, required this.data, required this.name, this.isTrainerProfile = false});

  @override
  State<UpdateTrainer> createState() => _UpdateTrainerState();
}

class _UpdateTrainerState extends State<UpdateTrainer> {


  late final Map<String, dynamic> trainerData;
   TextEditingController trainerNameController = TextEditingController();

  final TextEditingController dobController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final RxString gender = 'male'.obs;

  final TextEditingController salaryController =
  TextEditingController(text: '₹ 20000');

  final TextEditingController joiningDateController =
  TextEditingController(text: '10-01-2025');

  final TextEditingController addressController = TextEditingController();

  final TextEditingController instaController = TextEditingController();

  final TextEditingController facebookController = TextEditingController();

  final TextEditingController yearsOfExperience = TextEditingController();

  final TextEditingController createPasswordController =
  TextEditingController(text: '123456xyz');

  final TextEditingController confirmPasswordController =
  TextEditingController(text: '123456xyz');

  final RxString selectedQualification = ''.obs;

  final formKey = GlobalKey<FormState>();


  @override
  void initState() {
    print('widget.data ====== > ${widget.data}');
    print('widget.fullname ====== > ${widget.data!['full_name']}');
    super.initState();
    trainerData = widget.data ?? {}; // ✅ Fix here

  if(widget.isTrainerProfile == true) {
    print('DATA :${widget.data!['full_name']}');
    trainerNameController.text = widget.data!['full_name'];
    dobController.text = DateConverter.formatDateDMYString(
      inputDate: widget.data!['date_of_birth']?.toString() ?? '',
      inputFormat: 'yyyy-MM-dd',
      outputFormat: 'dd/MM/yyyy',
    );
    phoneController.text = widget.data!['phone_number']?.toString() ?? '';
    emailController.text = widget.data!['email']?.toString() ?? '';
    addressController.text = widget.data!['address']?.toString() ?? '';
    yearsOfExperience.text = widget.data!['experienceinyear']?.toString() ?? '';
    joiningDateController.text = widget.data!['created_at']?.toString() ?? '';
    instaController.text = widget.data!['instaProfileLink']?.toString() ?? '';
    facebookController.text = widget.data!['facebookProfileLink']?.toString() ?? '';


  } else {
    print('DATA :${widget.data!['full_name']}');
    trainerNameController.text = widget.data!['full_name'];
    dobController.text = DateConverter.formatDateDMYString(
      inputDate: widget.data!['date_of_birth']?.toString() ?? '',
      inputFormat: 'yyyy-MM-dd',
      outputFormat: 'dd/MM/yyyy',
    );
    phoneController.text = widget.data!['phone_number']?.toString() ?? '';
    emailController.text = widget.data!['email']?.toString() ?? '';
    addressController.text = widget.data!['address']?.toString() ?? '';
    yearsOfExperience.text = widget.data!['experienceinyear']?.toString() ?? '';
    joiningDateController.text = widget.data!['created_at']?.toString() ?? '';
    instaController.text = widget.data!['instaProfileLink']?.toString() ?? '';
    facebookController.text = widget.data!['facebookProfileLink']?.toString() ?? '';

  }


    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<DataController>().getQualificationList();
      Get.find<DataController>().getSpecializationList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.put(DataRepo(apiClient: Get.find()));
    Get.put(DataController(dataRepo: Get.find()));
    Get.put(HelperController());


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: widget.name,isBackButtonExist: true,isHideNotification: true,),
      body: GetBuilder<HelperController>(builder: (helperControl) {
        return   GetBuilder<DataController>(builder: (dataControl) {
          return GetBuilder<TrainerController>(builder: (trainerControl) {
            return Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 0.5,
                                  color: Theme.of(context).highlightColor,
                                ),
                                color: Theme.of(context).hintColor,
                              ),
                              child: helperControl.pickedImage != null
                                  ? Image.file(
                                File(helperControl.pickedImage!.path),
                                height: 90,
                                width: 90,
                                fit: BoxFit.cover,
                              )
                                  : CustomNetworkRoundImageWidget(
                                imagePadding: Dimensions.paddingSize40,
                                height: 150,
                                width: 150,
                                image: '',
                                placeholder: Images.icProfilePlaceHolder,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned.fill(
                              child: InkWell(
                                onTap: () =>
                                    helperControl.pickImage(isRemove: false),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 1,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.all(25),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.white),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.camera_alt,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      sizedBox20(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: UnderlineTextfield(
                                  capitalization: TextCapitalization.words,
                                  label: 'Trainer Name',
                                  hint: 'Trainer Full Name',
                                  controller: trainerNameController,
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
                                        .selectDateBirthFunction(context,isSlash: true);
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
                          SizedBox(height: 16.0),
                          UnderlineTextfield(
                            maxLength: 10,
                            label: 'Phone Number',
                            hint: 'Phone Number',
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            showSuffixIcon: false,
                            validation: helperControl.validatePhone,
                          ),
                          sizedBoxDefault(),
                          UnderlineTextfield(
                            label: 'Email Address',
                            hint: 'Email Address',
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            showSuffixIcon: false,
                            validation: helperControl.validateEmail,
                          ),
                          sizedBoxDefault(),
                          UnderlineTextfield(
                            label: 'Insta Profile Link',
                            hint: 'Insta Profile Link',
                            controller: instaController,
                            showSuffixIcon: false,
                            // validation: helperControl.validateLink,
                          ),
                          sizedBoxDefault(),
                          UnderlineTextfield(
                            label: 'Facebook Profile Link',
                            hint: 'Facebook Profile Link',
                            controller: facebookController,
                            showSuffixIcon: false,
                            // validation: helperControl.validateLink,
                          ),
                          sizedBoxDefault(),
                          Row(
                            children: [
                              Expanded(
                                child: UnderlineTextfield(
                                  maxLength: 3,
                                  label: 'Years of Experience',
                                  hint: 'Years of Experience',
                                  controller: yearsOfExperience,
                                  keyboardType: TextInputType.number,
                                  showSuffixIcon: false,
                                  validation:
                                  helperControl.validateYearsOfExperience,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Gender',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey[600])),
                              Obx(() => DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder()),
                                value: gender.value,
                                items: ['male', 'female'].map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (newValue) =>
                                gender.value = newValue ?? 'male',
                              )),
                            ],
                          ),
                          sizedBoxDefault(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Qualification',
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.grey[600]),
                              ),
                              Obx(() =>
                                  DropdownButtonFormField<QualificationModel>(
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                    ),
                                    value: dataControl
                                        .selectedQualification.value,
                                    items:
                                    (dataControl.qualificationModel ?? [])
                                        .map((model) {
                                      return DropdownMenuItem<
                                          QualificationModel>(
                                        value: model,
                                        child: Text(model.name),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      dataControl.selectedQualification
                                          .value = newValue;
                                      dataControl.selectQualificationId(
                                          newValue!.id);
                                      // dataControl.selectedQualificationId.value = newValue.id;
                                    },
                                  ))
                            ],
                          ),
                          sizedBoxDefault(),
                          Obx(() {
                            return UnderlineTextfield(
                              onTap: () {
                                Get.dialog(SpecializationDialog());
                              },
                              label: 'Specialization',
                              hint: 'Select Specialization',
                              controller: TextEditingController(
                                text: dataControl
                                    .selectedSpecializationIds.isNotEmpty
                                    ? dataControl.specializationModel!
                                    .where((element) => dataControl
                                    .selectedSpecializationIds
                                    .contains(element.id))
                                    .map((e) => e.name)
                                    .join(', ')
                                    : '',
                              ),

                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a specialization';
                                }
                                return null;
                              },
                              readOnly:
                              true, // Makes the TextField read-only (to show the selected specialization)
                            );
                          }),
                          sizedBoxDefault(),
                          UnderlineTextfield(
                            label: 'Address',
                            hint: 'Write address here...',
                            controller: addressController,
                            maxLines: 2,
                            showSuffixIcon: false,
                            validation: helperControl.validateAddress,
                          ),
                          SizedBox(height: 16.0),
                          UnderlineTextfield(
                            label: 'Create Password',
                            hint: '123456xyz',
                            controller: createPasswordController,
                            obscureText: true,
                            showSuffixIcon: true,
                            validation: helperControl.validatePassword,
                          ),
                          SizedBox(height: 16.0),
                          UnderlineTextfield(
                            label: 'Confirm Password',
                            hint: '123456xyz',
                            controller: confirmPasswordController,
                            obscureText: true,
                            showSuffixIcon: true,
                            validation: (value) =>
                                helperControl.validateConfirmPassword(
                                    value, createPasswordController.text),
                          ),
                          SizedBox(height: 24.0),
                          CustomButtonWidget(buttonText: "Update",onPressed: () {
            if(formKey.currentState!.validate()){


              trainerControl.updateTrainer(
                fullName: trainerNameController.text,
                dateOfBirth: dobController.text,
                gender: gender.toString(),
                phoneNumber: phoneController.text,
                emailAddress: emailController.text,
                address: addressController.text,
                instaProfileLink: instaController.text,
                facebookProfileLink: facebookController.text,
                specializations: dataControl
                    .selectedSpecializationIds,
                qualification: dataControl
                    .selectedQualificationId
                    .toString(),
                experienceInYear: yearsOfExperience.text,
                password: confirmPasswordController.text,
                trainerId: trainerData['user_id'].toString(),
                  photoFilePath :  helperControl.pickedImage != null
                      ? File(helperControl.pickedImage!.path)
                      : null,

            );
            }
                          },),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
      }),

    );
  }
}
