// Helper method to build info row
import 'package:flutter/material.dart';

import '../../utils/dimensions.dart';
import '../../utils/styles.dart';

class DetailInfoTextbox extends StatelessWidget {
  final String title;
  final String data;
  const DetailInfoTextbox({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
    children: [
    Expanded(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    title,
    style: notoSansRegular.copyWith(
    color: Theme.of(context).disabledColor.withOpacity(0.70),
    fontSize: Dimensions.fontSize12,
    ),
    ),
    Text(
    data,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: notoSansRegular.copyWith(
    color: Colors.black,
    fontSize: Dimensions.fontSize14,
  ),
  ),
  ],
  ),
  ),
  ],
  ),
  );
  }
}
