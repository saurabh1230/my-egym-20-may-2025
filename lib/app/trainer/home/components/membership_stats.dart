import 'package:flutter/material.dart';
import 'package:myegym/app/widgets/activity_circle_chart.dart';
import 'package:myegym/app/widgets/custom_containers.dart';
import 'package:myegym/app/widgets/gradient_bar_chart.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';

class MembershipStats extends StatelessWidget {
  const MembershipStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sizedBox5(),
        Text(
          "Membership Stats",
          style: notoSansRegular.copyWith(
              fontSize: Dimensions.fontSize14, color: Colors.white),
        ),
        Text(
          "Monthly progress",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 100.0, // Adjust size as needed
                        height: 100.0,
                        child: CustomPaint(
                          painter: CircularProgressPainter(
                            percentage: 15,
                            trackColor: Colors.grey.shade800,
                            progressColor: Colors.red.shade600,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '90',
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'Renewal',
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                      width: 24.0), // Spacing between circle and text
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('93',
                            style: notoSansSemiBold.copyWith(
                                color: Colors.white,
                                fontSize: Dimensions.fontSize20)),
                        Text(
                          'Total Memberships',
                          style: notoSansRegular.copyWith(
                            fontSize: Dimensions.fontSize12,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              sizedBox10(),
            ],
          ),
        ),
      ],
    );
  }
}
