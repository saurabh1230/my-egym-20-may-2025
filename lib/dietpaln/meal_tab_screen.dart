import 'package:flutter/material.dart';
import '../controllers/diet_plan_controller.dart';
import 'monday.dart';
import 'tuesday.dart';
import 'wednesday.dart';
import 'thursday.dart';
import 'friday.dart';
import 'saturday.dart';
import 'sunday.dart';
import 'package:get/get.dart';


class MealTabScreen extends StatefulWidget {
  final DietPlanController controller;
  final int monthId;
  final int weekId;

  const MealTabScreen({
    super.key,
    required this.controller,
    required this.monthId,
    required this.weekId,
  });

  @override
  State<MealTabScreen> createState() => _MealTabScreenState();
}


class _MealTabScreenState extends State<MealTabScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late final DietPlanController controller;

  final List<Tab> tabs = const [
    Tab(text: 'Monday'),
    Tab(text: 'Tuesday'),
    Tab(text: 'Wednesday'),
    Tab(text: 'Thursday'),
    Tab(text: 'Friday'),
    Tab(text: 'Saturday'),
    Tab(text: 'Sunday'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);

    controller = Get.find<DietPlanController>();
  }

  void goToNextTab() {
    if (_tabController.index < tabs.length - 1) {
      _tabController.animateTo(_tabController.index + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Add Meal",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.red,
          unselectedLabelColor: Colors.black,
          indicatorColor: Colors.red,
          tabs: tabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Monday(onNext: goToNextTab, monthId: widget.monthId, weekId: widget.weekId),
          Tuesday(onNext: goToNextTab, monthId: widget.monthId, weekId: widget.weekId),
          Wednesday(onNext: goToNextTab, monthId: widget.monthId, weekId: widget.weekId),
          Thursday(onNext: goToNextTab, monthId: widget.monthId, weekId: widget.weekId),
          Friday(onNext: goToNextTab, monthId: widget.monthId, weekId: widget.weekId),
          Saturday(onNext: goToNextTab, monthId: widget.monthId, weekId: widget.weekId),
          Sunday(onNext: goToNextTab, monthId: widget.monthId, weekId: widget.weekId),
        ],
      ),
    );
  }
}
