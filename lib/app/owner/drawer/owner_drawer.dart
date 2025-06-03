import 'package:flutter/material.dart';
import 'package:myegym/app/owner/drawer/diet_plan.dart';
import 'package:myegym/app/owner/drawer/meal_plan_screen.dart';
import 'package:myegym/app/owner/drawer/my_purchase.dart';
import 'package:myegym/app/owner/drawer/package_duration.dart';
import 'package:myegym/app/owner/drawer/personal_training_plans.dart';
import 'package:myegym/app/owner/drawer/pt_plans.dart';
import 'package:myegym/app/trainer/workouts/workout_screen.dart';
import 'package:myegym/app/user/home/workout.dart';
import 'package:myegym/app/widgets/confirmation_dialog.dart';
import 'package:myegym/helper/route_helper.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';
import 'package:get/get.dart';

import '../../widgets/add_workout_goal_dialog.dart';
import '../widgets/add_food_dialog.dart';

class OwnerDrawer extends StatelessWidget {
  const OwnerDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSize10),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                    Text(
                      "MENU",
                      style: notoSansMedium.copyWith(color: Colors.white),
                    )
                  ],
                ),
                text(
                    title: 'My Purchases',
                    tap: () {
                      Get.to(() => OwnerMyPurchases());
                    }),
                sizedBox5(),
                Divider(),
                text(
                    title: 'Workout Plans',
                    tap: () {
                      Get.to(() => TrainerWorkoutScreen(
                            isBackButton: true,
                          ));
                    }),
                sizedBox5(),
                Divider(),
                text(
                    title: 'Add Workout Goals',
                    tap: () {
                      Get.dialog(AddWorkoutGoalDialog(
                        title: "Add Workout Goal",
                        icon: Icons.sports_gymnastics,));
                     
                    }),
                sizedBox5(),
                Divider(),
                text(
                    title: 'Add Food',
                    tap: () {
                      Get.dialog(AddFoodDialog(
                        title: "Add Food",
                       ));

                    }),

                sizedBox5(),
                Divider(),
                text(
                    title: 'Diet Plans',
                    tap: () {
                      Get.to(() => OwnerDietPlan());
                    }),
                sizedBox5(),
                Divider(),
                text(
                    title: 'Meal Plans',
                    tap: () {
                      Get.to(() => MealPlanScreen());
                    }),
                sizedBox5(),

                Divider(),
                text(
                    title: 'Personal Training Plans',
                    tap: () {
                      Get.to(() => PersonalTrainingPlans(

                      ));
                    }),
                Divider(),
                text(
                    title: 'Package Duration',
                    tap: () {
                      Get.to(() => PackageDuration(

                      ));
                    }),
                Divider(),
                text(
                    title: 'PT Plans',
                    tap: () {
                      Get.to(() => OwnerPtPlan());
                    }),
                sizedBox5(),
                Divider(),
                text(title: 'Gym Staff', tap: () {}),
                sizedBox5(),
                Divider(),
                text(title: 'Add offers', tap: () {}),
                sizedBox5(),
                Divider(),
                text(title: 'Add News', tap: () {}),
                sizedBox5(),
                Divider(),
                text(title: 'Notification', tap: () {}),
                sizedBox5(),
                Divider(),
                text(title: 'Payment Methods', tap: () {}),
                sizedBox5(),
                Divider(),
                text(title: 'Batch Schedules', tap: () {}),
                sizedBox5(),
                Divider(),
                text(title: 'Communication Settings', tap: () {}),
                sizedBox5(),
                Divider(),
                text(title: 'Help Center', tap: () {}),
                sizedBox5(),
                Divider(),
                text(title: 'Privacy Policy', tap: () {}),
                sizedBox5(),
                Divider(),
                text(title: 'Terms & Conditions', tap: () {}),
                sizedBox5(),
                Divider(),
                text(
                    title: 'Logout',
                    tap: () {
                      Get.dialog(ConfirmationDialog(
                          icon: Icons.logout,
                          description: "Are You Sure to Logout",
                          onYesPressed: () {
                            Get.toNamed(RouteHelper.getLogin());
                          }));
                    }),
                sizedBox30()
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell text({required String title, required Function() tap}) {
    return InkWell(
      onTap: tap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: notoSansRegular.copyWith(color: Colors.white),
            ),
            Icon(
              Icons.arrow_right,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
