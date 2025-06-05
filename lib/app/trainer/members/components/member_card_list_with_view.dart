import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:myegym/app/owner/trainers/trainer_details.dart';
import 'package:myegym/app/trainer/members/member_details_screen.dart';
import 'package:myegym/controllers/trainer_controllers.dart';
import 'package:myegym/data/models/trainer_details_model.dart';
import 'package:myegym/data/models/trainer_model.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';

class MemberCardListWithView extends StatelessWidget {
  final List<dynamic> members; // Accepting raw data instead of the model

  const MemberCardListWithView({super.key, required this.members});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 120,
              child: Text(
                "Member Name",
                style: notoSansRegular.copyWith(
                    fontSize: Dimensions.fontSize14, color: Colors.red),
              ),
            ),
            sizedBoxW10(),
            Flexible(
              child: Text(
                "Ph No",
                // "Plan End",
                style: notoSansRegular.copyWith(
                    fontSize: Dimensions.fontSize14, color: Colors.red),
              ),
            ),
            Flexible(
              child: TextButton(
                onPressed: () {
                  // You can add navigation logic if needed
                },
                child: Text(
                  "",
                  style: notoSansRegular.copyWith(
                      decoration: TextDecoration.underline,
                      fontSize: Dimensions.fontSize14,
                      color: Colors.red),
                ),
              ),
            ),
          ],
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: members.length, // Use the length of the raw list
          itemBuilder: (_, i) {
            var member = members[i]; // Access the individual member data

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    member['full_name'] ??
                        'Member Name', // Access data from the map
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: notoSansRegular.copyWith(
                        fontSize: Dimensions.fontSize14, color: Colors.black),
                  ),
                ),
                Flexible(
                  child: Text(
                    member['phone_number'] ?? 'N/A',
                    style: notoSansRegular.copyWith(
                        fontSize: Dimensions.fontSize14, color: Colors.black),
                  ),
                ),
                Flexible(
                  child: TextButton(
                    onPressed: () {
                      Get.to(MemberDetailsScreen(
                        id: member['id'].toString(), // Access data from the map
                        name: member['fullName'] ?? '',
                        userId: member['user_id'].toString(),
                      ));
                    },
                    child: Text(
                      "View",
                      style: notoSansRegular.copyWith(
                          decoration: TextDecoration.underline,
                          fontSize: Dimensions.fontSize14,
                          color: Colors.red),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
