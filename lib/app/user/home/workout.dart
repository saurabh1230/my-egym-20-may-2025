import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myegym/app/widgets/custom_containers.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentDay = 1; // Example: Start with Day 1
  String _currentDayOfWeek = 'Monday'; // Example

  // Sample workout data (replace with your actual data)
  final Map<String, List<Workout>> _workoutData = {
    'Biceps & Triceps': [
      Workout(sets: 3, reps: '20 times', name: 'Push up', isChecked: false),
      Workout(sets: 3, reps: '20 times', name: 'Pull up', isChecked: false),
      Workout(sets: 3, reps: '20 times', name: 'Bicep Curl', isChecked: false),
    ],
    'Back': [
      Workout(sets: 3, reps: '20 times', name: 'Push up', isChecked: false),
      Workout(sets: 3, reps: '20 times', name: 'Pull up', isChecked: false),
      Workout(sets: 3, reps: '20 times', name: 'Bicep Curl', isChecked: false),
    ],
    'Chest': [
      Workout(sets: 3, reps: '20 times', name: 'Push up', isChecked: false),
      Workout(sets: 3, reps: '20 times', name: 'Pull up', isChecked: false),
      Workout(sets: 3, reps: '20 times', name: 'Bicep Curl', isChecked: false),
    ],
    'Legs': [
      Workout(sets: 3, reps: '20 times', name: 'Push up', isChecked: false),
      Workout(sets: 3, reps: '20 times', name: 'Pull up', isChecked: false),
      Workout(sets: 3, reps: '20 times', name: 'Bicep Curl', isChecked: false),
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 4, vsync: this); // Adjust length as needed
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back)),
        title: const Text('Weight Lifting Workouts'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.red,
          tabs: const [
            Tab(text: 'Week 1'),
            Tab(text: 'Week 2'),
            Tab(text: 'Week 3'),
            Tab(text: 'Week 4'), // Add more weeks as needed
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'DAY $_currentDay',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  _currentDayOfWeek,
                  style: const TextStyle(color: Colors.white70, fontSize: 16.0),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: ListView(
                children: _workoutData.keys.map((muscleGroup) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        muscleGroup,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      ..._workoutData[muscleGroup]!.map((workout) {
                        return _buildWorkoutItem(workout);
                      }).toList(),
                      const SizedBox(height: 16.0),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutItem(Workout workout) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: CustomDecoratedContainer(
        child: Row(
          children: [
            Text(
              '${workout.sets} sets',
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(width: 16.0),
            const VerticalDivider(color: Colors.grey, thickness: 1.0),
            const SizedBox(width: 16.0),
            Expanded(
              child: Text(
                '${workout.name} ${workout.reps}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 16.0),
            Icon(
              workout.isChecked
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

class Workout {
  final int sets;
  final String reps;
  final String name;
  bool isChecked;

  Workout({
    required this.sets,
    required this.reps,
    required this.name,
    this.isChecked = false,
  });
}
