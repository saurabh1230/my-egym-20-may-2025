import 'package:flutter/material.dart';
import 'package:myegym/app/owner/drawer/owner_drawer.dart';
import 'package:myegym/app/owner/home/component/owner_overview_component.dart';
import 'package:myegym/app/trainer/home/components/membership_stats.dart';
import 'package:myegym/app/trainer/home/components/revenue_matrics.dart';
import 'package:myegym/app/trainer/home/components/take_charge_component.dart';
import 'package:myegym/app/widgets/custom_app.dart';
import 'package:myegym/app/widgets/custom_containers.dart';
import 'package:myegym/controllers/owner_controller.dart';
import 'package:myegym/data/repo/owner_repo.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/styles.dart';
import 'package:get/get.dart';

class OwnerHome extends StatelessWidget {
  OwnerHome({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => OwnerRepo(apiClient: Get.find()));
    Get.lazyPut(() => OwnerController(ownerRepo: Get.find()));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<OwnerController>().getOwnerDashboardDetailsApi();
    });
    return Scaffold(
      key: _scaffoldKey,
      drawer: const OwnerDrawer(),
      appBar: CustomAppBar(
        title: "Welcome Back Owner",
        // isLogo: true,
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
              OwnerOverviewComponent(),
              CustomDecoratedContainer(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("15",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: notoSansSemiBold.copyWith(
                          fontSize: Dimensions.fontSize24,
                          color: Colors.white)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text("Pending memberships renewal",
                            maxLines: 1,
                            // overflow: TextOverflow.ellipsis,
                            style: notoSansRegular.copyWith(
                                fontSize: Dimensions.fontSize12,
                                color: Theme.of(context).hintColor)),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text("View all",
                            textAlign: TextAlign.end,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: notoSansRegular.copyWith(
                                fontSize: Dimensions.fontSize12,
                                color: Theme.of(context).primaryColor)),
                      ),
                    ],
                  )
                ],
              )),
              MembershipStats(),
              RevenueMetrics(),
            ],
          ),
        ),
      ),
    );
  }
}
