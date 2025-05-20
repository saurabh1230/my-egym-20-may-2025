import 'package:flutter/material.dart';
import 'package:myegym/controllers/workout_controller.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';

class HorizontalWorkoutList extends StatelessWidget {
  final List<WorkoutPlan> workoutPlans;
  final double? height;
  final double? itemWidth;
  final String title;
  const HorizontalWorkoutList({
    super.key,
    required this.workoutPlans,
    this.height = 160, // Default height
    this.itemWidth = 280,
    required this.title, // Default item width
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          title,
          style: notoSansSemiBold.copyWith(
              fontSize: Dimensions.fontSizeDefault, color: Colors.white),
        ),
        sizedBox10(),
        SizedBox(
          height: height,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemCount: workoutPlans.length,
            itemBuilder: (context, planIndex) {
              final plan = workoutPlans[planIndex];
              return Container(
                width: itemWidth, // Adjust width as needed
                margin:
                    EdgeInsets.symmetric(horizontal: Dimensions.paddingSize8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                  color: Colors.grey[200],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(Dimensions.radius10)),
                          image: DecorationImage(
                            image: AssetImage(workoutPlans[planIndex]
                                .imagePath), // Use your image provider
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
