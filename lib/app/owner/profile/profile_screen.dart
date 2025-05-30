import 'package:flutter/material.dart';
import 'package:myegym/app/owner/drawer/owner_drawer.dart';
import 'package:myegym/app/owner/profile/edit_profile.dart';
import 'package:myegym/app/widgets/custom_app.dart';
import 'package:myegym/app/widgets/custom_button.dart';
import 'package:myegym/app/widgets/custom_containers.dart';
import 'package:myegym/app/widgets/custom_network_image.dart';
import 'package:myegym/controllers/owner_controller.dart';
import 'package:myegym/data/repo/owner_repo.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';
import 'package:get/get.dart';

class OwnerProfile extends StatelessWidget {
  OwnerProfile({super.key}) {
    Get.lazyPut(() => OwnerRepo(apiClient: Get.find()));
    Get.put(OwnerController(ownerRepo: Get.find()));

    // Fetch owner profile immediately
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<OwnerController>().getOwnerProfileApi();
    });
    return Scaffold(
      key: _scaffoldKey,
      drawer: const OwnerDrawer(),
      appBar: CustomAppBar(
        isLogo: true,
        title: "Profile",
      ),
      body: GetBuilder<OwnerController>(builder: (ownerControl) {
        final data = ownerControl.ownerProfileDetails;

        if (data == null) {
          return const Center(child: CircularProgressIndicator());
        }

        // Safely access nested properties using null-aware operators
        final profileImage =
            (data as Map<String, dynamic>?)?['image_url']?.toString();
        final ownerName =
            (data as Map<String, dynamic>?)?['name'] as String? ?? '';
        final phoneNumber =
            (data as Map<String, dynamic>?)?['phone_number'] as String? ?? '';
        final email =
            (data as Map<String, dynamic>?)?['email'] as String? ?? '';

        return SizedBox(height: Get.size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomDecoratedContainer(
                    child: Row(
                      children: [
                        CustomNetworkRoundImageWidget(
                          height: 120,
                          width: 120,
                          image: profileImage ?? '', // Provide a default if null
                        ),
                        sizedBoxW10(),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Owner",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: notoSansRegular.copyWith(
                                  fontSize: Dimensions.fontSize14,
                                  color: Colors.white.withOpacity(0.60),
                                ),
                              ),
                              Text(
                                ownerName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: notoSansRegular.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "+91 $phoneNumber",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: notoSansRegular.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                email,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: notoSansRegular.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  sizedBox20(),
                  Text(
                    "Profile Details",
                    style: notoSansSemiBold.copyWith(
                      fontSize: Dimensions.fontSize20,
                      color: Colors.white,
                    ),
                  ),
                  sizedBox10(),
                  row(context, title: 'Years of Experience:', data: '1 Year'),
                  row(context, title: 'Salary:', data: '₹ 20000'),
                  row(context, title: 'Joining Date:', data: '20-02-2026'),
                  row(
                    context,
                    title: 'Address:',
                    data: 'Lorem Ipsum is simply dummy text of the printing',
                  ),
                ],
              ),
            ),
          ),
        );
      }),
      bottomNavigationBar: GetBuilder<OwnerController>(builder: (ownerControl) {
        final data = ownerControl.ownerProfileDetails;

        if (data == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: CustomButtonWidget(buttonText: "Edit",
              onPressed: () {
                Get.to(() => EditProfile(ownerProfileDetails:data,));
              },),),
        );
      })

    );
  }

  Padding row(BuildContext context,
      {required String title, required String data}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: notoSansRegular.copyWith(
                fontSize: Dimensions.fontSize14,
                color: Theme.of(context).hintColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              textAlign: TextAlign.end,
              data,
              style: notoSansRegular.copyWith(
                fontSize: Dimensions.fontSize14,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

