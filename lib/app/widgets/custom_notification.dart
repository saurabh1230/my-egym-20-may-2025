import 'package:flutter/material.dart';
import 'package:myegym/utils/dimensions.dart';

class CustomNotificationButton extends StatelessWidget {
  final Function() tap;
  final IconData? icon;
  final Color? color;
  const CustomNotificationButton(
      {super.key, required this.tap, this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: tap,
      icon: Icon(
        icon ?? Icons.notifications_outlined,
        size: Dimensions.fontSize24,
        color: color ?? Colors.white,
      ),
    );
  }
}
