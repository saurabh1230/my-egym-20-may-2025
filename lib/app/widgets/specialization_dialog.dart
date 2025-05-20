import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:myegym/controllers/data_controller.dart';
import 'package:myegym/utils/styles.dart';

class SpecializationDialog extends StatelessWidget {
  const SpecializationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataController>(builder: (dataControl) {
      return StatefulBuilder(
        builder: (BuildContext context, setState) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Prevents unbounded expansion
                children: [
                  // Use a SingleChildScrollView if the list is large
                  SingleChildScrollView(
                    child: Column(
                      children: dataControl.specializationModel!.map((model) {
                        return ListTile(
                          title: Text(model.name),
                          trailing: Checkbox(
                            value: dataControl.selectedSpecializationIds
                                .contains(model.id),
                            onChanged: (bool? isSelected) {
                              if (isSelected == true) {
                                // Add ID to selected list
                                dataControl.selectedSpecializationIds
                                    .add(model.id);
                              } else {
                                // Remove ID from selected list
                                dataControl.selectedSpecializationIds
                                    .remove(model.id);
                              }
                              setState(
                                  () {}); // Trigger a rebuild after selection change
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          'Cancel',
                          style: notoSansRegular.copyWith(
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor),
                        child: Text(
                          'Add',
                          style: notoSansRegular.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
