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
import 'package:myegym/app/widgets/custom_network_image.dart';
import 'package:myegym/app/widgets/custom_single_banner_component.dart';
import 'package:myegym/app/widgets/gradient_bar_chart.dart';
import 'package:myegym/controllers/auth_controller.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/images.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/member_controller.dart';
import '../../../data/repo/member_repo.dart';

class MyPlans extends StatelessWidget {
  const MyPlans({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MemberRepo(apiClient: Get.find()));
    Get.lazyPut(() => MemberController(memberRepo: Get.find()));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<MemberController>().getMemberDetails(id: Get.find<AuthController>().getUserid().toString());
    });

    return Scaffold(
      appBar: CustomAppBar(
        title: "My Plans",
        isLogo: true,
      ),
      body: SingleChildScrollView(
        child: GetBuilder<MemberController>(builder: (controller) {
          final data = controller.memberDetails;
          if(data == null || data.isEmpty) {
            return SizedBox();
          }

          return  Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // sizedBox5(),
                // CustomDecoratedContainer(
                //     child: Row(
                //       children: [
                //         Expanded(
                //           child: CustomDecoratedContainer(
                //             color: Theme.of(context).primaryColor,
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text(
                //                   "Membership",
                //                   style: notoSansRegular.copyWith(
                //                     fontSize: Dimensions.fontSize14,
                //                     color: Colors.white.withOpacity(0.60),
                //                   ),
                //                 ),
                //                 Text(
                //                   "6 Months",
                //                   style: notoSansMedium.copyWith(
                //                     color: Colors.white,
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //         sizedBoxW15(),
                //         Expanded(
                //           child: CustomDecoratedContainer(
                //             color: Theme.of(context).primaryColor,
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text(
                //                   "Membership",
                //                   style: notoSansRegular.copyWith(
                //                     fontSize: Dimensions.fontSize14,
                //                     color: Colors.white.withOpacity(0.60),
                //                   ),
                //                 ),
                //                 Text(
                //                   "6 Months",
                //                   style: notoSansMedium.copyWith(
                //                     color: Colors.white,
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ],
                //     )),
                // sizedBox10(),
                // CustomButtonWidget(
                //   transparent: true,
                //   height: 40,
                //   fontSize: Dimensions.fontSize14,
                //   buttonText: "Update Plan",
                //   onPressed: () {},
                // ),
                sizedBoxDefault(),





                if (data['workout_plans'] != null && data['workout_plans'].isNotEmpty) ...[
                  Text("Workout Plans", style: notoSansBold.copyWith(fontSize: 16,
                      color: Colors.white)),
                  sizedBox10(),
                  ...List.generate(data['workout_plans'].length, (index) {
                    final plan = data['workout_plans'][index];
                    return Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Subscribed Workout Plans",
                          style: notoSansRegular.copyWith(
                              fontSize: Dimensions.fontSize14, color: Colors.white),
                        ),
                        sizedBoxDefault(),
                        CustomNetworkImageWidget(
                          radius: 10,
                            height: 160,
                            image: "${plan['workout']!['image_url'] ?? 'not Added'}"),
                        sizedBox10(),
                        Text("${plan['workout']['goals']['name']} Plan".toUpperCase(),
                          style: notoSansRegular.copyWith(
                            color: Colors.white,
                            fontSize: 14
                          ),),
                        Text("${plan['package']['name']} PLAN",
                          style: notoSansRegular.copyWith(
                              color: Colors.white.withOpacity(0.60),
                              fontSize: 14
                          ),),
                        sizedBox20(),
                        Row(
                          children: [
                            Expanded(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("${plan['workoutplan_start_date']}",
                                    style: notoSansSemiBold.copyWith(
                                      color: Colors.white,
                                      fontSize: Dimensions.fontSize14,

                                    ),),
                                  Text("Plan Subscribed On",
                                    style: notoSansSemiBold.copyWith(

                                        fontSize: Dimensions.fontSize14,
                                      color: Colors.white.withOpacity(0.60),
                                    ),),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("${plan['workoutplan_end_date']}",
                                    style: notoSansSemiBold.copyWith(
                                      color: Colors.white,
                                      fontSize: Dimensions.fontSize14,

                                    ),),
                                  Text("Subscribed End",
                                    style: notoSansSemiBold.copyWith(
                                        fontSize: Dimensions.fontSize14,
                                      color: Colors.white.withOpacity(0.60),
                                    ),),
                                ],
                              ),
                            ),
                          ],
                        ),
                        sizedBoxDefault(),
                        Text("Amount: ₹${plan['paid_amount']}",
                          style: notoSansRegular.copyWith(
                              color: Colors.white
                          ),),

                      ],
                    );
                  }),
                ],
                sizedBoxDefault(),

                if (data['personal_trainings'] != null && data['personal_trainings'].isNotEmpty) ...[
                  Text("Personal Trainings", style: notoSansBold.copyWith(fontSize: 16,
                      color: Colors.white)),
                  sizedBox10(),
                  ...List.generate(data['personal_trainings'].length, (index) {
                    final training = data['personal_trainings'][index];
                    return Column(
                      children: [

                        CustomDecoratedContainer(
                          color: Theme.of(context).cardColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${training['plan']['training_plan']}".toUpperCase(),
                                style: notoSansSemiBold.copyWith(
                                  color: Colors.black,
                                ),),
                              Text("Trainer: ${training['staff']['name']}".toUpperCase(),
                                style: notoSansSemiBold.copyWith(
                                  color: Colors.black.withOpacity(0.60),
                                  fontSize: Dimensions.fontSize14,

                                ),),
                              sizedBox20(),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("${training['plan']['training_start_date']}",
                                          style: notoSansSemiBold.copyWith(
                                            fontSize: Dimensions.fontSize14,

                                          ),),
                                        Text("Plan Subscribed On",
                                          style: notoSansSemiBold.copyWith(
                                              fontSize: Dimensions.fontSize14,
                                              color: Theme.of(context).primaryColor
                                          ),),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("${training['plan']['training_end_date']}",
                                          style: notoSansSemiBold.copyWith(
                                            fontSize: Dimensions.fontSize14,

                                          ),),
                                        Text("Subscribed End",
                                          style: notoSansSemiBold.copyWith(
                                              fontSize: Dimensions.fontSize14,
                                              color: Theme.of(context).primaryColor
                                          ),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              sizedBoxDefault(),

                              Center(
                                child: Text(maxLines: 2,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  "Goal ${training['workout']?['goals']?['name'] ?? 'not Added'}",
                                  style: notoSansRegular.copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),


                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                  sizedBoxDefault(),
                ],
                // sizedBox100(),
                // sizedBox100(),
                // SubscribedWorkout(),
                // sizedBoxDefault(),
                // PlanSubscribedComponent(
                //   isShowTitle: true,
                //   dataTitle1: "45 gm",
                //   data1: "Protein Intake",
                //   dataTitle2: "Protein Intake",
                //   data2: "Calorie Burn",
                //   dataTitle3: "45 gm",
                //   data3: "Carbohydrates",
                //   heading1: 'Fitness Goal',
                //   heading2: 'Weight Gain',
                // ),
              ],
            ),
          );
        })


      ),
    );
  }
}
