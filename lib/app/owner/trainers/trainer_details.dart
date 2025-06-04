
import 'package:flutter/material.dart';
import 'package:myegym/app/owner/trainers/update_trainer.dart';
import 'package:myegym/app/trainer/members/components/member_card_list_with_view.dart';
import 'package:myegym/app/widgets/custom_app.dart';
import 'package:myegym/app/widgets/custom_button.dart';
import 'package:myegym/app/widgets/custom_containers.dart';
import 'package:myegym/data/repo/trainer_repo.dart';
import 'package:myegym/utils/date_converter.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';

import '../../../controllers/trainer_controllers.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:myegym/app/trainer/members/components/member_card_list_with_view.dart';
import 'package:myegym/app/widgets/custom_app.dart';
import 'package:myegym/app/widgets/custom_containers.dart';
import 'package:myegym/utils/date_converter.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';

import '../../../controllers/trainer_controllers.dart';
import 'package:get/get.dart';
//
// class TrainerDetails extends StatelessWidget {
//   final String id;
//   final String name;
//
//   const TrainerDetails({super.key, required this.id, required this.name});
//
//   @override
//   Widget build(BuildContext context) {
//     Get.put(TrainerRepo(apiClient: Get.find()));
//     Get.put(TrainerController(trainerRepo: Get.find()));
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Get.find<TrainerController>().getTrainerDetails(id: id);
//     });
//
//     return Scaffold(
//         appBar: CustomAppBar(
//           title: name,
//           isBackButtonExist: true,
//           isLogo: false,
//         ),
//         body: GetBuilder<TrainerController>(
//           builder: (trainerControl) {
//             final detailsData = trainerControl.trainerDetails;
//             // Ensure that detailsData is not null
//             if (detailsData == null) {
//               return Center(
//                   child:
//                       CircularProgressIndicator()); // Show loading indicator if data is null
//             }
//
//             return Stack(
//               children: [
//                 SizedBox(height: Get.size.height,
//                   child: SingleChildScrollView(
//                     padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Trainer Details",
//                           style: notoSansSemiBold.copyWith(color: Colors.white),
//                         ),
//                         sizedBox10(),
//                         CustomDecoratedContainer(
//                           color: Theme.of(context).cardColor,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               _buildInfoRow(
//                                 context,
//                                 title: 'Phone Number',
//                                 data: detailsData['data']['trainer']['phone_number']
//                                         ?.toString() ??
//                                     'N/A',
//                               ),
//                               _buildInfoRow(
//                                 context,
//                                 title: 'Email',
//                                 data: detailsData['data']['trainer']['email']
//                                         ?.toString() ??
//                                     'N/A',
//                               ),
//                               sizedBoxDefault(),
//                               _buildInfoRow(
//                                 context,
//                                 title: 'Years Of Exp',
//                                 data: detailsData['data']['trainer']
//                                             ['experienceinyear']
//                                         ?.toString() ??
//                                     'N/A',
//                               ),
//                               _buildInfoRow(
//                                 context,
//                                 title: 'Joining Date',
//                                 data: DateFormatterOnlyDate.formatToIndianDate(
//                                         detailsData['data']['trainer']['created_at']
//                                             ?.toString()) ??
//                                     'N/A',
//                               ),
//                               sizedBoxDefault(),
//                               Text(
//                                 "Address",
//                                 style: notoSansRegular.copyWith(
//                                   color: Theme.of(context)
//                                       .disabledColor
//                                       .withOpacity(0.70),
//                                   fontSize: Dimensions.fontSize14,
//                                 ),
//                               ),
//                               Text(
//                                 detailsData['data']['trainer']['address']
//                                         ?.toString() ??
//                                     'N/A',
//                                 maxLines: 3,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: notoSansRegular.copyWith(
//                                   color: Colors.black,
//                                   fontSize: Dimensions.fontSize14,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         sizedBoxDefault(),
//                         CustomDecoratedContainer(
//                           color: Theme.of(context).cardColor,
//                           child: Column(
//                             children: [
//                               _buildMembersSection(context, detailsData),
//                               sizedBoxDefault(),
//                               MemberCardListWithView(
//                                 members: detailsData['data']['members'] ?? [],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   left: 0,
//                   right: 0,
//                   child: Padding(
//                     padding:  EdgeInsets.all(16),
//                     child: SingleChildScrollView(
//                       child: CustomButtonWidget(buttonText: "Edit Trainer",
//                         onPressed: () {
//                           Get.to(() => UpdateTrainer(data: trainerControl.trainerDetails, name:  name));
//
//                         },),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//
//     );
//   }
//
//   // Helper method to build info row
//   Widget _buildInfoRow(BuildContext context,
//       {required String title, required String data}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: notoSansRegular.copyWith(
//                     color: Theme.of(context).disabledColor.withOpacity(0.70),
//                     fontSize: Dimensions.fontSize12,
//                   ),
//                 ),
//                 Text(
//                   data,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: notoSansRegular.copyWith(
//                     color: Colors.black,
//                     fontSize: Dimensions.fontSize14,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Helper method to build the "Members" section header
//   Widget _buildMembersSection(
//       BuildContext context, Map<String, dynamic> detailsData) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           "Members",
//           style: notoSansSemiBold.copyWith(
//             color: Theme.of(context).disabledColor.withOpacity(0.60),
//             fontSize: Dimensions.fontSize14,
//           ),
//         ),
//         Text(
//           (detailsData['members'] as List?)?.length.toString() ?? '0',
//           style: notoSansBold.copyWith(
//             color: Theme.of(context).primaryColor,
//             fontSize: Dimensions.fontSizeDefault,
//           ),
//         ),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myegym/app/owner/trainers/update_trainer.dart';
import 'package:myegym/app/trainer/members/components/member_card_list_with_view.dart';
import 'package:myegym/app/widgets/custom_app.dart';
import 'package:myegym/app/widgets/custom_button.dart';
import 'package:myegym/app/widgets/custom_containers.dart';
import 'package:myegym/controllers/trainer_controllers.dart';
import 'package:myegym/data/repo/trainer_repo.dart';
import 'package:myegym/utils/date_converter.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';

