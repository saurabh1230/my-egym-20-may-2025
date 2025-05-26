import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myegym/app/trainer/workouts/add_workout_screen.dart';

import 'package:myegym/app/trainer/workouts/components/beginner_workouts.dart';
import 'package:myegym/app/widgets/custom_app.dart';
import 'package:myegym/app/widgets/custom_button.dart';
import 'package:myegym/controllers/plans_controller.dart';
import 'package:myegym/controllers/workout_controller.dart';
import 'package:myegym/data/repo/plan_repo.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';

class TrainerWorkoutScreen extends StatelessWidget {
  final bool? isBackButton;
  TrainerWorkoutScreen({super.key, this.isBackButton = false});
  final WorkoutController workoutController = Get.put(WorkoutController());
  @override
  Widget build(BuildContext context) {
    Get.put(PlanRepo(apiClient: Get.find()));
    Get.put(PlansController(planRepo: Get.find()));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<PlansController>().getWorkoutListing();
    });
    return Scaffold(
        appBar: CustomAppBar(
          title: "Workout",
          isLogo: isBackButton! ? false : true,
          isBackButtonExist: isBackButton!,
        ),
        body: GetBuilder<PlansController>(builder: (workoutControl) {
          final list = workoutControl.workoutListing;
          final isListEmpty = list == null || list.isEmpty;
          return isListEmpty
              ? Center(
                  child: Text(
                    "No Data Available",
                    style: notoSansRegular.copyWith(color: Colors.white),
                  ),
                )
              : Stack(
                children: [
                  SizedBox(height: Get.size.height,
                    child: SingleChildScrollView(
                        child: Padding(
                          padding:
                              const EdgeInsets.all(Dimensions.paddingSizeDefault),
                          child: Column(
                            children: [
                              sizedBoxDefault(),
                              GetBuilder<WorkoutController>(
                                builder: (controller) => Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        _buildTabItem(() {
                                          controller.goToPage(0);
                                        }, "Beginner", 0,
                                            controller), // Pass the controller
                                        _buildTabItem(() {
                                          controller.goToPage(1);
                                        }, "Intermediate", 1,
                                            controller), // Pass the controller
                                        _buildTabItem(() {
                                          controller.goToPage(2);
                                        }, "Advanced", 2,
                                            controller) // Pass the controller
                                      ],
                                    ),
                                    sizedBox10(),
                                    SizedBox(
                                      height: Get.size.height,
                                      child: PageView(
                                        controller: controller.pageController,
                                        onPageChanged: (index) {
                                          controller.updateTabIndex(
                                              index); // Update UI on swipe
                                        },
                                        children: [
                                          BeginnerWorkouts(
                                            workouts: list
                                                .where((item) => item['level'] == 1)
                                                .toList(), title: 'Beginner',
                                          ), // Beginner
                                          BeginnerWorkouts(
                                            workouts: list
                                                .where((item) => item['level'] == 2)
                                                .toList(), title: 'Intermediate',
                                          ), // Intermediate
                                          BeginnerWorkouts(
                                            workouts: list
                                                .where((item) => item['level'] == 3)
                                                .toList(), title: 'Advance',
                                          ), //
                                          // BeginnerWorkouts(
                                          //   workouts: list,
                                          // ),
                                          // BeginnerWorkouts(
                                          //   workouts: list,
                                          // ),
                                          // BeginnerWorkouts(
                                          //   workouts: list,
                                          // ),
                                          // // IntermidateWorkout(),
                                          // // AdvancedWorkout(),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ),
                  Positioned(
                    bottom: Dimensions.paddingSizeDefault,
                    left: Dimensions.paddingSizeDefault,
                    right: Dimensions.paddingSizeDefault,
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomButtonWidget(
                            iconColor: Theme.of(context).primaryColor,
                            buttonText: "Filter",
                            fontSize: Dimensions.fontSize14,
                            textColor: Theme.of(context).primaryColor,
                            icon: Icons.tune,
                            onPressed: () {},
                            transparent: true,
                          ),
                        ),
                        sizedBoxW10(),
                        Expanded(
                          child: CustomButtonWidget(
                            buttonText: "Add New Workout",
                            fontSize: Dimensions.fontSize14,
                            icon: Icons.add,
                            iconColor: Colors.white,
                            onPressed: () {
                              Get.to(() => AddWorkoutScreen());
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
        }));
  }

  Widget _buildTabItem(
      Function() tap, String label, int index, WorkoutController controller) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: Dimensions.paddingSize10),
        child: GestureDetector(
          onTap: tap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: controller.currentIndex ==
                      index // Use controller.currentIndex directly
                  ? Colors.red
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: notoSansRegular.copyWith(
                      color: controller.currentIndex == index
                          ? Colors.white
                          : Colors.black,
                      fontSize: Dimensions.fontSize14)),
            ),
          ),
        ),
      ),
    );
  }
}
