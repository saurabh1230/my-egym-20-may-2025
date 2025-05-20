import 'package:flutter/material.dart';
import 'package:myegym/app/widgets/custom_containers.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';

class SubscribedWorkout extends StatelessWidget {
  const SubscribedWorkout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Subscribed Workout Plans",
          style: notoSansRegular.copyWith(
              fontSize: Dimensions.fontSize14, color: Colors.white),
        ),
        sizedBoxDefault(),
        SizedBox(
          height: 180,
          child: ListView.separated(
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, i) {
              return SizedBox(
                width: 240,
                child: CustomImageContainer(
                  img: "assets/images/demo_subsribed_wrokout.png",
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                sizedBoxW10(),
          ),
        ),
      ],
    );
  }
}
