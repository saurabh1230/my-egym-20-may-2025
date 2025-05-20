import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myegym/app/trainer/workouts/components/workout_slider_component.dart';
import 'package:myegym/app/widgets/custom_network_image.dart';
import 'package:myegym/controllers/workout_controller.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';

class BeginnerWorkouts extends StatelessWidget {
  final List<dynamic> workouts;
  final double? width;
  const BeginnerWorkouts({
    super.key,
    required this.workouts,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return workouts.isEmpty
        ? Text(
            textAlign: TextAlign.center,
            "No Workout Found",
            style: notoSansRegular.copyWith(color: Colors.white),
          )
        : ListView.separated(
            itemCount: workouts.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final workout = workouts[index];
              final workoutHistory = workout['workout_history'];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    workout["goals"] ?? '',
                    style: notoSansSemiBold.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                      color: Colors.white,
                    ),
                  ),
                  sizedBox10(),
                  CustomNetworkImageWidget(
                      height: 150, image: workout["image_url"] ?? ''),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) => sizedBox10(),
          );
  }
}
