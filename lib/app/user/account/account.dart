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

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Account",
        isLogo: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomDecoratedContainer(
                  child: Row(
                children: [
                  Image.asset(
                    "assets/icons/ic_profile_demo.png",
                    height: 80,
                    width: 80,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          "Username",
                          style: notoSansRegular.copyWith(color: Colors.white),
                        ),
                        Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          "+91 9876543210",
                          style: notoSansRegular.copyWith(color: Colors.white),
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
            ],
          ),
        ),
      ),
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
