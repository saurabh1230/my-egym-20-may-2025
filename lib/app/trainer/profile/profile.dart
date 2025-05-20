import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:myegym/app/owner/drawer/owner_drawer.dart';
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

class TrainerProfile extends StatelessWidget {
  TrainerProfile({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const OwnerDrawer(),
      appBar: CustomAppBar(
        title: "Profile",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  "assets/images/ic_gym_demo_logo.png",
                  width: 280,
                ),
              ),
              CustomDecoratedContainer(
                  child: Row(
                children: [
                  Image.asset(
                    "assets/icons/ic_profile_demo.png",
                    height: 80,
                    width: 80,
                  ),
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
                          "Trainer Name",
                          style: notoSansRegular.copyWith(color: Colors.white),
                        ),
                        Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          "+91 9876543210",
                          style: notoSansRegular.copyWith(color: Colors.white),
                        ),
                        Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          "bodywisegym@gmail.com",
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
              row(context, title: 'Years of Experience:', data: '1 Year'),
              row(context, title: 'Salary:', data: '₹ 20000'),
              row(context, title: 'Joining Date:', data: '20-02-2026'),
              row(context,
                  title: 'Address:',
                  data: 'Lorem Ipsum is simply dummy text of the printing'),
            ],
          ),
        ),
      ),
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
