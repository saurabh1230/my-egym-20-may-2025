import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:myegym/app/trainer/home/components/membership_stats.dart';
import 'package:myegym/app/trainer/home/components/revenue_matrics.dart';
import 'package:myegym/app/trainer/home/components/take_charge_component.dart';
import 'package:myegym/app/user/home/components/multiple_banner_components.dart';
import 'package:myegym/app/user/home/components/plan_subscribed_component.dart';
import 'package:myegym/app/user/home/components/weekly_progress_component.dart';
import 'package:myegym/app/user/home/workout.dart';
import 'package:myegym/app/widgets/custom_app.dart';
import 'package:myegym/app/widgets/custom_single_banner_component.dart';
import 'package:myegym/app/widgets/gradient_bar_chart.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/images.dart';
import 'package:myegym/utils/styles.dart';
import 'package:flutter/material.dart';

import '../trainer_drawer/trainer_drawer.dart';

class TrainerHome extends StatelessWidget {
   TrainerHome({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const TrainerDrawer(),
      appBar: CustomAppBar(
        title: "Welcome",

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Take Charge of Your Gym's Growth",
                style: notoSansExtraBold.copyWith(
                    fontSize: Dimensions.fontSize24, color: Colors.white),
              ),
              GymOverView(),
              MembershipStats(),
              RevenueMetrics(),
            ],
          ),
        ),
      ),
    );
  }
}