class TrainerDetails extends StatelessWidget {
  final String id;
  final String name;

  const TrainerDetails({super.key, required this.id, required this.name});

  @override
  Widget build(BuildContext context) {
    Get.put(TrainerRepo(apiClient: Get.find()));
    final controller = Get.put(TrainerController(trainerRepo: Get.find()));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getTrainerDetails(id: id);
    });

    return Scaffold(
      appBar: CustomAppBar(
        title: name,
        isBackButtonExist: true,
        isLogo: false,
      ),
      body: GetBuilder<TrainerController>(
        builder: (trainerControl) {
          final trainerList = trainerControl.trainerDetails?['data'];

          if (trainerList == null || trainerList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final trainer = trainerList[0]['trainer'];
          final members = trainerList[0]['members'] ?? [];

          return Stack(
            children: [
              SizedBox(
                height: Get.size.height,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Trainer Details", style: notoSansSemiBold.copyWith(color: Colors.white)),
                      sizedBox10(),
                      CustomDecoratedContainer(
                        color: Theme.of(context).cardColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow(context, title: 'Phone Number', data: trainer['phone_number']?.toString() ?? 'N/A'),
                            _buildInfoRow(context, title: 'Email', data: trainer['email']?.toString() ?? 'N/A'),
                            sizedBoxDefault(),
                            _buildInfoRow(context, title: 'Years Of Exp', data: trainer['experienceinyear']?.toString() ?? 'N/A'),
                            _buildInfoRow(context, title: 'Joining Date',
                                data: DateFormatterOnlyDate.formatToIndianDate(trainer['created_at']?.toString()) ?? 'N/A'),
                            sizedBoxDefault(),
                            Text("Address",
                                style: notoSansRegular.copyWith(
                                  color: Theme.of(context).disabledColor.withOpacity(0.70),
                                  fontSize: Dimensions.fontSize14,
                                )),
                            Text(trainer['address']?.toString() ?? 'N/A',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: notoSansRegular.copyWith(
                                  color: Colors.black,
                                  fontSize: Dimensions.fontSize14,
                                )),
                          ],
                        ),
                      ),
                      sizedBoxDefault(),
                      Text("Personal Plan Members",
                        style: notoSansRegular.copyWith(
                            color: Colors.white
                        ),),
                      sizedBox10(),
                      CustomDecoratedContainer(
                        color: Theme.of(context).cardColor,
                        child: Column(
                          children: [

                            _buildMembersSection(context, members),
                            sizedBoxDefault(),
                            MemberCardListWithView(members: members),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: CustomButtonWidget(
                    buttonText: "Edit Trainer",
                    onPressed: () {
                      Get.to(() => UpdateTrainer(data: trainer, name: name));
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, {required String title, required String data}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                title,
                style: notoSansRegular.copyWith(
                  color: Theme.of(context).disabledColor.withOpacity(0.70),
                  fontSize: Dimensions.fontSize12,
                ),
              ),
              Text(
                data,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: notoSansRegular.copyWith(
                  color: Colors.black,
                  fontSize: Dimensions.fontSize14,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildMembersSection(BuildContext context, List members) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Members",
          style: notoSansSemiBold.copyWith(
            color: Theme.of(context).disabledColor.withOpacity(0.60),
            fontSize: Dimensions.fontSize14,
          ),
        ),
        Text(
          members.length.toString(),
          style: notoSansBold.copyWith(
            color: Theme.of(context).primaryColor,
            fontSize: Dimensions.fontSizeDefault,
          ),
        ),
      ],
    );
  }
}
