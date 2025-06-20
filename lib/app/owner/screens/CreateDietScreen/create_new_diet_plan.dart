import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/diet_plan_controller.dart';
import '../../../../data/models/month_model.dart';
import '../../../../dietpaln/meal_tab_screen.dart';

class CreateNewDietPlan extends StatelessWidget {
  const CreateNewDietPlan({super.key});

  @override
  Widget build(BuildContext context) {
    final DietPlanController controller = Get.put(DietPlanController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Diet Plan",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => ListView(
            children: [
              const Text(
                'Plan Name',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  controller: controller.planNameController,
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Workout Plan Name',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Plan Duration',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: DropdownButton<MonthModel>(
                              isExpanded: true,
                              underline: const SizedBox(),
                              value: controller.selectedDuration.value,
                              hint: const Text("Select Duration"),
                              items: controller.durations
                                  .map((month) => DropdownMenuItem<MonthModel>(
                                        value: month,
                                        child: Text(month.monthName),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  controller.selectedDuration.value = value;
                                  final match = RegExp(r'(\d+)')
                                      .firstMatch(value.monthName);
                                  final count = match != null
                                      ? int.parse(match.group(1)!)
                                      : 0;
                                  controller.allowedMonthCount.value = count;
                                }
                              },
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Plan Price',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: TextField(
                            controller: controller.planPriceController,
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '₹ 12000',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Plan Description',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  controller: controller.planDescriptionController,
                  maxLines: 4,
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Write description here...',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Add Meals',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),

              SizedBox(
                height: 50,
                child: Obx(() {
                  final monthList = controller.durations;
                  final selectedIndex = controller.selectedMonth.value;
                  final allowedMonths = controller.allowedMonthCount.value;

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: monthList.length,
                    itemBuilder: (context, index) {
                      final month = monthList[index];
                      final isEnabled = index < allowedMonths;
                      final isSelected = selectedIndex == index;

                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: GestureDetector(
                          onTap: isEnabled
                              ? () {
                                  controller.selectedMonth.value = index;
                                  final monthId = controller.durations[index].monthId;
                                  controller.fetchWeeks(monthId);
                                }
                              : null,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                              color: isEnabled
                                  ? Colors.white
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.black
                                    : Colors.grey.shade400,
                                width: 1.8,
                              ),
                            ),
                            child: Text(
                              month.monthName,
                              style: TextStyle(
                                color: isEnabled
                                    ? (isSelected
                                        ? const Color(0xFF8E1616)
                                        : Colors.grey)
                                    : Colors.grey.shade500,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),

              const SizedBox(height: 16),

              Obx(() {
                if (controller.weeks.isEmpty) {
                  return const Text("No weeks found", style: TextStyle(color: Colors.white));
                }

                return ListView.builder(
                  itemCount: controller.weeks.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final week = controller.weeks[index];
                    return ListTile(
                      title: Text(
                        week.weekName,
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: TextButton(
                        // onPressed: () {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => MealTabScreen()),
                        //   );
                        // },
                        onPressed: () {
                          final monthId = controller.durations[controller.selectedMonth.value].monthId;
                          final weekId = week.weekId;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MealTabScreen(
                                controller: controller,
                                monthId: monthId,
                                weekId: weekId,
                              ),
                            ),
                          );
                        },

                        child: const Text(
                          '+ Add',
                          style: TextStyle(color: Color(0xFF8E1616)),
                        ),
                      ),
                    );
                  },
                );
              }),

              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF8E1616),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.submitPlan();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8E1616),
                        // Set your custom color here
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Add Plan'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
