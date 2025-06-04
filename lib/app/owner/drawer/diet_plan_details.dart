import 'package:flutter/material.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';

class PlanDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> planData;

  const PlanDetailsScreen({super.key, required this.planData});

  @override
  Widget build(BuildContext context) {
    final meals = planData['meals'] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text("Plan Details"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Note: ${planData['note'] ?? 'N/A'}", style: notoSansRegular.copyWith(color: Colors.white)),
            sizedBox10(),
            Text("Tips: ${planData['healthy_tips'] ?? 'N/A'}", style: notoSansRegular.copyWith(color: Colors.white)),
            sizedBox10(),
            Text("Exercise: ${planData['exercise'] ?? 'N/A'}", style: notoSansRegular.copyWith(color: Colors.white)),
            sizedBox10(),
            Text("Portion Control: ${planData['portion_control'] ?? 'N/A'}", style: notoSansRegular.copyWith(color: Colors.white)),
            sizedBox20(),
            Text("Meals:", style: notoSansBold.copyWith(color: Colors.white)),
            ListView.builder(
              itemCount: meals.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (_, j) {
                final meal = meals[j];
                final food = meal['food'];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("🍽️ ${food['food_name']}", style: notoSansMedium.copyWith(color: Colors.white)),
                        Text("Protein: ${food['protein']}g", style: notoSansRegular.copyWith(color: Colors.white70)),
                        Text("Fats: ${food['fats']}g", style: notoSansRegular.copyWith(color: Colors.white70)),
                        Text("Carbs: ${food['carbohydrates']}g", style: notoSansRegular.copyWith(color: Colors.white70)),
                        Text("Calories: ${food['calorie']}", style: notoSansRegular.copyWith(color: Colors.white70)),
                        if (food['notes'] != null)
                          Text("Note: ${food['notes']}", style: notoSansRegular.copyWith(color: Colors.white70, fontStyle: FontStyle.italic)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
