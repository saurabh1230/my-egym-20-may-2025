import 'package:flutter/material.dart';
import 'package:myegym/app/widgets/custom_containers.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/styles.dart';

class GymOverView extends StatelessWidget {
  final List<DashboardItemData> dashboardItems = [
    DashboardItemData(
      title: 'Total Members',
      count: '65',
      actionText: '+ Add Members',
      highlighted: true,
    ),
    DashboardItemData(
      title: 'Pending Renewals',
      count: '15',
      actionText: 'View All',
    ),
    DashboardItemData(
      title: 'Total Workout Plans',
      count: '25',
      actionText: '+ Add Plan',
    ),
    DashboardItemData(
      title: 'Total Diet Plans',
      count: '65',
      actionText: '+ Add Plan',
    ),
    // Add more items here if needed
  ];

  GymOverView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Two items per row
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.1, // Adjust as needed
        ),
        padding: const EdgeInsets.all(16.0),
        itemCount: dashboardItems.length,
        itemBuilder: (BuildContext context, int index) {
          return DashboardItem(data: dashboardItems[index]);
        },
      ),
    );
  }
}

class DashboardItemData {
  final String title;
  final String count;
  final String actionText;
  final bool highlighted;

  DashboardItemData({
    required this.title,
    required this.count,
    required this.actionText,
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
          Text(data.actionText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: notoSansRegular.copyWith(
                  fontSize: Dimensions.fontSize12,
                  color: Theme.of(context).primaryColor)),
        ],
      ),
    );
  }
}
