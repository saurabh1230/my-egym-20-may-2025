import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myegym/controllers/auth_controller.dart';
import 'package:myegym/helper/route_helper.dart';
import 'package:myegym/utils/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _route();

    super.initState();
  }

  void _route() {
    final AuthController authController = Get.find<AuthController>();
    Timer(const Duration(seconds: 1), () async {
      if (authController.isLoggedIn()) {
        if (authController.getLoginType() == "owner") {
          Get.offNamed(RouteHelper.getOwnerDashboard());
        } else if (authController.getLoginType() == "trainer") {
          Get.offNamed(RouteHelper.getTrainerDashboard());
        } else {
          Get.offNamed(RouteHelper.getUserDashboard());
        }
      } else {
        Get.offNamed(RouteHelper.getLogin());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        height: Get.size.height,
        width: Get.size.width,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(),
        child: SvgPicture.asset(
          Images.splashScreenBG,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
