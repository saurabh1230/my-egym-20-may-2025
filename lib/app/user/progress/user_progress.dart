import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:myegym/app/user/home/components/multiple_banner_components.dart';
import 'package:myegym/app/user/home/components/plan_subscribed_component.dart';
import 'package:myegym/app/user/home/components/weekly_progress_component.dart';
import 'package:myegym/app/user/progress/progress_details_card.dart';
import 'package:myegym/app/user/progress/update_status_bottomsheet.dart';
import 'package:myegym/app/widgets/activity_circle_chart.dart';
import 'package:myegym/app/widgets/custom_app.dart';
import 'package:myegym/app/widgets/custom_button.dart';
import 'package:myegym/app/widgets/custom_containers.dart';
import 'package:myegym/app/widgets/custom_single_banner_component.dart';
import 'package:myegym/app/widgets/gradient_bar_chart.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/images.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProgress extends StatelessWidget {
  const UserProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Your Progress",
        isLogo: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedBox5(),
              CustomDecoratedContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Monitoring",
                      style: notoSansRegular.copyWith(
                          fontSize: Dimensions.fontSize14, color: Colors.white),
                    ),
                    Text(
                      "Daily progress",
                      style: notoSansRegular.copyWith(
                          fontSize: Dimensions.fontSize12,
                          color: Theme.of(context).hintColor),
                    ),
                    SizedBox(
                      height: 150.0, // Adjust as needed
                      child: GradientBarChart(
                        data: [80.0, 95.0, 40.0, 100.0, 55.0, 90.0],
                      ),
                    ),
                  ],
                ),
              ),
              sizedBox10(),
              CustomButtonWidget(
                height: 40,
                fontSize: Dimensions.fontSize14,
                buttonText: "Update Today’s Data",
                onPressed: () {
                  Get.bottomSheet(UpdateStatusBottomsheet());
                },
              ),
              sizedBox10(),
              CustomDecoratedContainer(
                child: Center(
                  child: CircularActivityIndicator(
                    percentage: 89,
                    currentActivity: 15,
                    totalActivity: 20,
                  ),
                ),
              ),
              sizedBoxDefault(),
              Row(
                children: [
                  Expanded(
                      child: ProgressDetailsCard(
                    secondTitle: "Calories Burned",
                    img: Images.svgFast,
                    km1: '45',
                    km2: '60 km',
                  )),
                  sizedBoxW15(),
                  Expanded(
                      child: ProgressDetailsCard(
                    secondTitle: "Calories Burned",
                    img: Images.svgMoon,
                    km1: '21',
                    km2: '25 hrs',
                  )),
                ],
              ),
              sizedBoxDefault(),
              Row(
                children: [
                  Expanded(
                      child: ProgressDetailsCard(
                    secondTitle: "Weight",
                    hideDesc: true,
                    img: Images.svgWeight,
                    secondTitleData: "60 Kg",
                  )),
                  sizedBoxW15(),
                  Expanded(
                      child: ProgressDetailsCard(
                    secondTitle: "Height",
                    hideDesc: true,
                    img: Images.svgMoon,
                    secondTitleData: "180 Cm",
                  )),
                ],
              ),
              sizedBoxDefault(),
              Row(
                children: [
                  Expanded(
                      child: ProgressDetailsCard(
                    secondTitle: "Chest",
                    hideDesc: true,
                    img: Images.svgWeight,
                    secondTitleData: "30 cm",
                  )),
                  sizedBoxW15(),
                  Expanded(
                      child: ProgressDetailsCard(
                    secondTitle: "Biceps",
                    hideDesc: true,
                    img: Images.svgMoon,
                    secondTitleData: "30 cm",
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
