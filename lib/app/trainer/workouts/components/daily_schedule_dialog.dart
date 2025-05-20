import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myegym/controllers/owner_controller.dart';
import 'package:myegym/controllers/plans_controller.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';

class DailyScheduleDialog extends StatefulWidget {
  final void Function(List<Map<String, dynamic>>) onSave;

  const DailyScheduleDialog({super.key, required this.onSave});

  @override
  State<DailyScheduleDialog> createState() => _DailyScheduleDialogState();
}

class _DailyScheduleDialogState extends State<DailyScheduleDialog> {
  final List<String> allDays = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
  ];
  List<String> remainingDays = [];
  List<Map<String, dynamic>> schedule = [];

  String? selectedDay;

  @override
  void initState() {
    super.initState();
    remainingDays = List.from(allDays);
  }

  void addDaySchedule(OwnerController planControl) {
    if (selectedDay == null || planControl.selectedActivityId == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both a day and activity')),
      );
      return;
    }

    setState(() {
      schedule.add({
        "day": selectedDay!,
        "activityId": planControl.selectedActivityId,
      });

      remainingDays.remove(selectedDay);
      selectedDay = null;
      planControl.selectedActivity.value = {};
      planControl.selectActivityId(0);
    });
  }

  void deleteScheduleAt(int index) {
    setState(() {
      remainingDays.add(schedule[index]['day']);
      schedule.removeAt(index);
    });
  }

  void saveAndClose() {
    if (schedule.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one schedule')),
      );
      return;
    }

    widget.onSave(schedule); // Send data to parent
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: GetBuilder<OwnerController>(builder: (planControl) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Select Day',
                  ),
                  value: selectedDay,
                  items: remainingDays.map((day) {
                    return DropdownMenuItem(value: day, child: Text(day));
                  }).toList(),
                  onChanged: (value) => setState(() {
                    selectedDay = value;
                  }),
                ),
                sizedBox10(),
                Obx(() => DropdownButtonFormField<Map<String, dynamic>>(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Select Activity',
                  ),
                  value: planControl.selectedActivity.value.isNotEmpty
                      ? planControl.selectedActivity.value
                      : null,
                  items: (planControl.activityList ?? [])
                      .map<DropdownMenuItem<Map<String, dynamic>>>(
                        (activity) => DropdownMenuItem(
                      value: activity,
                      child: Text(activity["title"] ?? "Unknown"),
                    ),
                  )
                      .toList(),
                  onChanged: (newValue) {
                    planControl.selectedActivity.value = newValue ?? {};
                    planControl.selectActivityId(newValue?["id"]);
                  },
                )),
                sizedBox20(),
                ElevatedButton(
                  onPressed: () => addDaySchedule(planControl),
                  child: Text("Add to Schedule",
                      style: notoSansRegular.copyWith(color: Colors.white)),
                ),
                sizedBox20(),
                Expanded(
                  child: schedule.isEmpty
                      ? const Center(child: Text('No activities added yet.'))
                      : ListView.builder(
                    itemCount: schedule.length,
                    itemBuilder: (context, index) {
                      final item = schedule[index];
                      return Card(
                        child: ListTile(
                          title: Text(item['day']),
                          subtitle: Text(
                              'Activity ID: ${item['activityId'].toString()}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => deleteScheduleAt(index),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                sizedBox10(),
                ElevatedButton(
                  onPressed: saveAndClose,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Text("Save & Continue",
                      style: notoSansBold.copyWith(color: Colors.white)),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
