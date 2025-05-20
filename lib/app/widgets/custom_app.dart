import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myegym/app/widgets/custom_notification.dart';

import 'package:myegym/utils/images.dart';
import 'package:myegym/utils/styles.dart';

import '../../utils/dimensions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isBackButtonExist;
  final bool isLogo;
  final Function? onBackPressed;
  final Widget? menuWidget;
  final bool? isHideNotification;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.isBackButtonExist = false,
    this.menuWidget,
    this.isLogo = false, this.isHideNotification = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title!,
          style: notoSansRegular.copyWith(
              fontSize: Dimensions.fontSize18,
              color: Theme.of(context).cardColor)),
      // centerTitle: true,
      leading: isLogo
          ? Padding(
              padding: const EdgeInsets.only(left: Dimensions.paddingSize20),
              child: SvgPicture.asset(
                Images.onlyLogo,
                height: 24,
                width: 24,
              ),
            )
          : isBackButtonExist
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Theme.of(context).cardColor,
                  onPressed: () => Navigator.pop(context),
                )
              : Builder(
                  builder: (context) => InkWell(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: Container(
                      padding:
                          const EdgeInsets.all(Dimensions.paddingSizeDefault),
                      child: SvgPicture.asset(
                        color: Colors.white,
                        Images.svgMenu,
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ),
                ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      actions: [
        isHideNotification == true ?
            SizedBox() :
        CustomNotificationButton(
          tap: () {},
        )
      ],
      // actions: menuWidget != null
      //     ? [
      //         Padding(
      //           padding: const EdgeInsets.symmetric(
      //               horizontal: Dimensions.paddingSizeDefault),
      //           child: menuWidget!,
      //         )
      //       ]
      //     : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
