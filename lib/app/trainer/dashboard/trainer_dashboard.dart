import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myegym/app/trainer/home/trainer_home.dart';
import 'package:myegym/app/trainer/members/members.dart';
import 'package:myegym/app/trainer/profile/profile.dart';
import 'package:myegym/app/trainer/workouts/workout_screen.dart';
import 'package:myegym/app/user/account/account.dart';
import 'package:myegym/app/user/home/user_home.dart';
import 'package:myegym/app/user/home/workout.dart';
import 'package:myegym/app/user/plan/my_plans.dart';
import 'package:myegym/app/user/progress/user_progress.dart';
import 'package:myegym/utils/images.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../members/personal_plan_members.dart';

class TrainerDashboard extends StatefulWidget {
  const TrainerDashboard({super.key});

  @override
  State<TrainerDashboard> createState() => _TrainerDashboardState();
}

class _TrainerDashboardState extends State<TrainerDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    TrainerHome(),
    PersonalPlanMembers(),
    TrainerWorkoutScreen(),
    TrainerProfile(),
    // HomeScreen(),
    // ConnectedWholesellerScreen(),
    // OrdersScreen(),
    // ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor,
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color:
              Theme.of(context).primaryColor, // Background color of the navbar
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home, // Flutter Material icon
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.group_rounded, // Flutter Material icon for members/group
                ),
                label: 'Members',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.fitness_center, // Cupertino icon
                ),
                label: 'Workouts',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.person, // Cupertino icon
                ),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white, // Highlight color
            unselectedItemColor: Colors.white,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            type: BottomNavigationBarType.fixed, // To show all labels
            onTap: _onItemTapped,
            backgroundColor: Colors
                .transparent, // Make the BottomNavigationBar itself transparent
            elevation: 0, // Remove default elevation
          ),
        ),
      ),
    );
  }
}
