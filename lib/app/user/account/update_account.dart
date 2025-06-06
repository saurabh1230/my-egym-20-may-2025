import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myegym/app/widgets/custom_app.dart';
import 'package:myegym/app/widgets/custom_button.dart';
import 'package:myegym/app/widgets/custom_textfield.dart';
import 'package:myegym/controllers/helper_controller.dart';
import 'package:myegym/controllers/member_controller.dart';
import 'package:myegym/data/repo/member_repo.dart';
import 'package:myegym/helper/validations.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';

import '../../widgets/custom_network_image.dart';
import '../../widgets/underline_textfield.dart';

class UpdateAccount extends StatelessWidget {
  final Map <String,dynamic> data;
   UpdateAccount({super.key, required this.data});

   final _fullNameController = TextEditingController();
  final _addressNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _genderController = TextEditingController();
  final _ageController = TextEditingController();
  final _dobController = TextEditingController();
  final RxString contactRelation = 'Other'.obs;
  final RxString relation = 'Single'.obs;
  final TextEditingController emergencyNameController = TextEditingController();
  final TextEditingController emergencyPhoneController =
  TextEditingController();
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MemberRepo(apiClient: Get.find()));
    Get.lazyPut(() => MemberController(memberRepo: Get.find()));
    Get.lazyPut(() => HelperController());
    _fullNameController.text = data['full_name'] ?? '';
    _addressNameController.text = data['address'] ?? '';
    _emailController.text = data['email'] ?? '';
    _genderController.text = data['gender'] ?? '';
    _ageController.text = data['age'].toString() ?? '';
    _dobController.text = data['date_of_birth'].toString() ?? '';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Update Profile",isBackButtonExist: true,),
      body: GetBuilder<MemberController>(builder: (controller) {
        return GetBuilder<HelperController>(builder: (helpControl) {
          return Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Stack(
              children: [
                SizedBox(height: Get.size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomNetworkRoundImageWidget(
                          image:  data['image_url'].toString(),
                          height: 100,
                          width: 100,
                        ),
                        sizedBoxDefault(),
                        CustomTextField(
                          showTitle: true,
                          readOnly: true,
                          capitalization: TextCapitalization.words,
                          hintText: "Full Name",
                          controller: _fullNameController,
                          validation: Validators.validate,
                        ),
                        sizedBoxDefault(),
                        CustomTextField(
                          capitalization: TextCapitalization.words,
                          showTitle: true,
                          readOnly: true,
                          hintText: "Address",
                          controller: _addressNameController,
                          validation: Validators.validate,
                        ),
                        sizedBoxDefault(),
                        CustomTextField(
                          showTitle: true,
                          hintText: "Email (non-editable)",
                          readOnly: true,
                          controller: _emailController,
                          validation: Validators.validate,
                        ),
                        sizedBoxDefault(),
                        CustomTextField(
                          showTitle: true,
                          readOnly: true,
                          hintText: "Gender (non-editable)",
                          controller: _genderController,
                          validation: Validators.validate,
                        ),
                        sizedBoxDefault(),
                        CustomTextField(
                          showTitle: true,   readOnly: true,

                          hintText: "Date Of Birth (non-editable)" ,
                          controller: _dobController,
                          validation: Validators.validate,
                        ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: UnderlineTextfield(
                        //         label: 'Emergency Contact Name',
                        //         hint: 'Emergency Contact Name',
                        //         controller: emergencyNameController,
                        //         maxLines: 2,
                        //         showSuffixIcon: false,
                        //         validation: Validators.validateName,
                        //       ),
                        //     ),
                        //     SizedBox(width: 16.0),
                        //     Expanded(
                        //       child: Column(
                        //         crossAxisAlignment:
                        //         CrossAxisAlignment.start,
                        //         children: [
                        //           Text(
                        //             'Emergency Contact Relationship',
                        //             style: TextStyle(
                        //               fontSize: 12.0,
                        //               color: Colors.grey[600],
                        //             ),
                        //           ),
                        //           Obx(
                        //                 () => DropdownButtonFormField<String>(
                        //               decoration: InputDecoration(
                        //                 border: UnderlineInputBorder(),
                        //               ),
                        //               value: contactRelation.value,
                        //               items: <String>[
                        //                 'Father',
                        //                 'Mother',
                        //                 'Sister',
                        //                 'Friend',
                        //                 'Other',
                        //                 'Spouse',
                        //               ].map<DropdownMenuItem<String>>(
                        //                       (String value) {
                        //                     return DropdownMenuItem<String>(
                        //                       value: value,
                        //                       child: Text(value),
                        //                     );
                        //                   }).toList(),
                        //               onChanged: (String? newValue) {
                        //                 if (newValue != null) {
                        //                   contactRelation.value =
                        //                       newValue;
                        //                 }
                        //               },
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // sizedBoxDefault(),
                        // UnderlineTextfield(
                        //   maxLength: 10,
                        //   label: 'Emergency Contact Number',
                        //   hint: 'Emergency Contact Number',
                        //   controller: emergencyPhoneController,
                        //   keyboardType: TextInputType.phone,
                        //   showSuffixIcon: false,
                        //   validation: Validators.validatePhone,
                        // ),
                        // sizedBoxDefault(),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text(
                        //       'Emergency Contact Relationship Status',
                        //       style: TextStyle(
                        //         fontSize: 12.0,
                        //         color: Colors.grey[600],
                        //       ),
                        //     ),
                        //     Obx(
                        //           () => DropdownButtonFormField<String>(
                        //         decoration: InputDecoration(
                        //           border: UnderlineInputBorder(),
                        //         ),
                        //         value: relation.value,
                        //         items: <String>[
                        //           'Single',
                        //           'Married',
                        //           'Divorced',
                        //           'Separated',
                        //           'Engaged',
                        //           'Widowed',
                        //         ].map<DropdownMenuItem<String>>(
                        //                 (String value) {
                        //               return DropdownMenuItem<String>(
                        //                 value: value,
                        //                 child: Text(value),
                        //               );
                        //             }).toList(),
                        //         onChanged: (String? newValue) {
                        //           if (newValue != null) {
                        //             relation.value = newValue;
                        //           }
                        //         },
                        //       ),
                        //     ),
                        //   ],
                        // ),




                      ],
                    ),
                  ),
                ),
                // Positioned(bottom: Dimensions.paddingSizeDefault,
                //   left: 0,right: 0,
                //   child: CustomButtonWidget(buttonText: "Update",
                //   onPressed: () {
                //     controller.memberProfileUpdate(address: _addressNameController.text.trim(),
                //         name: _fullNameController.text.trim(),
                //         dob: _dobController.text.trim(),
                //         gender: _genderController.text.trim());
                //
                //   },),
                //
                // )
              ],
            ),
          );
        });
      })
    );
  }
}
