import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myegym/app/widgets/custom_app.dart';
import 'package:myegym/controllers/member_controller.dart';
import 'package:myegym/controllers/owner_controller.dart';
import 'package:myegym/data/repo/member_repo.dart';

class MemberDetailsScreen extends StatelessWidget {
  final String id;
  final String name;
  const MemberDetailsScreen({super.key, required this.id, required this.name});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MemberRepo(apiClient: Get.find()));
    Get.lazyPut(() => MemberController(memberRepo: Get.find()));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<MemberController>().getMemberDetails(id: id);
    });
    return Scaffold(
        appBar: CustomAppBar(title: name),
        body: GetBuilder<OwnerController>(builder: (ownerControl) {
          return SingleChildScrollView(
            child: Column(
              children: [],
            ),
          );
        }));
  }
}
