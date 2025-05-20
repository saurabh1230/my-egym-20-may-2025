import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myegym/app/widgets/custom_containers.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/images.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';

class ProgressDetailsCard extends StatelessWidget {
  final bool? hideDesc;
  final String img;
  final String? km1;
  final String? km2;
  final String? secondTitle;
  final String? secondTitleData;
  const ProgressDetailsCard(
      {super.key,
      this.hideDesc = false,
      required this.img,
      this.km1 = '',
      this.km2 = '',
      this.secondTitle = '',
      this.secondTitleData});

  @override
  Widget build(BuildContext context) {
    return CustomDecoratedContainer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 50,
              padding: EdgeInsets.all(Dimensions.paddingSize10),
              decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor.withOpacity(0.20),
                  shape: BoxShape.circle),
              child: SvgPicture.asset(img),
            ),
            sizedBoxW15(),
            Flexible(
              child: hideDesc!
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          secondTitle!,
                          style: notoSansSemiBold.copyWith(
                              fontSize: Dimensions.fontSize15,
                              color: Theme.of(context).hintColor),
                        ),
                        Text(
                          secondTitleData!,
                          style: notoSansRegular.copyWith(
                              fontSize: Dimensions.fontSizeDefault,
                              color: Colors.white),
                        )
                      ],
                    )
                  : RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 18.0),
                        children: <TextSpan>[
                          TextSpan(
                            text: km1,
                            style: notoSansRegular.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                                color: Colors.red),
                          ),
                          TextSpan(
                            text: ' / ',
                            style: notoSansRegular.copyWith(
                                fontSize: Dimensions.fontSize12,
                                color: Theme.of(context).hintColor),
                          ),
                          TextSpan(
                            text: km2,
                            style: notoSansRegular.copyWith(
                                fontSize: Dimensions.fontSize12,
                                color: Theme.of(context).hintColor),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
        hideDesc!
            ? SizedBox()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sizedBox30(),
                  Text(
                    "Calories Burned",
                    style: notoSansSemiBold.copyWith(
                        fontSize: Dimensions.fontSize15,
                        color: Theme.of(context).hintColor),
                  ),
                  Text(
                    secondTitle!,
                    style: notoSansMedium,
                  )
                ],
              ),
      ],
    ));
  }
}
