import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myegym/app/widgets/confirmation_dialog.dart';
import 'package:myegym/app/widgets/custom_app.dart';
import 'package:myegym/app/widgets/custom_button.dart';
import 'package:myegym/app/widgets/custom_containers.dart';
import 'package:myegym/controllers/owner_controller.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';

import '../../../data/repo/owner_repo.dart';
import '../widgets/add_plan_duration_dialog.dart';

class PackageDuration extends StatelessWidget {
  const PackageDuration({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject dependencies
    Get.lazyPut(() => OwnerRepo(apiClient: Get.find()));
    Get.lazyPut(() => OwnerController(ownerRepo: Get.find()));

    // Fetch data once the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<OwnerController>().getPlanDurationList();
    });

    return Scaffold(
      appBar: CustomAppBar(title: "Packages Duration", isBackButtonExist: true),
      body: GetBuilder<OwnerController>(builder: (controller) {
        final data = controller.planDurationList;

        if (data == null) {
          return const Center(child: CircularProgressIndicator());
        }
        if (data.isEmpty) {
          return const Center(child: Text("No Packages Available"));
        }

        return Stack(
          children: [
            SizedBox(height: Get.size.height,
              child: ListView.separated(
                itemCount: data.length,
                padding: const EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  final package = data[index];
                  return Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.5,
                        color: Colors.white

                      ),
                      borderRadius: BorderRadius.circular(14)
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(Icons.fitness_center,
                              color: Colors.white,
                              size: 30),
                              sizedBoxW10(),
                              Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                package['name'] ?? '',
                                style: notoSansRegular.copyWith(
                                  color: Colors.white,
                                  fontSize: Dimensions.fontSize12
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.dialog(ConfirmationDialog(
                                icon: Icons.delete,
                                description: "Are You Sure to Delete this Package Duration",
                                onYesPressed: () {
                                  controller.deletePackageDuration(id: package['id'].toString());


                                })
                            );

                          },
                          child: CustomDecoratedContainer(
                            horizontalPadding: 10,
                            verticlePadding: 6,
                            color: Theme.of(context).primaryColor,
                            child: Text("Delete",style: notoSansRegular.copyWith(
                                fontSize: Dimensions.fontSize12,
                                color: Colors.white
                            ),
                            ),
                          ),
                        ),
                        // Row(
                        //   children: [
                        //     GestureDetector(
                        //       onTap: () {
                        //
                        //       },
                        //       child: CustomDecoratedContainer(
                        //         horizontalPadding: 10,
                        //         verticlePadding: 6,
                        //         color: Theme.of(context).primaryColor,
                        //         child: Text("Delete",style: notoSansRegular.copyWith(
                        //           fontSize: Dimensions.fontSize12,
                        //             color: Colors.white
                        //         ),
                        //         ),
                        //       ),
                        //     ),
                        //     sizedBoxW10(),
                        //     GestureDetector(
                        //       onTap: () {
                        //
                        //       },
                        //       child: CustomDecoratedContainer(
                        //         horizontalPadding: 10,
                        //         verticlePadding: 6,
                        //         color: Theme.of(context).primaryColor,
                        //         child: Text("Update",style: notoSansRegular.copyWith(
                        //             fontSize: Dimensions.fontSize12,
                        //             color: Colors.white
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),

                      ],
                    ),
                  );
                }, separatorBuilder: (BuildContext context, int index) => sizedBox10(),
              ),
            ),
           Positioned(
             bottom: Dimensions.paddingSizeDefault,
               left: Dimensions.paddingSizeDefault,
               right: Dimensions.paddingSizeDefault,
               child:  CustomButtonWidget(buttonText: "+ Add",onPressed: () {
               Get.dialog(AddPlanDurationDialog(title: 'Add Plan Duration',));

           },))
          ],
        );
      }),
    );
  }
}
