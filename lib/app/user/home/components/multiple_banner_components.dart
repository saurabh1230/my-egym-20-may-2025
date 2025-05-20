import 'package:flutter/material.dart';
import 'package:myegym/app/widgets/custom_containers.dart';
import 'package:myegym/utils/sizeboxes.dart';

class MultipleBannerComponents extends StatelessWidget {
  const MultipleBannerComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, i) {
          return SizedBox(
            width: 300,
            child: CustomImageContainer(
              img: "assets/images/ic_home_demo_user.png",
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => sizedBoxW10(),
      ),
    );
  }
}
