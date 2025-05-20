import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myegym/app/widgets/custom_containers.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';

class CustomSingleBannerComponent extends StatelessWidget {
  final String title;
  final String img;
  final Function() tap;
  const CustomSingleBannerComponent(
      {super.key, required this.title, required this.img, required this.tap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: notoSansRegular.copyWith(
                  fontSize: Dimensions.fontSize14, color: Colors.white),
            ),
            sizedBoxDefault(),
            CustomImageContainer(
              img: img,
            )
          ],
        ),
      ),
    );
  }
}
