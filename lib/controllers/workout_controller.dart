import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Example data models (replace with your actual data)
class WorkoutCategory {
  final String title;
  final List<WorkoutPlan> plans;
  WorkoutCategory({required this.title, required this.plans});
}

class WorkoutPlan {
  final String name;
  final String description;
  final String imagePath;
  final String level; // Added a level property
  WorkoutPlan(
      {required this.name,
      required this.description,
      required this.imagePath,
      required this.level});
}

class WorkoutController extends GetxController {
  final _currentIndex = 0.obs;
  int get currentIndex => _currentIndex.value;
  set currentIndex(int value) => _currentIndex.value = value;

  final pageController = PageController(initialPage: 0);

  // Add a method to update the selected tab index for GetBuilder
  void updateTabIndex(int index) {
    _currentIndex.value = index;
    update(); // This triggers a rebuild for GetBuilder listeners
  }

  void goToPage(int index) {
    _currentIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    updateTabIndex(
        index); // Keep the UI in sync when page changes programmatically
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
