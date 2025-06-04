import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:myegym/app/owner/drawer/components/diet_plan_component.dart';
import 'package:myegym/app/widgets/custom_app.dart';
import 'package:myegym/app/widgets/custom_button.dart';
import 'package:myegym/app/widgets/custom_containers.dart';
import 'package:myegym/app/widgets/custom_network_image.dart';
import 'package:myegym/controllers/plans_controller.dart';
import 'package:myegym/data/repo/plan_repo.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';

import '../../../utils/theme/light_theme.dart';
import '../../widgets/create_plan_bottomsheet.dart';
import 'diet_plan_details.dart';

class OwnerDietPlan extends StatelessWidget {
  const OwnerDietPlan({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PlanRepo(apiClient: Get.find()));
    Get.lazyPut(() => PlansController(planRepo: Get.find()));
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
                              final plan = list[i];
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => PlanDetailsScreen(planData: plan));
                            },
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Column( crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomNetworkImageWidget(image: list[i]['image_url'].toString()),
                                        sizedBox10(),
                                        Text(list[i]['plan_name'].toString(),style: notoSansSemiBold.copyWith(
                                          color: Colors.white
                                        ),maxLines: 2,
                                        overflow: TextOverflow.ellipsis,)
                                      ],
                                    ),
                                    Positioned(
                                      bottom: Dimensions.paddingSize40,
                                      right: Dimensions.paddingSizeDefault,
                                      child: ElevatedButton(style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(primaryRedColor), // your desired color
                                      ),
                                          onPressed: () {}, child: Text("Edit")),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        }, separatorBuilder: (BuildContext context, int index) => sizedBoxDefault(),)
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
