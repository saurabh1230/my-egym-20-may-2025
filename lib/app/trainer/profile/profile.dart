import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:myegym/app/owner/drawer/owner_drawer.dart';
import 'package:myegym/app/owner/trainers/update_trainer.dart';
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
import 'package:myegym/controllers/auth_controller.dart';
import 'package:myegym/controllers/trainer_controllers.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/images.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';
import 'package:flutter/material.dart';

import '../../../data/repo/trainer_repo.dart';
import '../../../utils/date_converter.dart';
import '../../widgets/custom_network_image.dart';

class TrainerProfile extends StatelessWidget {
  TrainerProfile({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Get.put(TrainerRepo(apiClient: Get.find()));
    Get.put(TrainerController(trainerRepo: Get.find()));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<TrainerController>().getTrainerProfile();
    });
    return Scaffold(
      key: _scaffoldKey,
      drawer: const OwnerDrawer(),
      appBar: CustomAppBar(
        title: "Profile",
      ),
      body: GetBuilder<TrainerController>(builder: (trainerControl) {
        final detailsData = trainerControl.trainerProfile;
        if (detailsData == null) {
          return Center(child: CircularProgressIndicator());
        }

        return Stack(
          children: [
            SizedBox(height: Get.size.height,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Center(
                      //   child: Image.asset(
                      //     "assets/images/ic_gym_demo_logo.png",
                      //     width: 280,
                      //   ),
                      // ),
                      CustomDecoratedContainer(
                          child: Row(
                            children: [
                              CustomNetworkImageWidget(
                                  height: 80,
                                  width: 80,
                                  image: detailsData['photo'] ?? ""),
                              // Image.asset(
                              //   "assets/icons/ic_profile_demo.png",
                              //   height: 80,
                              //   width: 80,
                              // ),
                              sizedBoxW10(),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      "Trainer",
                                      style: notoSansRegular.copyWith(
                                          fontSize: Dimensions.fontSize14,
                                          color: Colors.white.withOpacity(0.60)),
                                    ),
                                    Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      detailsData['full_name'] ?? "MyEGYM Trainer",
                                      style: notoSansRegular.copyWith(color: Colors.white),
                                    ),
                                    Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      detailsData['phone_number'] ?? "N/A",
                                      // "+91 9876543210",
                                      style: notoSansRegular.copyWith(color: Colors.white),
                                    ),
                                    Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      detailsData['email'] ?? "N/A",
                                      // "bodywisegym@gmail.com",
                                      style: notoSansRegular.copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                      sizedBox20(),
                      Text(
                        "Profile Details",
                        style: notoSansSemiBold.copyWith(
                            fontSize: Dimensions.fontSize20, color: Colors.white),
                      ),
                      sizedBox10(),
                      row(context, title: 'Years of Experience:', data:  detailsData['experienceinyear'] ?? "N/A",),
                      row(context, title: 'Salary:', data: '₹ 20000'),
                      row(context, title: 'Joining Date:', data: DateFormatterOnlyDate.formatToIndianDate(detailsData['created_at'] ?? "N/A"),),
                      row(context,
                          title: 'Address:',
                          data: detailsData['address'] ?? "N/A"),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: Dimensions.paddingSizeDefault,
              left: Dimensions.paddingSizeDefault,right: Dimensions.paddingSizeDefault,
              child: CustomButtonWidget(
                onPressed: () {
                  print('CHECK PRINT : ${detailsData}');

                  // Get.to(() => UpdateTrainer(
                  //   isTrainerProfile: true,
                  //   data: detailsData, name: detailsData['full_name'] ?? "MyEGYM Trainer",
                  // ));
                }, buttonText: 'Update Profile',

              ),
            ),
          ],
        );
      })

    );
  }

  Padding row(BuildContext context,
      {required String title, required String data}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: notoSansRegular.copyWith(
                  fontSize: Dimensions.fontSize14,
                  color: Theme.of(context).hintColor),
            ),
          ),
          Expanded(
            child: Text(
              textAlign: TextAlign.end,
              data,
              style: notoSansRegular.copyWith(
                  fontSize: Dimensions.fontSize14, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
