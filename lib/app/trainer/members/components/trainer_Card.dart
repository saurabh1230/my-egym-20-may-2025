import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myegym/app/widgets/custom_containers.dart';
import 'package:myegym/app/widgets/custom_network_image.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';

class TrainerCard extends StatelessWidget {
  final String personImg;
  final String idNo;
  final String dataTitle1;
  final String data1;
  final String dataTitle2;
  final String data2;
  final String dataTitle3;
  final String data3;
  final String dataTitle4;
  final String data4;
  final Function() trashTap;
  final Function() edit;
  final Function() detailsTap;
  final Function()? personalTrainerTap;
  final bool? isTrainer;
  const TrainerCard(
      {super.key,
      required this.personImg,
      required this.idNo,
      required this.dataTitle1,
      required this.data1,
      required this.dataTitle2,
      required this.data2,
      required this.dataTitle3,
      required this.data3,
      required this.dataTitle4,
      required this.data4,
      required this.trashTap,
        required this.edit,
      required this.detailsTap, this.personalTrainerTap, this.isTrainer = false});

  @override
  Widget build(BuildContext context) {
    return CustomDecoratedContainer(
        color: Theme.of(context).cardColor,
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    CustomNetworkRoundImageWidget(
                        height: 80, width: 80, image: personImg),
                    sizedBox10(),
                    Text(
                      "ID: $idNo",
                      style: notoSansBold.copyWith(
                          fontSize: Dimensions.fontSize12, color: Colors.black),
                    )
                  ],
                ),
                sizedBoxW10(),
                Flexible(
                  child: Column(
                    children: [
                      row(context, dataTitle: dataTitle1, data: data1),
                      row(context, dataTitle: dataTitle2, data: data2),
                      row(context, dataTitle: dataTitle3, data: data3),
                      row(context, dataTitle: dataTitle4, data: data4),
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: trashTap,
                        icon: Icon(
                          CupertinoIcons.trash,
                          color: Colors.red,
                          size: Dimensions.fontSize20,
                        )),
                    IconButton(
                        onPressed: edit,
                        icon: Icon(
                          Icons.edit_note,
                          color: Colors.red,
                          size: Dimensions.fontSize24,
                        )),
                  ],
                ),
                TextButton(
                    onPressed: detailsTap,
                    child: Text(
                      "View Details",
                      style: notoSansSemiBold.copyWith(
                        fontSize: Dimensions.fontSize14,
                        color: Colors.red,
                        decoration: TextDecoration.underline, // Add this line
                      ),
                    ))
              ],
            ),

          ],
        ));
  }

  Padding row(BuildContext context,
      {required String dataTitle, required String data}) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              dataTitle,
              style: notoSansRegular.copyWith(
                  fontSize: Dimensions.fontSize12,
                  color: Theme.of(context).disabledColor.withOpacity(0.70)),
            ),
          ),
          Expanded(
            child: Text(
              maxLines: 1,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              data,
              style: notoSansSemiBold.copyWith(
                  fontSize: Dimensions.fontSize14, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
