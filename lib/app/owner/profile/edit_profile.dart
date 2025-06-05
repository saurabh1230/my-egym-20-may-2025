import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myegym/app/widgets/custom_textfield.dart';
import 'package:myegym/controllers/helper_controller.dart';
import 'package:myegym/controllers/profile_controller.dart';

import '../../../data/repo/profile_repo.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';
import '../../../utils/sizeboxes.dart';
import '../../widgets/custom_app.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_network_image.dart';
class EditProfile extends StatefulWidget {
  final Map<String, dynamic> ownerProfileDetails;
  const EditProfile({super.key, required this.ownerProfileDetails});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  String profilePhoto = '';

  final c = Get.put(ProfileRepo(apiClient: Get.find()));
  final controller = Get.put(ProfileController(profileRepo: Get.find()));
  final control = Get.put(HelperController());

  @override
  void initState() {
    super.initState();

    final data = widget.ownerProfileDetails;

    _nameController.text = data['name']?.toString() ?? '';
    _emailController.text = data['email']?.toString() ?? '';
    _phoneController.text = data['phone_number']?.toString() ?? '';
    _passwordController.text = data['password']?.toString() ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Edit Profile", isBackButtonExist: true),
      body: Form(
        key: formKey,
        child: GetBuilder<ProfileController>(builder: (profileControl) {
          return GetBuilder<HelperController>(builder: (helperControl) {
            if (widget.ownerProfileDetails.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
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
                    children: [
                      CustomTextField(
                          showTitle: true,
                          hintText: 'Your Name',
                          controller: _nameController,
                          validation: control.validateName),
                      sizedBoxDefault(),
                      CustomTextField(
                          showTitle: true,
                          hintText: 'Email',
                          controller: _emailController,
                          validation: control.validateEmail),
                      sizedBoxDefault(),
                      CustomTextField(
                          inputType: TextInputType.number,
                          showTitle: true,
                          hintText: 'Phone',
                          controller: _phoneController,
                          validation: control.validatePhone),
                    ],
                  ),
                  sizedBoxDefault(),
                  CustomButtonWidget(
                    isBold: false,
                    buttonText: "Update",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        profileControl.updateProfile(
                          name: _nameController.text,
                          phone: _phoneController.text,
                          profilePhoto: control.pickedImage != null
                              ? File(control.pickedImage!.path)
                              : null,
                          email: _emailController.text,
                        );
                      }
                    },
                  ),
                  sizedBox20(),
                ],
              ),
            );
          });
        }),
      ),
    );
  }
}
