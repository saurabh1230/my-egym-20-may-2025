import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:myegym/app/user/home/components/multiple_banner_components.dart';
import 'package:myegym/app/user/home/components/plan_subscribed_component.dart';
import 'package:myegym/app/user/home/components/weekly_progress_component.dart';
import 'package:myegym/app/user/plan/components/subscribed_workout.dart';
import 'package:myegym/app/user/progress/progress_details_card.dart';
import 'package:myegym/app/widgets/activity_circle_chart.dart';
import 'package:myegym/app/widgets/add_offer_dialog.dart';
import 'package:myegym/app/widgets/custom_app.dart';
import 'package:myegym/app/widgets/custom_button.dart';
import 'package:myegym/app/widgets/custom_containers.dart';
import 'package:myegym/app/widgets/custom_network_image.dart';
import 'package:myegym/app/widgets/custom_single_banner_component.dart';
import 'package:myegym/app/widgets/gradient_bar_chart.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/images.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:myegym/app/widgets/confirmation_dialog.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/member_controller.dart';
import '../../../data/repo/member_repo.dart';
import '../../../helper/route_helper.dart';
class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MemberRepo(apiClient: Get.find()));
    Get.lazyPut(() => MemberController(memberRepo: Get.find()));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<MemberController>().getMemberDetails(id: Get.find<AuthController>().getUserid().toString());
    });

    return Scaffold(
      appBar: CustomAppBar(
        title: "Account",
        isLogo: true,
      ),
      body: GetBuilder<MemberController>(builder: (controller) {
        final data = controller.memberDetails;
        if(data == null || data.isEmpty) {
          return SizedBox();
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomDecoratedContainer(
                    child: Row(
                  children: [
                    CustomNetworkRoundImageWidget(
                     image:  data['member']['image_url'],
                      height: 80,
                      width: 80,
                    ),
                    sizedBoxW15(),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          data['member']?['full_name'] ?? "User",
                            style: notoSansRegular.copyWith(color: Colors.white),
                          ),
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                data['member']?['phone_number'] ?? "N/A",
                                style: notoSansRegular.copyWith(color: Colors.white),
                              ),
                              Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                data['member']?['email'] ?? "N/A",
                                style: notoSansRegular.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )),
                sizedBox20(),
                text(title: 'About myegym', tap: () {}),
                sizedBox5(),
                Divider(),
                text(title: 'Notifications', tap: () {}),
                sizedBox5(),
                Divider(),
                text(title: 'Help Center', tap: () {}),
                sizedBox5(),
                Divider(),
                text(title: 'Privacy Policy', tap: () {}),
                sizedBox5(),
                Divider(),
                text(title: 'Terms & Conditions', tap: () {}),
                sizedBox5(),
                Divider(),
                text(title: 'Rate Us', tap: () {}),
                sizedBox5(),
                Divider(),
                text(title: 'Logout', tap: () {
                  Get.dialog(ConfirmationDialog(
                      icon: Icons.logout,
                      description: "Are You Sure to Logout",
                      onYesPressed: () {
                        Get.toNamed(RouteHelper.getLogin());
                      }));

                }),
                sizedBox5(),
              ],
            ),
          ),
        );
      })
    );
  }

  InkWell text({required String title, required Function() tap}) {
    return InkWell(
      onTap: tap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: notoSansRegular.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
