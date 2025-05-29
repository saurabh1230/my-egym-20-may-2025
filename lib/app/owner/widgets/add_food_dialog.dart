
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



class AddFoodDialog extends StatelessWidget {
  final String title;



  AddFoodDialog({super.key,
    required this.title,

  });


  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _fatsController = TextEditingController();
  final TextEditingController _carbohydratesController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _calorieController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

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
                SizedBox(height: Get.size.height,
                  child: SingleChildScrollView(
                    child: SizedBox(width: 500, child: Padding(
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
                            hintText: "Food Name",
                            controller: _foodNameController,
                            validation: Validators.validate
                        ),
                        sizedBoxDefault(),
                        CustomTextField(
                            showTitle: true,
                            inputType: TextInputType.number,
                            hintText: "Protein (in grams)",
                            controller: _proteinController,
                            validation: Validators.validate
                        ),
                        sizedBoxDefault(),
                        CustomTextField(
                            showTitle: true,
                            inputType: TextInputType.number,
                            hintText: "Fats (in grams)",
                            controller: _fatsController,
                            validation: Validators.validate
                        ),
                        sizedBoxDefault(),
                        CustomTextField(
                            showTitle: true,
                            inputType: TextInputType.number,
                            hintText: "Carbohydrates (in grams)",
                            controller: _carbohydratesController,
                            validation: Validators.validate
                        ),
                        sizedBoxDefault(),
                        CustomTextField(
                            showTitle: true,
                            inputType: TextInputType.number,
                            hintText: "Quantity",
                            controller: _quantityController,
                            validation: Validators.validate
                        ),
                        sizedBoxDefault(),
                        CustomTextField(
                            showTitle: true,
                            inputType: TextInputType.number,
                            hintText: "Calories (in kcal)",
                            controller: _calorieController,
                            validation: Validators.validate
                        ),
                        sizedBoxDefault(),
                        CustomTextField(
                            showTitle: true,
                            inputType: TextInputType.number,
                            hintText: "Unit",
                            controller: _unitController,
                            validation: Validators.validate
                        ),
                        sizedBoxDefault(),
                        CustomTextField(
                            maxLines: 4,
                            showTitle: true,
                            capitalization: TextCapitalization.words,
                            hintText: "Notes",
                            controller: _noteController,
                            validation: Validators.validate
                        ),
                        sizedBox100(),
                      ]),
                    )),
                  ),
                ),
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
                          controller.addFoodItem(foodName: _foodNameController.text.trim(),
                            protein: _proteinController.text.trim(),
                            fats: _fatsController.text.trim(),
                            carbohydrates: _carbohydratesController.text.trim(),
                            quantity: _quantityController.text.trim(),
                            calorie: _calorieController.text.trim(),
                            unit: _unitController.text.trim(),
                            note: _noteController.text.trim(),);

                        } else {
                          showCustomSnackBar(context, "Please Add Required Fields");
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