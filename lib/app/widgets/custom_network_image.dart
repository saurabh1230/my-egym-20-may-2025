import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../utils/dimensions.dart';
import '../../utils/images.dart';

class CustomNetworkImageWidget extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final String placeholder;
  final double? radius;
  final double? imagePadding;
  final bool? isProfilePlaceHolder;
  const CustomNetworkImageWidget(
      {super.key,
      required this.image,
      this.height,
      this.width,
      this.fit = BoxFit.cover,
      this.placeholder = '',
      this.radius,
      this.imagePadding,
      this.isProfilePlaceHolder = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 200,
      width: width ?? Get.size.width,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          // color: Colors.grey[200],
          borderRadius: BorderRadius.circular(radius ?? Dimensions.radius20)),
      child: CachedNetworkImage(
        imageUrl: image,
        height: height,
        width: width,
        fit: fit,
        placeholder: (context, url) =>
            Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Padding(
          padding: EdgeInsets.all(imagePadding ?? 0),
          child: SvgPicture.asset(
              placeholder.isNotEmpty
                  ? placeholder
                  : isProfilePlaceHolder!
                      ? Images.icProfilePlaceHolder
                      : Images.placeholder,

       ),
        ),
      ),
    );
  }
}

class CustomNetworkRoundImageWidget extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final String placeholder;
  final double? radius;
  final double? imagePadding;
  final bool? isProfilePlaceHolder;
  const CustomNetworkRoundImageWidget(
      {super.key,
      required this.image,
      this.height,
      this.width,
      this.fit = BoxFit.cover,
      this.placeholder = '',
      this.radius,
      this.imagePadding,
      this.isProfilePlaceHolder = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 120,
      width: width ?? 120,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey,
        // borderRadius: BorderRadius.circular(radius ?? Dimensions.radius20)
      ),
      child: CachedNetworkImage(
        imageUrl: image,
        height: height,
        width: width,
        fit: fit,
        placeholder: (context, url) =>
            Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Padding(
          padding: EdgeInsets.all(imagePadding ?? 6),
          child: SvgPicture.asset(
            Images.svgProfilePlaceholder,
            fit: fit!,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
