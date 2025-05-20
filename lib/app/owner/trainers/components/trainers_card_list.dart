// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';
// import 'package:myegym/app/owner/trainers/trainer_details.dart';
// import 'package:myegym/controllers/trainer_controllers.dart';
// import 'package:myegym/data/models/trainer_model.dart';
// import 'package:myegym/utils/dimensions.dart';
// import 'package:myegym/utils/styles.dart';

// class TrainersCardList extends StatelessWidget {
//   const TrainersCardList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<TrainerController>(builder: (trainerControl) {
//       final list = trainerControl.trainerList;
//       final isListEmpty = list == null;
//       return isListEmpty
//           ? Center(
//               child: Text(
//                 "No Data Available",
//                 style: notoSansRegular.copyWith(color: Colors.white),
//               ),
//             )
//           : Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     SizedBox(
//                       width: 160,
//                       child: Text(
//                         "Trainer Name",
//                         style: notoSansRegular.copyWith(
//                             fontSize: Dimensions.fontSize14, color: Colors.red),
//                       ),
//                     ),
//                     Flexible(
//                       child: Text(
//                         "Members",
//                         style: notoSansRegular.copyWith(
//                             fontSize: Dimensions.fontSize14, color: Colors.red),
//                       ),
//                     ),
//                     Flexible(
//                       child: TextButton(
//                         onPressed: () {
//                           // Get.to(TrainerDetails(trainer: TrainerModel()));
//                         },
//                         child: Text(
//                           "",
//                           style: notoSansRegular.copyWith(
//                               decoration: TextDecoration.underline,
//                               fontSize: Dimensions.fontSize14,
//                               color: Colors.red),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 ListView.builder(
//                     physics: NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     itemCount: list.trainer.length,
//                     itemBuilder: (_, i) {
//                       return Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           SizedBox(
//                             width: 160,
//                             child: Text(
//                               list.trainer[i].fullName,
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: notoSansRegular.copyWith(
//                                   fontSize: Dimensions.fontSize14,
//                                   color: Colors.white),
//                             ),
//                           ),
//                           Flexible(
//                             child: Text(
//                               list.members.length.toString(),
//                               style: notoSansRegular.copyWith(
//                                   fontSize: Dimensions.fontSize14,
//                                   color: Colors.white),
//                             ),
//                           ),
//                           Flexible(
//                             child: TextButton(
//                               onPressed: () {
//                                 Get.to(TrainerDetails(
//                                   id: list.trainer[i].id.toString(),
//                                   name: list.trainer[i].fullName.toString(),
//                                 ));
//                               },
//                               child: Text(
//                                 "View",
//                                 style: notoSansRegular.copyWith(
//                                     decoration: TextDecoration.underline,
//                                     fontSize: Dimensions.fontSize14,
//                                     color: Colors.red),
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     }),
//               ],
//             );
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:myegym/app/owner/trainers/trainer_details.dart';
import 'package:myegym/controllers/trainer_controllers.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/styles.dart';

class TrainersCardList extends StatelessWidget {
  const TrainersCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrainerController>(builder: (trainerControl) {
      final list = trainerControl.trainerList;
      final isListEmpty = list == null || list.isEmpty;
      return isListEmpty
          ? Center(
              child: Text(
                "No Data Available",
                style: notoSansRegular.copyWith(color: Colors.white),
              ),
            )
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 160,
                      child: Text(
                        "Trainer Name",
                        style: notoSansRegular.copyWith(
                            fontSize: Dimensions.fontSize14, color: Colors.red),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        "Members",
                        style: notoSansRegular.copyWith(
                            fontSize: Dimensions.fontSize14, color: Colors.red),
                      ),
                    ),
                    Flexible(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Action",
                          style: notoSansRegular.copyWith(
                              decoration: TextDecoration.underline,
                              fontSize: Dimensions.fontSize14,
                              color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  physics:
                      const NeverScrollableScrollPhysics(), // Added const here
                  shrinkWrap: true,
                  itemCount: list.length, // Iterate over the main list
                  itemBuilder: (_, i) {
                    final trainerData = list[i]; // Get the current item
                    final trainer =
                        trainerData['trainer']; // Access the trainer object
                    final members = trainerData['members'] as List? ??
                        []; // Access the members list, handle null

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 160,
                          child: Text(
                            trainer['full_name']?.toString() ??
                                'N/A', // Access trainer's full name
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: notoSansRegular.copyWith(
                                fontSize: Dimensions.fontSize14,
                                color: Colors.white),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            members.length
                                .toString(), // Display the number of members
                            style: notoSansRegular.copyWith(
                                fontSize: Dimensions.fontSize14,
                                color: Colors.white),
                          ),
                        ),
                        Flexible(
                          child: TextButton(
                            onPressed: () {
                              Get.to(TrainerDetails(
                                id: trainer['id']?.toString() ??
                                    '', // Access trainer's user ID
                                name: trainer['full_name']?.toString() ??
                                    '', // Access trainer's full name
                              ));
                            },
                            child: Text(
                              "View",
                              style: notoSansRegular.copyWith(
                                  decoration: TextDecoration.underline,
                                  fontSize: Dimensions.fontSize14,
                                  color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
    });
  }
}
