
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myegym/app/widgets/custom_snackbar.dart';
import 'package:myegym/app/widgets/custom_textfield.dart';
import 'package:myegym/controllers/owner_controller.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';
import 'package:myegym/utils/theme/light_theme.dart';
import '../../../controllers/helper_controller.dart';
import '../../../data/repo/owner_repo.dart';
import '../../../helper/validations.dart';
import '../../../utils/dimensions.dart';
import '../../widgets/custom_button.dart';



class AddPlanDurationDialog extends StatelessWidget {
  final String title;



  AddPlanDurationDialog({super.key,
    required this.title,

  });


  final TextEditingController _nameController = TextEditingController();



  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => OwnerRepo(apiClient: Get.find()));
    Get.lazyPut(() => OwnerController(ownerRepo: Get.find()));
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radius10)),
        insetPadding: const EdgeInsets.all(30),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: GetBuilder<OwnerController>(builder: (controller) {
          return  Form(
            key: _formKey,
            child: Stack(
              children: [
                SizedBox(width: 500, child: Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSize20),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Align(alignment: Alignment.centerRight,
                      child: IconButton(onPressed: () {
                        Get.back();
                      }, icon: Icon(Icons.close)),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSize20),
                      child: Text(
                        title, textAlign: TextAlign.center,
                        style: notoSansMedium.copyWith(fontSize: Dimensions.fontSize20, color: Colors.red),
                      ),
                    ),
                    sizedBoxDefault(),
                    CustomTextField(
                        showTitle: true,
                        capitalization: TextCapitalization.words,
                        hintText: "Plan Duration",
                        controller: _nameController,
                        validation: Validators.validate
                    ),
                    sizedBox65(),
                  ]),
                )),
                Positioned(bottom: Dimensions.paddingSize10,
                  left: Dimensions.paddingSizeDefault,
                  right: Dimensions.paddingSizeDefault,
                  child: Row(children: [
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
                        if(_formKey.currentState!.validate()) {
                          controller.addPackageDuration(name:  _nameController.text.trim(),);

                        } else {
                          showCustomSnackBar(context, "Please Add Required Field");
                        }


                      },
                      height: 40,
                    )),

                  ]),
                ),
              ],
            ),
          );
        })


    );
  }
}