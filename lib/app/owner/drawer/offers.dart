import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myegym/app/widgets/custom_app.dart';
import 'package:myegym/app/widgets/custom_button.dart';
import 'package:myegym/app/widgets/custom_network_image.dart';
import 'package:myegym/controllers/owner_controller.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';

import '../../../data/repo/owner_repo.dart';
import '../../widgets/add_offer_dialog.dart';

class Offers extends StatelessWidget {
  const Offers({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OwnerRepo(apiClient: Get.find()));
    final ownerC = Get.put(OwnerController(ownerRepo: Get.find()));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ownerC.getOffersApi();
    });
    return Scaffold(
      appBar: CustomAppBar(title: "Offers",isBackButtonExist: true,),
      body: GetBuilder<OwnerController>(builder: (controller) {
        final data = controller.offerListing;

        if(data == null || data.isEmpty) {
          return Center(
            child: Text(
              "No Offers Available",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              SizedBox(height: Get.size.height,
                child: SingleChildScrollView(
                  child: ListView.separated(
                    itemCount: data.length,
                      shrinkWrap: true,
                      itemBuilder: (_,i) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomNetworkImageWidget(
                          height: 140,
                            image: data[i]['imageUrl'] ?? "N/A"),
                        sizedBoxDefault(),
                        Text(data[i]['title'] ?? "N/A",
                        style: notoSansRegular.copyWith(
                          color: Colors.white,
                          fontSize: Dimensions.fontSize14
                        ),),
                        // sizedBoxDefault(),
                        // Text(data[i]['description'] ?? "N/A",
                        //   style: notoSansRegular.copyWith(
                        //       color: Colors.white,
                        //       fontSize: Dimensions.fontSize14
                        //   ),)

                      ],
                    );
                  }, separatorBuilder: (BuildContext context, int index) => sizedBoxW10(),)
                ),
              ),
              Positioned(
                bottom: Dimensions.paddingSizeDefault,
                left: 0,right: 0,
                child: CustomButtonWidget(buttonText: "+ Add Offer",
                onPressed: () {
                  Get.dialog(AddOfferDialog(title: 'Add Offers',));

                },),
              )
            ],
          ),
        );
      }),
    );
  }
}
