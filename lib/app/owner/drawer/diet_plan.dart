import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:myegym/app/owner/drawer/components/diet_plan_component.dart';
import 'package:myegym/app/widgets/custom_app.dart';
import 'package:myegym/app/widgets/custom_button.dart';
import 'package:myegym/app/widgets/custom_network_image.dart';
import 'package:myegym/controllers/plans_controller.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';

import '../../../utils/theme/light_theme.dart';
import '../../widgets/create_plan_bottomsheet.dart';

class OwnerDietPlan extends StatelessWidget {
  const OwnerDietPlan({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<PlansController>().getDietPlan();
    });

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Diet Plans",
          isBackButtonExist: true,
          isLogo: false,
        ),
        body: GetBuilder<PlansController>(builder: (dietPlan) {
          final list = dietPlan.dietPlanListing;
          final isListEmpty = list == null || list.isEmpty;
          return isListEmpty
              ? Center(
                  child: Text(
                    "No Data Available",
                    style: notoSansRegular.copyWith(color: Colors.white),
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: list.length,
                            itemBuilder: (_,i) {
                          return Column(
                            children: [
                              Stack(
                                children: [
                                  CustomNetworkImageWidget(image: list[i]['image_url'].toString()),
                                  Positioned(
                                    bottom: Dimensions.paddingSizeDefault,
                                    right: Dimensions.paddingSizeDefault,
                                    child: ElevatedButton(style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(primaryRedColor), // your desired color
                                    ),
                                        onPressed: () {}, child: Text("Edit")),
                                  )

                                ],
                              )
                            ],
                          );
                        }, separatorBuilder: (BuildContext context, int index) => sizedBoxDefault(),)
                        // DietPlanComponent(
                        //   title: "Gain Weight Plans",
                        //   lenght: 3,
                        //   img: 'assets/images/ic_workout_demo.png',
                        // ),
                        // DietPlanComponent(
                        //   title: "Gain Weight Plans",
                        //   lenght: 3,
                        //   img: 'assets/images/ic_workout_demo.png',
                        // ),
                        // DietPlanComponent(
                        //   title: "Gain Weight Plans",
                        //   lenght: 3,
                        //   img: 'assets/images/ic_workout_demo.png',
                        // ),
                        // DietPlanComponent(
                        //   title: "Gain Weight Plans",
                        //   lenght: 3,
                        //   img: 'assets/images/ic_workout_demo.png',
                        // ),
                      ],
                    ),
                  ),
                );
        }),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: SingleChildScrollView(
            child: CustomButtonWidget(
              buttonText: "Create New Plan",
              onPressed: () {
                Get.bottomSheet(CreatePlanBottomsheet());
              },
            ),
          ),
        ),
      ),
    );
  }
}
