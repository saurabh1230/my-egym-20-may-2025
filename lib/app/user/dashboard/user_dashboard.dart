import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myegym/app/user/account/account.dart';
import 'package:myegym/app/user/home/user_home.dart';
import 'package:myegym/app/user/plan/my_plans.dart';
import 'package:myegym/app/user/progress/user_progress.dart';
import 'package:myegym/utils/images.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    UserHome(),
    UserProgress(),
    MyPlans(),
    Account(),
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
                  Icons.show_chart_rounded, // Flutter Material icon
                ),
                label: 'Progress',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.bag, // Cupertino icon
                ),
                label: 'My Plans',
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
