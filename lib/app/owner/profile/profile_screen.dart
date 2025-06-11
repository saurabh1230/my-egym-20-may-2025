import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myegym/app/owner/drawer/owner_drawer.dart';
import 'package:myegym/app/owner/profile/edit_profile.dart';
import 'package:myegym/app/widgets/custom_app.dart';
import 'package:myegym/app/widgets/custom_button.dart';
import 'package:myegym/app/widgets/custom_containers.dart';
import 'package:myegym/app/widgets/custom_network_image.dart';
import 'package:myegym/controllers/owner_controller.dart';
import 'package:myegym/data/repo/owner_repo.dart';
import 'package:myegym/utils/date_converter.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';
import 'package:get/get.dart';

class OwnerProfile extends StatelessWidget {
  OwnerProfile({super.key}) {
    Get.lazyPut(() => OwnerRepo(apiClient: Get.find()));
    Get.put(OwnerController(ownerRepo: Get.find()));
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

        final details = data['data']['details'];
        final user = details['user'] ?? {};
        final address = details['address'] ?? 'N/A';
        final joiningDate = details['created_at'] ?? 'N/A';
        final profileImage = data['data']['profile_image_url']?.toString() ?? '';
        final ownerName = user['name'] ?? '';
        final phoneNumber = user['phone_number'] ?? '';
        final email = user['email'] ?? '';
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
                  // row(context, title: 'Years of Experience:', data: '1 Year'),
                  // row(context, title: 'Salary:', data: '₹ 20000'),
                  row(context, title: 'Joining Date:', data: DateFormatterOnlyDate.formatToIndianDate(joiningDate)),

                  row(
                    context,
                    title: 'Address:',
                    data: address,
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

