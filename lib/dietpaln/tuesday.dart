// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/diet_plan_controller.dart';
//
// class Tuesday extends StatefulWidget {
//   final VoidCallback onNext;
//   final int monthId;
//   final int weekId;
//
//   const Tuesday({
//     super.key,
//     required this.onNext,
//     required this.monthId,
//     required this.weekId,
//   });
//
//   @override
//   State<Tuesday> createState() => _TuesdayState();
// }
//
// class _TuesdayState extends State<Tuesday> {
//   final DietPlanController controller = Get.find<DietPlanController>();
//
//   final TextEditingController quantityController = TextEditingController();
//   final TextEditingController brandController = TextEditingController();
//   final TextEditingController dishTextController = TextEditingController();
//
//   String? mealType;
//   String? preference;
//   String unit = 'Units';
//
//   List<Map<String, dynamic>> get todayMeals {
//     final key = "${widget.monthId}_${widget.weekId}_Tuesday";
//     return controller.mealsData[key] ?? [];
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     controller.fetchMealTypes();
//     controller.fetchFoodItems();
//     controller.fetchUnits();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             _buildDropdown(
//               label: "Preference",
//               value: preference,
//               items: ['VEG', 'NON-VEG'],
//               onChanged: (value) => setState(() => preference = value),
//             ),
//             const SizedBox(height: 10),
//             _buildDishSearchField(),
//             const SizedBox(height: 10),
//             _buildMealTypeDropdown(),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildTextField(
//                     controller: quantityController,
//                     label: "Quantity",
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: Obx(() {
//                     final units = controller.units;
//                     return _buildDropdown(
//                       label: "Measure",
//                       value: units.contains(unit) ? unit : null,
//                       items: units,
//                       onChanged: (val) {
//                         if (val != null) setState(() => unit = val);
//                       },
//                     );
//                   }),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             _buildTextField(controller: brandController, label: "Brand Name"),
//             const SizedBox(height: 20),
//             SizedBox(
//               width: double.infinity,
//               height: 45,
//               child: ElevatedButton(
//                 onPressed: _handleAddMeal,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF8E1616),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text("Add Meal"),
//               ),
//             ),
//             const SizedBox(height: 30),
//             const Text("Meals Added", style: TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(height: 10),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: todayMeals.length,
//               itemBuilder: (context, index) {
//                 final meal = todayMeals[index];
//                 return Card(
//                   margin: const EdgeInsets.symmetric(vertical: 6),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   elevation: 3,
//                   child: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               meal['mealType'] ?? '',
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             Chip(
//                               label: Text(
//                                 meal['preference'] ?? '',
//                                 style: const TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               backgroundColor: meal['preference'] == 'VEG'
//                                   ? Colors.green
//                                   : Colors.redAccent,
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 6),
//                         Text(
//                           meal['food'] ?? '',
//                           style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//                         ),
//                         const SizedBox(height: 8),
//                         Row(
//                           children: [
//                             const Icon(Icons.scale, size: 18, color: Colors.grey),
//                             const SizedBox(width: 4),
//                             Text(
//                               "${meal['quantity']} ${meal['unit']}",
//                               style: const TextStyle(fontSize: 13),
//                             ),
//                             const SizedBox(width: 16),
//                             const Icon(Icons.local_offer, size: 18, color: Colors.grey),
//                             const SizedBox(width: 4),
//                             Text(
//                               meal['brand'] ?? '',
//                               style: const TextStyle(fontSize: 13),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       );
//     });
//   }
//
//   void _handleAddMeal() {
//     if (mealType == null ||
//         controller.foodController.value.trim().isEmpty ||
//         preference == null ||
//         quantityController.text.trim().isEmpty ||
//         int.tryParse(quantityController.text.trim()) == null ||
//         brandController.text.trim().isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("All fields are mandatory")),
//       );
//       return;
//     }
//
//     final mealData = {
//       'mealType': mealType,
//       'food': controller.foodController.value.trim(),
//       'preference': preference,
//       'quantity': quantityController.text.trim(),
//       'unit': unit,
//       'brand': brandController.text.trim(),
//     };
//
//     controller.saveMeal(
//       monthId: widget.monthId,
//       weekId: widget.weekId,
//       dayName: "Tuesday",
//       mealData: mealData,
//     );
//
//     quantityController.clear();
//     brandController.clear();
//     dishTextController.clear();
//     controller.foodController.value = '';
//     preference = null;
//     mealType = null;
//     unit = 'Units';
//
//     setState(() {}); // Refresh UI
//
//     if (todayMeals.length >= 5) {
//       widget.onNext();
//     }
//   }
//
//   Widget _buildDishSearchField() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextField(
//           controller: dishTextController,
//           onChanged: (val) => controller.foodController.value = val,
//           decoration: _inputDecoration("Dish Name"),
//         ),
//         Obx(() {
//           if (controller.foodController.value.isNotEmpty &&
//               controller.filteredDishes.isNotEmpty) {
//             return Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade400),
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               constraints: const BoxConstraints(maxHeight: 200),
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: controller.filteredDishes.length,
//                 itemBuilder: (context, index) {
//                   final item = controller.filteredDishes[index];
//                   return ListTile(
//                     title: Text(item),
//                     onTap: () {
//                       controller.foodController.value = item;
//                       dishTextController.text = item;
//                       controller.filteredDishes.clear();
//                     },
//                   );
//                 },
//               ),
//             );
//           } else {
//             return const SizedBox.shrink();
//           }
//         }),
//       ],
//     );
//   }
//
//   Widget _buildMealTypeDropdown() {
//     return Obx(() {
//       return _buildDropdown(
//         label: "Select Meal Type",
//         value: mealType,
//         items: controller.mealTypes,
//         onChanged: (value) => setState(() => mealType = value),
//       );
//     });
//   }
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     TextInputType keyboardType = TextInputType.text,
//   }) {
//     return TextField(
//       controller: controller,
//       keyboardType: keyboardType,
//       decoration: _inputDecoration(label),
//     );
//   }
//
//   Widget _buildDropdown({
//     required String label,
//     required String? value,
//     required List<String> items,
//     required ValueChanged<String?> onChanged,
//   }) {
//     return DropdownButtonFormField<String>(
//       value: value,
//       decoration: _inputDecoration(label),
//       items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
//       onChanged: onChanged,
//     );
//   }
//
//   InputDecoration _inputDecoration(String label) {
//     return InputDecoration(
//       labelText: label,
//       labelStyle: const TextStyle(color: Colors.grey),
//       enabledBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.grey.shade400),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.grey.shade600),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     quantityController.dispose();
//     brandController.dispose();
//     dishTextController.dispose();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/diet_plan_controller.dart';

class Tuesday extends StatefulWidget {
  final VoidCallback onNext;
  final int monthId;
  final int weekId;

  const Tuesday({
    super.key,
    required this.onNext,
    required this.monthId,
    required this.weekId,
  });

  @override
  State<Tuesday> createState() => _TuesdayState();
}

class _TuesdayState extends State<Tuesday> {
  final DietPlanController controller = Get.find<DietPlanController>();

  final TextEditingController quantityController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController dishTextController = TextEditingController();

  String? mealType;
  String? preference;
  String unit = 'Units';

  List<Map<String, dynamic>> get todayMeals {
    final key = "${widget.monthId}_${widget.weekId}_Tuesday";
    return controller.mealsData[key] ?? [];
  }

  @override
  void initState() {
    super.initState();
    controller.fetchMealTypes();
    controller.fetchFoodItems();
    controller.fetchUnits();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildDropdown(
              label: "Preference",
              value: preference,
              items: ['VEG', 'NON-VEG'],
              onChanged: (value) => setState(() => preference = value),
            ),
            const SizedBox(height: 10),
            _buildMealTypeDropdown(),
            const SizedBox(height: 10),
            _buildDishSearchField(),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: quantityController,
                    label: "Quantity",
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Obx(() {
                    final units = controller.units;
                    return _buildDropdown(
                      label: "Measure",
                      value: units.contains(unit) ? unit : null,
                      items: units,
                      onChanged: (val) {
                        if (val != null) {
                          setState(() => unit = val);
                        }
                      },
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _buildTextField(
              controller: brandController,
              label: "Brand Name",
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: _handleAddMeal,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8E1616),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Add Meal"),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                controller.copyMondayToTuesday(widget.monthId, widget.weekId);
                setState(() {});
              },
              icon: const Icon(Icons.copy),
              label: const Text("Same as Monday"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                minimumSize: const Size.fromHeight(45),
              ),
            ),
            const SizedBox(height: 30),
            const Text("Meals Added", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: todayMeals.length,
              itemBuilder: (context, index) {
                final meal = todayMeals[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              meal['mealType'] ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                            Chip(
                              label: Text(
                                meal['preference'] ?? '',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: meal['preference'] == 'VEG'
                                  ? Colors.green
                                  : Colors.redAccent,
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          meal['food'] ?? '',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.scale, size: 18, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text("${meal['quantity']} ${meal['unit']}", style: const TextStyle(fontSize: 13)),
                            const SizedBox(width: 16),
                            const Icon(Icons.local_offer, size: 18, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(meal['brand'] ?? '', style: const TextStyle(fontSize: 13)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              icon: const Icon(Icons.edit, size: 16),
                              label: const Text("Edit"),
                              onPressed: () => _editMeal(index),
                            ),
                            const SizedBox(width: 10),
                            TextButton.icon(
                              icon: const Icon(Icons.delete, size: 16, color: Colors.red),
                              label: const Text("Delete", style: TextStyle(color: Colors.red)),
                              onPressed: () => _deleteMeal(index),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    });
  }

  void _editMeal(int index) {
    final meal = todayMeals[index];
    setState(() {
      mealType = meal['mealType'];
      preference = meal['preference'];
      dishTextController.text = meal['food'];
      controller.foodController.value = meal['food'];
      quantityController.text = meal['quantity'];
      brandController.text = meal['brand'];
      unit = meal['unit'];
    });
    final key = "${widget.monthId}_${widget.weekId}_Tuesday";
    controller.mealsData[key]?.removeAt(index);
  }

  void _deleteMeal(int index) {
    final key = "${widget.monthId}_${widget.weekId}_Tuesday";
    setState(() {
      controller.mealsData[key]?.removeAt(index);
    });
  }

  Widget _buildMealTypeDropdown() {
    return Obx(() {
      final usedMealTypes = todayMeals.map((e) => e['mealType']).toSet();
      final availableMealTypes = controller.mealTypes.where((type) => !usedMealTypes.contains(type)).toList();
      return _buildDropdown(
        label: "Select Meal Type",
        value: availableMealTypes.contains(mealType) ? mealType : null,
        items: availableMealTypes,
        onChanged: (value) => setState(() => mealType = value),
      );
    });
  }

  Widget _buildDishSearchField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: dishTextController,
          onChanged: (val) => controller.foodController.value = val,
          decoration: _inputDecoration("Dish Name"),
        ),
        Obx(() {
          if (controller.foodController.value.isNotEmpty && controller.filteredDishes.isNotEmpty) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(5),
              ),
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.filteredDishes.length,
                itemBuilder: (context, index) {
                  final item = controller.filteredDishes[index];
                  return ListTile(
                    title: Text(item),
                    onTap: () {
                      controller.foodController.value = item;
                      dishTextController.text = item;
                      controller.filteredDishes.clear();
                    },
                  );
                },
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
      ],
    );
  }

  void _handleAddMeal() {
    if (mealType == null ||
        controller.foodController.value.trim().isEmpty ||
        preference == null ||
        quantityController.text.trim().isEmpty ||
        int.tryParse(quantityController.text.trim()) == null ||
        brandController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are mandatory")),
      );
      return;
    }

    final mealData = {
      'mealType': mealType,
      'food': controller.foodController.value.trim(),
      'preference': preference,
      'quantity': quantityController.text.trim(),
      'unit': unit,
      'brand': brandController.text.trim(),
    };

    controller.saveMeal(
      monthId: widget.monthId,
      weekId: widget.weekId,
      dayName: "Tuesday",
      mealData: mealData,
    );

    quantityController.clear();
    brandController.clear();
    dishTextController.clear();
    controller.foodController.value = '';
    preference = null;
    mealType = null;
    unit = 'Units';

    setState(() {});

    if (todayMeals.length >= 5) {
      widget.onNext();
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: _inputDecoration(label),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: _inputDecoration(label),
      items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
      onChanged: onChanged,
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade600),
      ),
    );
  }

  @override
  void dispose() {
    quantityController.dispose();
    brandController.dispose();
    dishTextController.dispose();
    super.dispose();
  }
}






// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/diet_plan_controller.dart';
//
// class Tuesday extends StatefulWidget {
//   final VoidCallback onNext;
//   final int monthId;
//   final int weekId;
//
//   const Tuesday({
//     super.key,
//     required this.onNext,
//     required this.monthId,
//     required this.weekId,
//   });
//
//   @override
//   State<Tuesday> createState() => _TuesdayState();
// }
//
// class _TuesdayState extends State<Tuesday> {
//   final DietPlanController controller = Get.find<DietPlanController>();
//
//   final TextEditingController quantityController = TextEditingController();
//   final TextEditingController brandController = TextEditingController();
//   final TextEditingController dishTextController = TextEditingController();
//
//   String? mealType;
//   String? preference;
//   String unit = 'Units';
//
//   List<Map<String, dynamic>> get todayMeals {
//     final key = "${widget.monthId}_${widget.weekId}_Tuesday";
//     return controller.mealsData[key] ?? [];
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     controller.fetchMealTypes();
//     controller.fetchFoodItems();
//     controller.fetchUnits();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             _buildDropdown(
//               label: "Preference",
//               value: preference,
//               items: ['VEG', 'NON-VEG'],
//               onChanged: (value) => setState(() => preference = value),
//             ),
//             const SizedBox(height: 10),
//             _buildMealTypeDropdown(),
//             const SizedBox(height: 10),
//             _buildDishSearchField(),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildTextField(
//                     controller: quantityController,
//                     label: "Quantity",
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: Obx(() {
//                     final units = controller.units;
//                     return _buildDropdown(
//                       label: "Measure",
//                       value: units.contains(unit) ? unit : null,
//                       items: units,
//                       onChanged: (val) {
//                         if (val != null) {
//                           setState(() => unit = val);
//                         }
//                       },
//                     );
//                   }),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             _buildTextField(
//               controller: brandController,
//               label: "Brand Name",
//             ),
//             const SizedBox(height: 20),
//             SizedBox(
//               width: double.infinity,
//               height: 45,
//               child: ElevatedButton(
//                 onPressed: _handleAddMeal,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF8E1616),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text("Add Meal"),
//               ),
//             ),
//             const SizedBox(height: 30),
//             const Text("Meals Added", style: TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(height: 10),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: todayMeals.length,
//               itemBuilder: (context, index) {
//                 final meal = todayMeals[index];
//                 return Card(
//                   margin: const EdgeInsets.symmetric(vertical: 6),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   elevation: 3,
//                   child: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               meal['mealType'] ?? '',
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             Chip(
//                               label: Text(
//                                 meal['preference'] ?? '',
//                                 style: const TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               backgroundColor: meal['preference'] == 'VEG'
//                                   ? Colors.green
//                                   : Colors.redAccent,
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 6),
//                         Text(
//                           meal['food'] ?? '',
//                           style: const TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Row(
//                           children: [
//                             const Icon(Icons.scale, size: 18, color: Colors.grey),
//                             const SizedBox(width: 4),
//                             Text("${meal['quantity']} ${meal['unit']}", style: const TextStyle(fontSize: 13)),
//                             const SizedBox(width: 16),
//                             const Icon(Icons.local_offer, size: 18, color: Colors.grey),
//                             const SizedBox(width: 4),
//                             Text(meal['brand'] ?? '', style: const TextStyle(fontSize: 13)),
//                           ],
//                         ),
//                         const SizedBox(height: 12),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             TextButton.icon(
//                               icon: const Icon(Icons.edit, size: 16),
//                               label: const Text("Edit"),
//                               onPressed: () => _editMeal(index),
//                             ),
//                             const SizedBox(width: 10),
//                             TextButton.icon(
//                               icon: const Icon(Icons.delete, size: 16, color: Colors.red),
//                               label: const Text("Delete", style: TextStyle(color: Colors.red)),
//                               onPressed: () => _deleteMeal(index),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       );
//     });
//   }
//
//   void _editMeal(int index) {
//     final meal = todayMeals[index];
//     setState(() {
//       mealType = meal['mealType'];
//       preference = meal['preference'];
//       dishTextController.text = meal['food'];
//       controller.foodController.value = meal['food'];
//       quantityController.text = meal['quantity'];
//       brandController.text = meal['brand'];
//       unit = meal['unit'];
//     });
//     final key = "${widget.monthId}_${widget.weekId}_Tuesday";
//     controller.mealsData[key]?.removeAt(index);
//   }
//
//   void _deleteMeal(int index) {
//     final key = "${widget.monthId}_${widget.weekId}_Tuesday";
//     setState(() {
//       controller.mealsData[key]?.removeAt(index);
//     });
//   }
//
//   Widget _buildMealTypeDropdown() {
//     return Obx(() {
//       final usedMealTypes = todayMeals.map((e) => e['mealType']).toSet();
//       final availableMealTypes = controller.mealTypes.where((type) => !usedMealTypes.contains(type)).toList();
//       return _buildDropdown(
//         label: "Select Meal Type",
//         value: availableMealTypes.contains(mealType) ? mealType : null,
//         items: availableMealTypes,
//         onChanged: (value) => setState(() => mealType = value),
//       );
//     });
//   }
//
//   Widget _buildDishSearchField() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextField(
//           controller: dishTextController,
//           onChanged: (val) => controller.foodController.value = val,
//           decoration: _inputDecoration("Dish Name"),
//         ),
//         Obx(() {
//           if (controller.foodController.value.isNotEmpty && controller.filteredDishes.isNotEmpty) {
//             return Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade400),
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               constraints: const BoxConstraints(maxHeight: 200),
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: controller.filteredDishes.length,
//                 itemBuilder: (context, index) {
//                   final item = controller.filteredDishes[index];
//                   return ListTile(
//                     title: Text(item),
//                     onTap: () {
//                       controller.foodController.value = item;
//                       dishTextController.text = item;
//                       controller.filteredDishes.clear();
//                     },
//                   );
//                 },
//               ),
//             );
//           } else {
//             return const SizedBox.shrink();
//           }
//         }),
//       ],
//     );
//   }
//
//   void _handleAddMeal() {
//     if (mealType == null ||
//         controller.foodController.value.trim().isEmpty ||
//         preference == null ||
//         quantityController.text.trim().isEmpty ||
//         int.tryParse(quantityController.text.trim()) == null ||
//         brandController.text.trim().isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("All fields are mandatory")),
//       );
//       return;
//     }
//
//     final mealData = {
//       'mealType': mealType,
//       'food': controller.foodController.value.trim(),
//       'preference': preference,
//       'quantity': quantityController.text.trim(),
//       'unit': unit,
//       'brand': brandController.text.trim(),
//     };
//
//     controller.saveMeal(
//       monthId: widget.monthId,
//       weekId: widget.weekId,
//       dayName: "Tuesday",
//       mealData: mealData,
//     );
//
//     quantityController.clear();
//     brandController.clear();
//     dishTextController.clear();
//     controller.foodController.value = '';
//     preference = null;
//     mealType = null;
//     unit = 'Units';
//
//     setState(() {});
//
//     if (todayMeals.length >= 5) {
//       widget.onNext();
//     }
//   }
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     TextInputType keyboardType = TextInputType.text,
//   }) {
//     return TextField(
//       controller: controller,
//       keyboardType: keyboardType,
//       decoration: _inputDecoration(label),
//     );
//   }
//
//   Widget _buildDropdown({
//     required String label,
//     required String? value,
//     required List<String> items,
//     required ValueChanged<String?> onChanged,
//   }) {
//     return DropdownButtonFormField<String>(
//       value: value,
//       decoration: _inputDecoration(label),
//       items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
//       onChanged: onChanged,
//     );
//   }
//
//   InputDecoration _inputDecoration(String label) {
//     return InputDecoration(
//       labelText: label,
//       labelStyle: const TextStyle(color: Colors.grey),
//       enabledBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.grey.shade400),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.grey.shade600),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     quantityController.dispose();
//     brandController.dispose();
//     dishTextController.dispose();
//     super.dispose();
//   }
// }