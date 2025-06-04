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
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Column(
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
                  isFromOwner! ?

                  Column(
                    children: [
                      CustomButtonWidget(buttonText: "Assing Personal Trainer",
                      onPressed: () {
                        Get.to(() => AddPersonalTrainer(memberID: userId!, memberName: name));
                      },),
                      sizedBoxDefault(),
                      CustomButtonWidget(buttonText: "Assing Workout Plan",
                        onPressed: () {
                          Get.to(() => AssignWorkoutPlan(memberID: userId!, memberName: name));

                        },),
                    ],
                  ) :
                      SizedBox()


                ],
              ),
            ),
          );
        }));
  }
}
