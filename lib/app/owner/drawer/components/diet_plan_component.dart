import 'package:flutter/material.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';

class DietPlanComponent extends StatelessWidget {
  final String title;
  final int lenght;
  final String img;
  const DietPlanComponent(
      {super.key,
      required this.title,
      required this.lenght,
      required this.img});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Gain Weight Plans",
          style: notoSansSemiBold.copyWith(
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 180,
          child: ListView.separated(
            itemCount: lenght,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (_, i) {
              return Image.asset(
                img,
                height: 160,
                width: 280,
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                sizedBoxW10(),
          ),
        )
      ],
    );
  }
}
