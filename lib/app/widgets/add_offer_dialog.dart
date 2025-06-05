
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myegym/app/widgets/custom_snackbar.dart';
import 'package:myegym/app/widgets/custom_textfield.dart';
import 'package:myegym/controllers/helper_controller.dart';
import 'package:myegym/controllers/owner_controller.dart';
import 'package:myegym/data/repo/owner_repo.dart';
import 'package:myegym/helper/validations.dart';
import 'package:myegym/utils/sizeboxes.dart';

import 'package:myegym/utils/styles.dart';
import 'package:myegym/utils/theme/light_theme.dart';
import '../../utils/dimensions.dart';
import 'custom_button.dart';


class AddOfferDialog extends StatelessWidget {
  final String? title;
  AddOfferDialog({super.key,
    required this.title,
  });


  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Get.put(OwnerRepo(apiClient: Get.find()));
   final ownerC = Get.put(OwnerController(ownerRepo: Get.find()));

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radius10)),
      insetPadding: const EdgeInsets.all(16),
      child: GetBuilder<OwnerController>(builder: (ownerControl) {
        return  GetBuilder<HelperController>(builder: (helpController) {
          return Form(key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(title!,style: notoSansSemiBold.copyWith(
                        color: Theme.of(context).primaryColor
                    ),),
                    sizedBoxDefault(),
                    CustomTextField(
                      capitalization: TextCapitalization.words,
                      controller: _titleController,
                      hintText: 'Add Title',
                      validation: Validators.validate,
                    ),
                    sizedBoxDefault(),
                    CustomTextField(maxLines: 5,
                      capitalization: TextCapitalization.words,
                      controller: _descController,
                      hintText: 'Add Description',
                      validation: Validators.validate,
                    ),
                    sizedBoxDefault(),

                    Center(
                      child: SizedBox(
                        height: 120,
                        width: Get.size.width,
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 120,
                                      width: Get.size.width,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 0.5,
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.40),
                                        ),
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.1),
                                      ),
                                      // alignment: Alignment.center,
                                      child: helpController
                                          .pickedDocument !=
                                          null
                                          ? Image.file(
                                        File(
                                          helpController
                                              .pickedDocument!
                                              .path,
                                        ),
                                        height: 90,
                                        width: 90,
                                        fit: BoxFit.cover,
                                      )
                                          : Stack(
                                        children: [
                                          Container(
                                              height: 120,
                                              width: Get
                                                  .size.width,
                                              clipBehavior:
                                              Clip.hardEdge,
                                              decoration:
                                              BoxDecoration(
                                                color: Theme.of(
                                                    context)
                                                    .primaryColor
                                                    .withOpacity(
                                                    0.1),
                                              ),
                                              child: Icon(Icons
                                                  .person)),
                                          // Image.asset(Images.profilePlaceholder,)
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      top: 0,
                                      left: 0,
                                      child: InkWell(
                                        onTap: () => helpController
                                            .pickDocument(
                                            isRemove: false),
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.black
                                                .withOpacity(0.3),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                width: 1,
                                                color: Theme.of(
                                                    context)
                                                    .primaryColor),
                                          ),
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            margin:
                                            const EdgeInsets.all(
                                                25),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 2,
                                                  color:
                                                  Colors.white),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                                Icons
                                                    .insert_drive_file,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    sizedBox10(),
                    Text("Add Identity Document *",
                    style: notoSansRegular.copyWith(
                      color: Theme.of(context).primaryColor
                    ),),
                    sizedBoxDefault(),
                    CustomButtonWidget(buttonText: "+ Add Offer",
                      onPressed: () {
                        if(formKey.currentState!.validate()) {
                          ownerC.addOffersApi(title: _titleController.text,
                              description: _descController.text, photo: helpController
                                  .pickedDocument );


                        } else {
                          showCustomSnackBar(context, "Please Add Required Fields");
                        }
                      },)

                  ],
                ),
              ),
            ),
          );
        });
      })





    );
  }
}