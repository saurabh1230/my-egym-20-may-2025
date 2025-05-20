import 'package:flutter/material.dart';
import 'package:myegym/app/widgets/custom_app.dart';
import 'package:get/get.dart';
import 'package:myegym/app/widgets/custom_button.dart';
import 'package:myegym/app/widgets/custom_containers.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';

class OwnerMyPurchases extends StatelessWidget {
  const OwnerMyPurchases({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "My Purchase",
          isBackButtonExist: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(
              children: [
                Image.asset(
                    height: 180,
                    width: Get.size.width,
                    "assets/images/ic_home_demo_user.png"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        "Plan Name XYZ",
                        style: notoSansSemiBold.copyWith(
                            fontSize: Dimensions.fontSize18,
                            color: Colors.white),
                      ),
                    ),
                    CustomDecoratedContainer(
                        verticlePadding: Dimensions.paddingSize4,
                        horizontalPadding: Dimensions.paddingSize10,
                        color: Colors.white,
                        child: Text(
                          "1 Year",
                          style: notoSansSemiBold.copyWith(
                              fontSize: Dimensions.fontSize14,
                              color: Theme.of(context).primaryColor),
                        ))
                  ],
                ),
                sizedBoxDefault(),
                Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                  style: notoSansRegular.copyWith(
                      color: Theme.of(context).hintColor,
                      fontSize: Dimensions.fontSize14),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "Due Date:",
                        style: notoSansSemiBold.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: Dimensions.fontSize15),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        "20-02-2025",
                        style: notoSansBold.copyWith(
                            color: Colors.white,
                            fontSize: Dimensions.fontSize15),
                      ),
                    )
                  ],
                ),
                sizedBoxDefault(),
                CustomButtonWidget(
                  buttonText: "Upgrade Plan",
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
