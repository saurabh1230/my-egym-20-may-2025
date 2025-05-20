import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:myegym/app/user/home/components/multiple_banner_components.dart';
import 'package:myegym/app/user/home/components/plan_subscribed_component.dart';
import 'package:myegym/app/user/home/components/weekly_progress_component.dart';
import 'package:myegym/app/user/home/workout.dart';
import 'package:myegym/app/widgets/custom_app.dart';
import 'package:myegym/app/widgets/custom_single_banner_component.dart';
import 'package:myegym/app/widgets/gradient_bar_chart.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/images.dart';
import 'package:myegym/utils/styles.dart';
import 'package:flutter/material.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Welcome",
        isLogo: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Discover How To Shape The Body",
                style: notoSansExtraBold.copyWith(
                    fontSize: Dimensions.fontSize24, color: Colors.white),
              ),
              WeeklyProgressComponent(),
              CustomSingleBannerComponent(
                title: "Today’s Workout",
                img: "assets/images/today_demo_banner.png",
                tap: () {
                  Get.to(() => WorkoutScreen());
                },
              ),
              PlanSubscribedComponent(
                dataTitle1: "BodyFit",
                data1: "Your Gym",
                dataTitle2: "Submit",
                data2: "Trainer",
                dataTitle3: "6 Months",
                data3: "Membership",
                heading1: 'Plan subscribed',
                heading2: 'Weight Maintenance',
              ),
              CustomSingleBannerComponent(
                title: "Your Diet Plans",
                img: "assets/images/ic_diet_banner_img.png",
                tap: () {},
              ),
              MultipleBannerComponents()
            ],
          ),
        ),
      ),
    );
  }
}
