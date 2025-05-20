import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myegym/app/widgets/custom_containers.dart';
import 'package:myegym/controllers/trainer_controllers.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart'; // For date formatting

class RevenueMetrics extends StatelessWidget {
  final TrainerController _revenueController =
      Get.put(TrainerController(trainerRepo: Get.find()));

  RevenueMetrics({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Membership Stats",
            style: notoSansRegular.copyWith(
                fontSize: Dimensions.fontSize14, color: Colors.white),
          ),
          sizedBox10(),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(Dimensions.radius10),
            ),
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: _revenueController.goToPreviousMonth,
                        child: DecoratedRoundContainer(
                          child: Icon(Icons.arrow_back,
                              size: Dimensions.fontSizeDefault,
                              color: Theme.of(context).hintColor),
                        ),
                      ),
                      Text(
                        _revenueController.formattedMonth,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: Dimensions.fontSize18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: _revenueController.goToNextMonth,
                        child: DecoratedRoundContainer(
                          child: Icon(Icons.arrow_forward,
                              size: Dimensions.fontSizeDefault,
                              color: Theme.of(context).hintColor),
                        ),
                      ),
                    ],
                  ),
                ),
                sizedBox20(),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMetricColumn(
                        title: 'Total Revenue',
                        amount:
                            '₹ ${_revenueController.formatAmount(_revenueController.currentMonthData.totalRevenue)} Lac',
                      ),
                      _buildMetricColumn(
                        title: 'Salary Expenses',
                        amount:
                            '₹ ${_revenueController.formatAmount(_revenueController.currentMonthData.salaryExpenses)}k',
                      ),
                      _buildMetricColumn(
                        title: 'Memberships',
                        amount:
                            '₹ ${_revenueController.formatAmount(_revenueController.currentMonthData.memberships)}k',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricColumn({required String title, required String amount}) {
    return Column(
      children: [
        Text(
          amount,
          style: const TextStyle(
            color: Colors.white,
            fontSize: Dimensions.fontSizeDefault,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: Dimensions.fontSize12,
          ),
        ),
      ],
    );
  }
}
