import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:myegym/utils/dimensions.dart';

class CustomDecoratedContainer extends StatelessWidget {
  final Widget child;
  final Color? color;
  final bool? isBorder;
  final double? verticlePadding;
  final double? horizontalPadding;
  const CustomDecoratedContainer(
      {super.key,
      required this.child,
      this.color,
      this.isBorder = false,
      this.verticlePadding,
      this.horizontalPadding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:

      EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? Dimensions.paddingSizeDefault,
          vertical: verticlePadding ?? Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(
          border:
              isBorder! ? Border.all(width: 0.4, color: Colors.white) : null,
          borderRadius: BorderRadius.circular(Dimensions.radius10),
          color: color ?? Colors.black),
      child: child,
    );
  }
}

class CustomImageContainer extends StatelessWidget {
  final String img;
  const CustomImageContainer({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: Get.size.width,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius10)),
      child: Image.asset(
        img,
        fit: BoxFit.cover,
      ),
    );
  }
}

class DecoratedRoundContainer extends StatelessWidget {
  final Widget child;
  final double? padding;
  const DecoratedRoundContainer({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding ?? 8),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.30), shape: BoxShape.circle),
      child: Center(child: child),
    );
  }
}
