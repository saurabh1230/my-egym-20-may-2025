import 'package:flutter/material.dart';
import 'package:myegym/app/owner/drawer/components/diet_plan_component.dart';
import 'package:myegym/app/widgets/custom_app.dart';
import 'package:myegym/app/widgets/custom_button.dart';
import 'package:myegym/controllers/plans_controller.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';
import 'package:get/get.dart';

class OwnerPtPlan extends StatelessWidget {
  const OwnerPtPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "PT Plans",
          isBackButtonExist: true,
          isLogo: false,
        ),
        body: GetBuilder<PlansController>(builder: (ptControl) {
          final list = ptControl.ptPlanListing;
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
                          itemCount: 10,
                          shrinkWrap: true,
                          itemBuilder: (_, i) {
                            return Image.asset(
                              "assets/images/ic_workout_demo.png",
                              height: 140,
                              width: Get.size.width,
                              fit: BoxFit.cover,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              sizedBox10(),
                        )
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
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}
