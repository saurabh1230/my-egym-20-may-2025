// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:myegym/app/widgets/custom_app.dart';
// import 'package:myegym/controllers/owner_controller.dart';
// import 'package:myegym/data/repo/owner_repo.dart';
//
// class PersonalTrainingPlans extends StatelessWidget {
//   const PersonalTrainingPlans({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Get.put(OwnerRepo(apiClient: Get.find()));
//     Get.put(OwnerController(ownerRepo: Get.find()));
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Get.find<OwnerController>().getPersonalPlanList();
//
//
//
//     });
//     return Scaffold(
//       appBar: CustomAppBar(title: "Personal Training Plans",isBackButtonExist: true,),
//       body: GetBuilder<OwnerController>(builder: (planControl) {
//
//         final data = planControl.personalPlan;
//          if (data == null  || data.isEmpty) {
//            return Text("No Plans Available");
//          }
//       return  ListView.builder(
//         padding: const EdgeInsets.all(12),
//         itemCount: data.length,
//         itemBuilder: (context, index) {
//           final plan = data[index];
//
//           return Card(
//             margin: const EdgeInsets.only(bottom: 12),
//             elevation: 3,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     plan['training_plan'] ?? "N/A",
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   if (plan['goals'] != null)
//                     Text("Goal: ${plan['goals']['name']}"),
//                   Text("Frequency: ${plan['training_frequency'] ?? 'N/A'}"),
//                   Text("Session Duration: ${plan['session_duration']} hr"),
//                   Text("Start Date: ${plan['training_start_date']}"),
//                   Text("End Date: ${plan['training_end_date']}"),
//                   const Divider(height: 20),
//                   Text("Paid Amount: ₹${plan['paid_amount']}"),
//                   Text("Due Amount: ₹${plan['due_amount']}"),
//                   Text("Discount: ₹${plan['discount']}"),
//                   Text("Payment Method: ${plan['payment_method']}"),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//       },
//       ),
//     );
//
//   }
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myegym/app/widgets/custom_app.dart';
import 'package:myegym/controllers/owner_controller.dart';
import 'package:intl/intl.dart';
import 'package:myegym/utils/sizeboxes.dart';

import '../../../data/repo/owner_repo.dart';

class PersonalTrainingPlans extends StatelessWidget {
  const PersonalTrainingPlans({super.key});

  String formatDate(String date) {
    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat('MMM dd, yyyy').format(parsedDate);
    } catch (_) {
      return date;
    }
  }

  // Map status int to text & color
  Map<String, dynamic> statusInfo(int status) {
    switch (status) {
      case 1:
        return {'text': 'Pending', 'color': Colors.orange};
      case 2:
        return {'text': 'Active', 'color': Colors.green};
      case 3:
        return {'text': 'Completed', 'color': Colors.grey};
      default:
        return {'text': 'Unknown', 'color': Colors.blueGrey};
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(OwnerRepo(apiClient: Get.find()));
    Get.put(OwnerController(ownerRepo: Get.find()));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<OwnerController>().getPersonalPlanList();});
    return Scaffold(
      appBar: CustomAppBar(title: "Personal Training Plans", isBackButtonExist: true),
      body: GetBuilder<OwnerController>(
        builder: (planControl) {
          final data = planControl.personalPlan;
          if (data == null || data.isEmpty) {
            return const Center(
                child: Text(
                  "No Plans Available",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ));
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final plan = data[index];
              final status = plan['status'] ?? 0;
              final statusDetails = statusInfo(status);

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 6,
                shadowColor: Colors.grey.withOpacity(0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with plan name & status
                    Container(
                      decoration: BoxDecoration(
                        color: statusDetails['color'].withOpacity(0.15),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              plan['training_plan'] ?? "N/A",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: statusDetails['color'],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              statusDetails['text'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (plan['goals'] != null) ...[
                            Row(
                              children: [
                                const Icon(Icons.flag, size: 20, color: Colors.deepPurple),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    "Goal: ${plan['goals']['name']}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          ],
                          sizedBox10(),
                          Row(
                            children: [
                              const Icon(Icons.repeat, size: 20, color: Colors.teal),
                              const SizedBox(width: 8),
                              Text(
                                "Frequency: ${plan['training_frequency'] ?? 'N/A'}",
                                style: const TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          sizedBox10(),
                          Row(
                            children: [
                              const Icon(Icons.timer, size: 20, color: Colors.orange),
                              const SizedBox(width: 8),
                              Text(
                                "Duration: ${plan['session_duration']} hr",
                                style: const TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                         sizedBox10(),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today, size: 20, color: Colors.blue),
                              const SizedBox(width: 8),
                              Text(
                                "From: ${formatDate(plan['training_start_date'] ?? '')}",
                                style: const TextStyle(fontSize: 15),
                              ),

                            ],
                          ),
                          sizedBox10(),

                          Row(
                            children: [
                              const Icon(Icons.calendar_today, size: 20, color: Colors.blue),
                              const SizedBox(width: 8),
                              Text(
                                "To: ${formatDate(plan['training_end_date'] ?? '')}",
                                style: const TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          const Divider(height: 30, thickness: 1.2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Paid Amount",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "₹${plan['paid_amount'] ?? '0.00'}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Due Amount",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "₹${plan['due_amount'] ?? '0.00'}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Discount",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "₹${plan['discount'] ?? '0.00'}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.payment, size: 18, color: Colors.blueGrey),
                              const SizedBox(width: 6),
                              Text(
                                "Payment Method: ${plan['payment_method'] ?? 'N/A'}",
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
