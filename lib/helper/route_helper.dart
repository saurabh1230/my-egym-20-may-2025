import 'package:get/get.dart';
import 'package:myegym/app/owner/dashboard/owner_dashboard.dart';
import 'package:myegym/app/trainer/dashboard/trainer_dashboard.dart';
import 'package:myegym/app/user/dashboard/user_dashboard.dart';
import 'package:myegym/app/views/auth/login.dart';
import 'package:myegym/app/views/auth/splash_screen.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String login = '/login';
  static const String userDashboard = '/userDashboard';
  static const String trainerDashboard = '/trainerDashboard';
  static const String ownerDashboard = '/ownerDashboard';

  /// Routes ==================>
  static String getInitialRoute() => initial;
  static String getSplashRoute() => splash;
  static String getLogin() => login;
  static String getUserDashboard() => userDashboard;
  static String getTrainerDashboard() => trainerDashboard;
  static String getOwnerDashboard() => ownerDashboard;

  /// Pages ==================>
  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const SplashScreen()),
    GetPage(name: login, page: () => Login()),
    GetPage(name: userDashboard, page: () => UserDashboard()),
    GetPage(name: trainerDashboard, page: () => TrainerDashboard()),
    GetPage(name: ownerDashboard, page: () => OwnerDashboard()),
  ];
}
