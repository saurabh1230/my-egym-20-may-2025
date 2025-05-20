import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myegym/app/user/plan/components/todays_meal.dart';
import 'package:myegym/app/widgets/custom_containers.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';

class PlanSubscribedComponent extends StatelessWidget {
  final Color? color;
  final String? title;
  final String heading1;
  final String heading2;
  final String dataTitle1;
  final String data1;
  final String dataTitle2;
  final String data2;
  final String dataTitle3;
  final String data3;
  final bool? isShowTitle;
  const PlanSubscribedComponent(
      {super.key,
      this.color,
      this.title = '',
      required this.heading1,
      required this.heading2,
      required this.dataTitle1,
      required this.data1,
      required this.dataTitle2,
      required this.data2,
      required this.dataTitle3,
      required this.data3,
      this.isShowTitle = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: notoSansRegular.copyWith(
              fontSize: Dimensions.fontSize14, color: Colors.white),
        ),
        sizedBoxDefault(),
        CustomDecoratedContainer(
          isBorder: true,
          color: isShowTitle! ? Colors.white : Colors.transparent,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    heading1,
                    style: notoSansRegular.copyWith(
                        fontSize: Dimensions.fontSize14,
                        color: Theme.of(context).hintColor),
                  ),
                  Text(
                    heading2,
                    style: notoSansRegular.copyWith(
                        color: isShowTitle! ? Colors.black : Colors.white),
                  )
                ],
              ),
              Divider(
                color: isShowTitle! ? Colors.black : Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  column(context, title: dataTitle1!, desc: data1!),
                  column(context, title: dataTitle2!, desc: data2!),
                  column(context, title: dataTitle3!, desc: data3!),
                ],
              ),
              isShowTitle!
                  ? GestureDetector(
                      onTap: () {
                        Get.to(() => TodaysMeal());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: Dimensions.paddingSize10),
                        child: Text(
                          "View Today’s Meal",
                          style: notoSansSemiBold.copyWith(
                            color: Colors.red,
                            decoration: TextDecoration
                                .underline, // 👈 underline added here
                          ),
                        ),
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ],
    );
  }

  Column column(BuildContext context,
      {required String title, required String desc}) {
    return Column(
      children: [
        Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          title,
          style: notoSansRegular.copyWith(
              color: isShowTitle! ? Colors.black : Colors.white),
        ),
        Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          desc,
          style: notoSansRegular.copyWith(
              fontSize: Dimensions.fontSize14,
              color: Theme.of(context).hintColor),
        )
      ],
    );
  }
}
