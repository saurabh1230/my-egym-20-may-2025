import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myegym/app/widgets/custom_app.dart';
import 'package:myegym/controllers/owner_controller.dart';
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

  // Store multiple subactivities dynamically, each with editable fields
  List<Map<String, dynamic>> subActivities = [];

  @override
  void initState() {
    super.initState();
    remainingDays = List.from(allDays);
  }

  void addSubActivity(OwnerController planControl) {
    if (planControl.selectedSubActivity.value.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a sub activity')),
      );
      return;
    }

    setState(() {
      subActivities.add({
        "id": planControl.selectedSubActivity.value["id"],
        "sets": 3,
        "reps": "8-12",
        "weight": 50,
        "rest": 60,
      });
      planControl.selectedSubActivity.value = {};
    });
  }

  void addDaySchedule(OwnerController planControl) {
    if (selectedDay == null || planControl.selectedActivityId == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both a day and activity')),
      );
      return;
    }

    if (subActivities.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one sub activity')),
      );
      return;
    }

    if (schedule.any((item) => item['day'] == selectedDay)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$selectedDay already added')),
      );
      return;
    }

    setState(() {
      schedule.add({
        "day": selectedDay!,
        "activity": planControl.selectedActivityId,
        "subactivities": List.from(subActivities),
      });

      remainingDays.remove(selectedDay);
      selectedDay = null;
      planControl.selectedActivity.value = {};
      planControl.selectActivityId(0);
      subActivities.clear();
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

    widget.onSave(schedule);
    Navigator.of(context).pop();
  }

  Widget buildSubActivityEditor(int index) {
    final sub = subActivities[index];

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sub Activity ID: ${sub["id"]}', style: const TextStyle(fontWeight: FontWeight.bold)),
            sizedBox10(),

            // Sets input
            Row(
              children: [
                const SizedBox(width: 70, child: Text('Sets:')),
                Expanded(
                  child: TextFormField(
                    initialValue: sub["sets"].toString(),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    onChanged: (val) {
                      final parsed = int.tryParse(val);
                      if (parsed != null && parsed > 0) {
                        setState(() {
                          subActivities[index]["sets"] = parsed;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            sizedBox10(),

            // Reps input (text, e.g. "8-12")
            Row(
              children: [
                const SizedBox(width: 70, child: Text('Reps:')),
                Expanded(
                  child: TextFormField(
                    initialValue: sub["reps"].toString(),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    onChanged: (val) {
                      setState(() {
                        subActivities[index]["reps"] = val;
                      });
                    },
                  ),
                ),
              ],
            ),
            sizedBox10(),

            // Weight input (number)
            Row(
              children: [
                const SizedBox(width: 70, child: Text('Weight:')),
                Expanded(
                  child: TextFormField(
                    initialValue: sub["weight"].toString(),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    onChanged: (val) {
                      final parsed = int.tryParse(val);
                      if (parsed != null && parsed >= 0) {
                        setState(() {
                          subActivities[index]["weight"] = parsed;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            sizedBox10(),

            // Rest input (seconds)
            Row(
              children: [
                const SizedBox(width: 70, child: Text('Rest (sec):')),
                Expanded(
                  child: TextFormField(
                    initialValue: sub["rest"].toString(),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    onChanged: (val) {
                      final parsed = int.tryParse(val);
                      if (parsed != null && parsed >= 0) {
                        setState(() {
                          subActivities[index]["rest"] = parsed;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            sizedBox10(),

            // Delete button
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    subActivities.removeAt(index);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Add Schedule",isBackButtonExist: true,isHideNotification: true,),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GetBuilder<OwnerController>(builder: (planControl) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<String>(
                    decoration:  InputDecoration(
                      labelStyle: notoSansRegular.copyWith(
                      color: Colors.black
              ),
                      hintStyle: notoSansRegular.copyWith(
                          color: Colors.black
                      ),
                      border: UnderlineInputBorder(),
                      labelText: 'Select Day',
                    ),
                    value: selectedDay,
                    items: remainingDays.map((day) {
                      return DropdownMenuItem(value: day, child: Text(day,style: notoSansRegular.copyWith(
                        color: Colors.black
                      ),));
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
                      planControl.selectActivityId(newValue?["id"] ?? 0);
                    },
                  )),
                  sizedBox20(),
                  Obx(() => DropdownButtonFormField<Map<String, dynamic>>(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Select Sub Activity',
                    ),
                    value: planControl.selectedSubActivity.value.isNotEmpty
                        ? planControl.selectedSubActivity.value
                        : null,
                    items: (planControl.subActivityList ?? [])
                        .map<DropdownMenuItem<Map<String, dynamic>>>(
                          (activity) => DropdownMenuItem(
                        value: activity,
                        child: Text(activity["title"] ?? "Unknown"),
                      ),
                    )
                        .toList(),
                    onChanged: (newValue) {
                      planControl.selectedSubActivity.value = newValue ?? {};
                    },
                  )),
                  sizedBox10(),
                  ElevatedButton(    style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                    onPressed: () => addSubActivity(planControl),
                    child: const Text("Add Sub Activity"),
                  ),
                  sizedBox10(),
        
                  // Editable sub-activities list
                  subActivities.isEmpty
                      ? const Text("No sub activities added")
                      : Expanded(
                    child: ListView.builder(
                      itemCount: subActivities.length,
                      itemBuilder: (context, index) {
                        return buildSubActivityEditor(index);
                      },
                    ),
                  ),
                  sizedBox20(),
                  ElevatedButton(    style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
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
                            subtitle:
                            Text('Activity ID: ${item['activity']}'),
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
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    child: Text("Save & Continue",
                        style: notoSansBold.copyWith(color: Colors.white)),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
