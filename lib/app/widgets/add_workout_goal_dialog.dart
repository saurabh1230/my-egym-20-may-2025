
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myegym/app/widgets/custom_textfield.dart';
import 'package:myegym/controllers/owner_controller.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';
import 'package:myegym/utils/theme/light_theme.dart';
import '../../utils/dimensions.dart';
import 'custom_button.dart';


class AddWorkoutGoalDialog extends StatelessWidget {
  final IconData icon;
  final String? title;



   AddWorkoutGoalDialog({super.key,
    required this.icon, this.title,

  });


  final TextEditingController titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radius10)),
      insetPadding: const EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: GetBuilder<OwnerController>(builder: (controller) {
        return  SizedBox(width: 500, child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSize20),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Align(alignment: Alignment.centerRight,
              child: IconButton(onPressed: () {
                Get.back();
              }, icon: Icon(Icons.close)),
            ),

            Padding(
              padding: const EdgeInsets.all(0),
              child: Icon(icon,size: 80,
                color: Colors.red,),
            ),
            // title != null ? Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSize20),
            //   child: Text(
            //     title!, textAlign: TextAlign.center,
            //     style: notoSansMedium.copyWith(fontSize: Dimensions.fontSize20, color: Colors.red),
            //   ),
            // ) : const SizedBox(),
            sizedBoxDefault(),
            CustomTextField(
              showTitle: true,
              capitalization: TextCapitalization.words,
              hintText: "Title of Workout Goal",
              controller: titleController,
              validation: (title) {
                if (title == null || title.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            sizedBoxDefault(),
            Row(children: [
              Expanded(child: TextButton(
                onPressed: () => Get.back(),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.redAccent, minimumSize: const Size(1170, 40), padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radius10)),
                ),
                child: Text(
                  'No', textAlign: TextAlign.center,
                  style: notoSansBold.copyWith(color: Theme.of(context).cardColor),
                ),
              )),
              const SizedBox(width: Dimensions.paddingSize20),

              Expanded(child: CustomButtonWidget(
                color: greenColor,
                buttonText:'+ Add',
                borderSideColor: greenColor,
                onPressed: () {
                  controller.addWorkoutGoal(name :titleController.text.trim());

                },
                height: 40,
              )),

            ]),
          ]),
        ));
      })


    );
  }
}