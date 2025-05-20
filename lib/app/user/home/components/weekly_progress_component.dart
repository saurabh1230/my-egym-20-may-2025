import 'package:flutter/material.dart';
import 'package:myegym/app/widgets/activity_circle_chart.dart';
import 'package:myegym/app/widgets/custom_containers.dart';
import 'package:myegym/app/widgets/gradient_bar_chart.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';

class WeeklyProgressComponent extends StatelessWidget {
  const WeeklyProgressComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sizedBox5(),
        Text(
          "Weekly Progress",
          style: notoSansRegular.copyWith(
              fontSize: Dimensions.fontSize14, color: Colors.white),
        ),
        Text(
          "Daily progress",
          style: notoSansRegular.copyWith(
              fontSize: Dimensions.fontSize12,
              color: Theme.of(context).hintColor),
        ),
        sizedBox10(),
        CustomDecoratedContainer(
          child: Column(
            children: [
              SizedBox(
                height: 150.0, // Adjust as needed
                child: GradientBarChart(
                  data: [80.0, 95.0, 40.0, 100.0, 55.0, 90.0],
                ),
              ),
              sizedBox10(),
              Divider(),
              sizedBox10(),
              Center(
                child: CircularActivityIndicator(
                  percentage: 89,
                  currentActivity: 15,
                  totalActivity: 20,
                ),
              ),
              sizedBox10(),
            ],
          ),
        ),
      ],
    );
  }
}
