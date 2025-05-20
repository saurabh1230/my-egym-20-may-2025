import 'package:flutter/material.dart';
import 'package:myegym/app/widgets/custom_containers.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';

class MealCardComponent extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  final String contentTitle;
  final IconData icon1;
  final String iconTitle1;
  final IconData icon2;
  final String iconTitle2;

  const MealCardComponent(
      {super.key,
      required this.image,
      required this.title,
      required this.icon1,
      required this.icon2,
      required this.subTitle,
      required this.contentTitle,
      required this.iconTitle1,
      required this.iconTitle2});

  @override
  Widget build(BuildContext context) {
    return CustomDecoratedContainer(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: notoSansRegular.copyWith(color: Colors.white),
            ),
            Flexible(
              child: RichText(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  style: const TextStyle(fontSize: 18.0),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Protein intake : ',
                      style: notoSansRegular.copyWith(
                          fontSize: Dimensions.fontSize12,
                          color: Theme.of(context).hintColor),
                    ),
                    TextSpan(
                      text: subTitle,
                      style: notoSansRegular.copyWith(
                          fontSize: Dimensions.fontSize14, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        sizedBoxDefault(),
        Row(
          children: [
            Image.asset(
              image,
              height: 90,
              width: 90,
            ),
            sizedBoxW10(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contentTitle,
                  style: notoSansRegular.copyWith(color: Colors.white),
                ),
                sizedBox5(),
                Text(
                  "View Recipe",
                  style: notoSansRegular.copyWith(
                      fontSize: Dimensions.fontSize12,
                      color: Theme.of(context).hintColor),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    newMethod(context, icon: icon1, title: iconTitle1),
                    sizedBoxW15(),
                    newMethod(context, icon: icon2, title: iconTitle2),
                  ],
                ),
              ],
            )
          ],
        )
      ],
    ));
  }

  Row newMethod(BuildContext context,
      {required IconData icon, required String title}) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
        sizedBoxW5(),
        Text(
          title,
          style: notoSansRegular.copyWith(
              fontSize: Dimensions.fontSize15,
              color: Theme.of(context).hintColor),
        ),
      ],
    );
  }
}
