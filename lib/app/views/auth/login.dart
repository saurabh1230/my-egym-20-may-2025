import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myegym/app/owner/dashboard/owner_dashboard.dart';
import 'package:myegym/app/trainer/dashboard/trainer_dashboard.dart';
import 'package:myegym/app/user/dashboard/user_dashboard.dart';
import 'package:myegym/app/widgets/custom_button.dart';
import 'package:myegym/app/widgets/custom_textfield.dart';
import 'package:myegym/controllers/auth_controller.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/images.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final emailController = TextEditingController();
  final gymIdController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: formKey,
        child: Scaffold(
            extendBody: true,
            body: GetBuilder<AuthController>(builder: (controller) {
              return SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                    height: Get.size.height,
                    width: Get.size.width,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              Images.appBg,
                            ))),
                    child: Column(
                      children: [
                        sizedBox40(),
                        SvgPicture.asset(
                          height: 120,
                          width: 120,
                          Images.logo,
                          fit: BoxFit.cover,
                        ),
                        sizedBox30(),
                        Text(
                          "LOGIN",
                          style: notoSansBold.copyWith(
                              fontSize: Dimensions.fontSize30),
                        ),
                        Text(
                          "Enter your ID & password to login",
                          style: notoSansRegular.copyWith(
                              fontSize: Dimensions.fontSize14),
                        ),
                        sizedBox10(),
                        CustomTextField(
                          controller: emailController,
                          hintText: "Email Id",
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        sizedBox10(),
                        CustomTextField(
                          controller: gymIdController,
                          hintText: "gymId",
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Gym ID';
                            }
                            return null;
                          },
                        ),
                        sizedBox10(),
                        CustomTextField(
                          controller: passwordController,
                          isPassword: true,
                          hintText: "Password",
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                      ],
                    )),
              );
            }),
            bottomNavigationBar:
                GetBuilder<AuthController>(builder: (controller) {
              return Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: SingleChildScrollView(
                  child: CustomButtonWidget(
                    buttonText: "Login",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        controller.loginApi(
                            email: emailController.text,
                            gymId: gymIdController.text,
                            password: passwordController.text);
                      }
                    },
                  ),
                ),
              );
            })),
      ),
    );
  }
}
