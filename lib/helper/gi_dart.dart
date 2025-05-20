import 'package:get/get.dart';
import 'package:myegym/controllers/auth_controller.dart';
import 'package:myegym/controllers/data_controller.dart';
import 'package:myegym/controllers/helper_controller.dart';
import 'package:myegym/controllers/member_controller.dart';
import 'package:myegym/controllers/owner_controller.dart';
import 'package:myegym/controllers/plans_controller.dart';
import 'package:myegym/controllers/trainer_controllers.dart';
import 'package:myegym/data/api/api_client.dart';
import 'package:myegym/data/repo/auth_repo.dart';
import 'package:myegym/data/repo/data_repo.dart';
import 'package:myegym/data/repo/member_repo.dart';
import 'package:myegym/data/repo/owner_repo.dart';
import 'package:myegym/data/repo/plan_repo.dart';
import 'package:myegym/data/repo/trainer_repo.dart';
import 'package:myegym/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  /// Repository
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));

  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => TrainerRepo(
        apiClient: Get.find(),
      ));
  Get.lazyPut(() => DataRepo(apiClient: Get.find()));
  Get.lazyPut(() => MemberRepo(apiClient: Get.find()));
  Get.lazyPut(() => OwnerRepo(apiClient: Get.find()));
  Get.lazyPut(() => PlanRepo(apiClient: Get.find()));

  /// Controller
  Get.lazyPut(() =>
      AuthController(authRepo: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => TrainerController(trainerRepo: Get.find()));
  Get.lazyPut(() => DataController(dataRepo: Get.find()));
  Get.lazyPut(() => HelperController());
  Get.lazyPut(() => MemberController(memberRepo: Get.find()));
  Get.lazyPut(() => OwnerController(ownerRepo: Get.find()));
  Get.lazyPut(() => PlansController(planRepo: Get.find()));
}
