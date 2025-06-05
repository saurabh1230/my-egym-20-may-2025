import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myegym/app/widgets/custom_app.dart';
import 'package:myegym/app/widgets/custom_button.dart';
import 'package:myegym/app/widgets/custom_network_image.dart';
import 'package:myegym/app/widgets/detail_infobox.dart';
import 'package:myegym/controllers/member_controller.dart';
import 'package:myegym/controllers/owner_controller.dart';
import 'package:myegym/data/repo/member_repo.dart';
import 'package:myegym/utils/app_constants.dart';
import 'package:myegym/utils/dimensions.dart';

import '../../../utils/sizeboxes.dart';
import '../../../utils/styles.dart';
import '../../owner/assign/assign_workout_plan.dart';
import '../../owner/drawer/add_personal_trainer.dart';
import '../../widgets/custom_containers.dart';

class MemberDetailsScreen extends StatelessWidget {
  final String id;
  final String? userId;
  final String name;
  final bool? isFromOwner;
  const MemberDetailsScreen({super.key, required this.id, required this.name, this.isFromOwner = false,  this.userId});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MemberRepo(apiClient: Get.find()));
    Get.lazyPut(() => MemberController(memberRepo: Get.find()));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("User Id : ${userId}");
      Get.find<MemberController>().getMemberDetails(id: userId!);
    });

    return Scaffold(
        appBar: CustomAppBar(title: name,isBackButtonExist: true,),
        body: GetBuilder<MemberController>(builder: (ownerControl) {
          final data = ownerControl.memberDetails;
          if(data == null || data.isEmpty) {
             return SizedBox();
          }
          print('Data : ${ownerControl.memberDetails}');
          return Stack(
            children: [
              SizedBox(
                height: Get.size.height,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomDecoratedContainer(
                          color: Theme.of(context).cardColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CustomNetworkRoundImageWidget(
                                    height: 80,width: 80,
                                      image: "${data['member']['image_url']}"),
                                  sizedBoxW10(),
                                  Flexible(
                                    child: Column(
                                      children: [
                                        Text(
                                          name,
                                          style: notoSansSemiBold.copyWith(
                                            color: Theme.of(context).disabledColor.withOpacity(0.70),
                                            fontSize: Dimensions.fontSize18,
                                          ),
                                        ),
                                        // Text(
                                        //   name,
                                        //   style: notoSansSemiBold.copyWith(
                                        //     color: Theme.of(context).disabledColor.withOpacity(0.70),
                                        //     fontSize: Dimensions.fontSize18,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                                sizedBox10(),
                                Row(
                                  children: [
                                    Expanded(child: DetailInfoTextbox(title: "Phone Number", data: data['member']['phone_number'] ?? "N/A")),
                                    Expanded(child: DetailInfoTextbox(title: "Phone Number", data: data['member']['email'] ?? "N/A")),
                                  ],
                                ),
                              Row(
                                children: [
                                  Expanded(child: DetailInfoTextbox(title: "Gender", data: data['member']['gender'] ?? "N/A")),
                                  Expanded(child: DetailInfoTextbox(title: "Age", data: data['member']['age'].toString())),
                                ],
                              ),
                            ],
                          ),
                        ),

                        sizedBoxDefault(),
                        // Show Personal Trainings
                        if (data['personal_trainings'] != null && data['personal_trainings'].isNotEmpty) ...[
                          Text("Personal Trainings", style: notoSansBold.copyWith(fontSize: 16,
                              color: Colors.white)),
                          sizedBox10(),
                          ...List.generate(data['personal_trainings'].length, (index) {
                            final training = data['personal_trainings'][index];
                            return CustomDecoratedContainer(
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
                                  isFromOwner! ?
                                  Align(alignment: Alignment.centerRight,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context).primaryColor),
                                        onPressed: () {
                                          Get.to(() => AddPersonalTrainer(memberID: userId!, memberName: name,isUpdate: true,
                                          personalPlanId: training['id'].toString(),
                                          trainerId: training['trainer_id'].toString(),
                                            trainingPlanId: training['plan_id'].toString(),

                                          ));

                                        }, child: Text('Update'))
                                  ) : SizedBox(),
                                ],
                              ),
                            );
                          }),
                          sizedBoxDefault(),
                        ],

                      // Show Workout Plans
                        if (data['workout_plans'] != null && data['workout_plans'].isNotEmpty) ...[
                          Text("Workout Plans", style: notoSansBold.copyWith(fontSize: 16,
                          color: Colors.white)),
                          sizedBox10(),
                          ...List.generate(data['workout_plans'].length, (index) {
                            final plan = data['workout_plans'][index];
                            return CustomDecoratedContainer(
                              color: Theme.of(context).cardColor,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${plan['workout']['goals']['name']}".toUpperCase(),
                                    style: notoSansSemiBold.copyWith(
                                      color: Colors.black,
                                    ),),
                                  Text("${plan['package']['name']} PLAN",
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
                                            Text("${plan['workoutplan_start_date']}",
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
                                            Text("${plan['workoutplan_end_date']}",
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
                                  // Text("End: ${plan['workoutplan_end_date']}"),
                                  Center(child: Text("Amount: ₹${plan['paid_amount']}",
                                  style: notoSansRegular.copyWith(
                                    color: Theme.of(context).primaryColor
                                  ),)),
                                  // Text("Due: ₹${plan['due_amount']}"),
                                ],
                              ),
                            );
                          }),
                        ],
                        sizedBox100(),
                        sizedBox100()


                      ],
                    ),
                  ),
                ),
              ),
              Positioned(bottom: Dimensions.paddingSizeDefault,
                left: 8,
                right: 8,
                child:

                Column(
                  children: [
                  isFromOwner! ?
                    CustomButtonWidget(buttonText: "Assing Personal Trainer",
                      onPressed: () {
                        Get.to(() => AddPersonalTrainer(memberID: userId!, memberName: name));
                      },) :SizedBox(),
                    sizedBoxDefault(),
                    CustomButtonWidget(buttonText: "Assing Workout Plan",
                      onPressed: () {
                        Get.to(() => AssignWorkoutPlan(memberID: userId!, memberName: name));

                      },),
                  ],
                )


              ),
            ],
          );
        }));
  }
}
