import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:myegym/app/user/home/components/multiple_banner_components.dart';
import 'package:myegym/app/user/home/components/plan_subscribed_component.dart';
import 'package:myegym/app/user/home/components/weekly_progress_component.dart';
import 'package:myegym/app/user/plan/components/subscribed_workout.dart';
import 'package:myegym/app/user/progress/progress_details_card.dart';
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

class MyPlans extends StatelessWidget {
  const MyPlans({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "My Plans",
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
                  child: Row(
                children: [
                  Expanded(
                    child: CustomDecoratedContainer(
                      color: Theme.of(context).primaryColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Membership",
                            style: notoSansRegular.copyWith(
                              fontSize: Dimensions.fontSize14,
                              color: Colors.white.withOpacity(0.60),
                            ),
                          ),
                          Text(
                            "6 Months",
                            style: notoSansMedium.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  sizedBoxW15(),
                  Expanded(
                    child: CustomDecoratedContainer(
                      color: Theme.of(context).primaryColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Membership",
                            style: notoSansRegular.copyWith(
                              fontSize: Dimensions.fontSize14,
                              color: Colors.white.withOpacity(0.60),
                            ),
                          ),
                          Text(
                            "6 Months",
                            style: notoSansMedium.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
              sizedBox10(),
              CustomButtonWidget(
                transparent: true,
                height: 40,
                fontSize: Dimensions.fontSize14,
                buttonText: "Update Plan",
                onPressed: () {},
              ),
              sizedBoxDefault(),
              SubscribedWorkout(),
              sizedBoxDefault(),
              PlanSubscribedComponent(
                isShowTitle: true,
                dataTitle1: "45 gm",
                data1: "Protein Intake",
                dataTitle2: "Protein Intake",
                data2: "Calorie Burn",
                dataTitle3: "45 gm",
                data3: "Carbohydrates",
                heading1: 'Fitness Goal',
                heading2: 'Weight Gain',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
