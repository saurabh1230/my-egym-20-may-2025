import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myegym/app/owner/drawer/owner_drawer.dart';
import 'package:myegym/app/owner/trainers/components/trainers_card_list.dart';
import 'package:myegym/app/widgets/add_trainer_bottomsheet.dart';
import 'package:myegym/app/widgets/custom_app.dart';
import 'package:myegym/app/widgets/custom_button.dart';

import 'package:myegym/controllers/trainer_controllers.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';

class OwnerTrainerScreen extends StatelessWidget {
  OwnerTrainerScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<TrainerController>().getTrainerList();
    });
    return Scaffold(
      key: _scaffoldKey,
      drawer: const OwnerDrawer(),
      appBar: CustomAppBar(
        title: "Trainers",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSize10,
                    horizontal: Dimensions.paddingSize5),
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.3,
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(Dimensions.radius20)),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Theme.of(context).primaryColor,
                    ),
                    sizedBoxW5(),
                    Text(
                      "Search",
                      style: notoSansRegular.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                ),
              ),
              sizedBoxDefault(),
              Row(
                children: [
                  Expanded(
                    child: CustomButtonWidget(
                      iconColor: Theme.of(context).primaryColor,
                      buttonText: "Filter",
                      fontSize: Dimensions.fontSize14,
                      textColor: Theme.of(context).primaryColor,
                      icon: Icons.tune,
                      onPressed: () {},
                      transparent: true,
                    ),
                  ),
                  sizedBoxW10(),
                  Expanded(
                    child: CustomButtonWidget(
                      buttonText: "Add New Trainer",
                      fontSize: Dimensions.fontSize14,
                      icon: Icons.add,
                      iconColor: Colors.white,
                      onPressed: () {
                        Get.bottomSheet(
                          AddNewTrainerBottomSheet(),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20.0)),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              sizedBoxDefault(),
              TrainersCardList()
            ],
          ),
        ),
      ),
    );
  }
}
