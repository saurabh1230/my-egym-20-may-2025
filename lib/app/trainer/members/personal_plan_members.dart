import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myegym/app/owner/drawer/add_personal_trainer.dart';
import 'package:myegym/app/owner/drawer/owner_drawer.dart';
import 'package:myegym/app/trainer/members/components/add_member_screen.dart';
import 'package:myegym/app/trainer/members/components/trainer_Card.dart';
import 'package:myegym/app/trainer/members/member_details_screen.dart';
import 'package:myegym/app/widgets/add_new_member_bottomsheert.dart';
import 'package:myegym/app/widgets/custom_app.dart';
import 'package:myegym/app/widgets/custom_button.dart';
import 'package:myegym/app/widgets/custom_containers.dart';
import 'package:myegym/controllers/member_controller.dart';
import 'package:myegym/data/repo/member_repo.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';

import '../../widgets/confirmation_dialog.dart';
import 'edit_member.dart';

class PersonalPlanMembers extends StatelessWidget {
  PersonalPlanMembers({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Get.put(MemberRepo(apiClient: Get.find()));
   final c = Get.put(MemberController(memberRepo: Get.find()));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      c.personalPlanMembers();
    });
    return Scaffold(
        key: _scaffoldKey,
        drawer: const OwnerDrawer(),
        appBar: CustomAppBar(
          isLogo: true,
          title: "Members",
        ),
        body: GetBuilder<MemberController>(builder: (memberControl) {
          final list = memberControl.personalPlanMemberList;
          final isListEmpty = list == null;
          return isListEmpty
              ? Center(
            child: Text(
              "No Data Available",
              style: notoSansRegular.copyWith(color: Colors.white),
            ),
          )
              : SingleChildScrollView(
            child: Padding(
              padding:
              const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomButtonWidget(
                          iconColor: Theme.of(context).primaryColor,
                          buttonText: "Filter",
                          fontSize: Dimensions.fontSize14,
                          textColor: Theme.of(context).primaryColor,
                          icon: Icons.tune,
                          onPressed: () {},
                          transparent: true,
                        ),
                      ),
                      sizedBoxW10(),
                      Expanded(
                        child: CustomButtonWidget(
                          buttonText: "Add New Member",
                          fontSize: Dimensions.fontSize14,
                          icon: Icons.add,
                          iconColor: Colors.white,
                          onPressed: () {
                            Get.to(() => AddMemberScreen(isByTrainer: true,));
                          },
                        ),
                      )
                    ],
                  ),
                  sizedBoxDefault(),
                  ListView.separated(
                    itemCount: list.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (_, i) {
                      var member =
                      list[i]; // Accessing each member from the list
                      return Column(
                        children: [
                          TrainerCard(
                            personImg: member['image_url'] ??
                                'default_image_url', // Fallback if 'photo' is null
                            idNo: member['trainee_id'] ??
                                'N/A', // Fallback if 'trainee_id' is null
                            dataTitle1: "Name",
                            data1: member['full_name'] ??
                                'No Name', // Fallback if 'full_name' is null
                            dataTitle2: "Mobile",
                            data2: member['phone_number'] ??
                                'No Mobile', // Fallback if 'phone_number' is null
                            dataTitle3: "Plan Expiry",
                            data3: member['membership_end_date'] ??
                                'No Expiry', // Fallback if 'membership_end_date' is null
                            dataTitle4: "Due Amount",
                            data4: (member['due_amount'] is int
                                ? 'Rs. ${member['due_amount'].toString()}'
                                : 'Rs. ${member['due_amount'] ?? '0'}'), // Fallback if 'due_amount' is null
                            trashTap: () {
                              Get.dialog(ConfirmationDialog(
                                icon: Icons.delete,
                                description:
                                'Are You Sure to Delete this Member?',
                                onYesPressed: () {
                                  memberControl.deleteMemberApi(
                                    id: (member['id'] ?? 0)
                                        .toString(), // Ensure 'id' is treated as a String
                                  );
                                },
                              ));
                            },
                            detailsTap: () {
                              Get.to(() => MemberDetailsScreen(id: member['id'].toString(), name: member['full_name'], userId: member['user_id'].toString() ,

                                isFromOwner: false,));
                            },
                            edit: () {
                              Get.to(() => EditMemberScreen(memberList: member,));
                            },
                            personalTrainerTap: () {
                              Get.to(() => AddPersonalTrainer(memberID: member['user_id'].toString(), memberName: member['full_name'] ??
                                  'No Name',));
                            },
                          )
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        sizedBoxDefault(),
                  )
                ],
              ),
            ),
          );
        }));
  }
}
