import 'package:flutter/material.dart';
import 'package:myegym/app/trainer/workouts/components/workout_slider_component.dart';
import 'package:myegym/controllers/workout_controller.dart';

class AdvancedWorkout extends StatelessWidget {
  const AdvancedWorkout({super.key});

  @override
  Widget build(BuildContext context) {
    return HorizontalWorkoutList(
      workoutPlans: [
        // Wrap the WorkoutPlan object in a list
        WorkoutPlan(
            description: '',
            name: '',
            imagePath: 'assets/images/ic_workout_demo.png',
            level: ''),
        WorkoutPlan(
            description: '',
            name: '',
            imagePath: 'assets/images/ic_workout_demo.png',
            level: ''),
      ],
      title: 'Workout Categories',
    );
  }
}
