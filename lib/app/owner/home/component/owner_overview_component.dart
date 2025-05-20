import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myegym/app/trainer/members/components/add_member_screen.dart';
import 'package:myegym/app/widgets/custom_containers.dart';
import 'package:myegym/controllers/owner_controller.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/styles.dart';

import '../../../widgets/add_trainer_bottomsheet.dart';
class OwnerOverviewComponent extends StatelessWidget {
  const OwnerOverviewComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OwnerController>(builder: (ownerControl) {
      final data = ownerControl.OwnerDashboardDetails;

      if (data == null) {
        return const SizedBox();
      }

      final List<DashboardItemData> dashboardItems = [
        DashboardItemData(
          title: 'Total Trainer',
          count: data['total_trainer'].toString(),
          actionText: '+ Add Trainer',
          highlighted: true, tap: () {
          Get.bottomSheet(
            AddNewTrainerBottomSheet(),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.0)),
            ),
          );
        },

        ),
        DashboardItemData(
          title: 'Total Active Members',
          count: data['total_active_members'].toString(),
          actionText: '+ Add Member', tap: () {
            Get.to(() => AddMemberScreen());
        },
        ),
        DashboardItemData(
          title: 'Total Expired Members',
          count: data['total_expired_members'].toString(),
          actionText: '+ Renew Member', tap: () {  },
        ),
        DashboardItemData(
          title: 'Total Workout Plans',
          count: data['total_workout_plans'].toString(),
          actionText: '+ Add Plan', tap: () {  },
        ),
        DashboardItemData(
          title: 'Total Diet Plans',
          count: data['total_diet_plans'].toString(),
          actionText: '+ Add Plan', tap: () {  },
        ),
      ];

      return SizedBox(
        height: 300,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 1.1,
          ),
          padding: const EdgeInsets.all(16.0),
          itemCount: dashboardItems.length,
          itemBuilder: (BuildContext context, int index) {
            return DashboardItem(data: dashboardItems[index]);
          },
        ),
      );
    });
  }
}

class DashboardItemData {
  final String title;
  final String count;
  final String actionText;
  final bool highlighted;
  final Function() tap;

  DashboardItemData( {
    required this.title,
    required this.count,
    required this.actionText,
    required this.tap,
    this.highlighted = false,

  });
}

class DashboardItem extends StatelessWidget {
  final DashboardItemData data;

  const DashboardItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomDecoratedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(data.count,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: notoSansSemiBold.copyWith(
                  fontSize: Dimensions.fontSize24, color: Colors.white)),
          Text(data.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: notoSansRegular.copyWith(
                  fontSize: Dimensions.fontSize12,
                  color: Theme.of(context).hintColor)),
          TextButton(
            onPressed: data.tap,
            child: Text(data.actionText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: notoSansRegular.copyWith(
                    fontSize: Dimensions.fontSize12,
                    color: Theme.of(context).primaryColor)),
          ),
        ],
      ),
    );
  }
}
