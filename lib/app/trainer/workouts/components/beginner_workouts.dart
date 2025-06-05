import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myegym/app/trainer/workouts/components/workout_slider_component.dart';
import 'package:myegym/app/widgets/custom_network_image.dart';
import 'package:myegym/controllers/workout_controller.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';

import '../../../../utils/theme/light_theme.dart';

class BeginnerWorkouts extends StatelessWidget {
  final List<dynamic> workouts;
  final double? width;
  final String title;
  const BeginnerWorkouts({
    super.key,
    required this.workouts,
    this.width, required this.title,
  });

  @override
  Widget build(BuildContext context) {

    return workouts.isEmpty
        ? Text(
            textAlign: TextAlign.center,
            "No Workout Found",
            style: notoSansRegular.copyWith(color: Colors.white),
          )
        : SizedBox(height: Get.size.height,
          child: ListView.separated(
              itemCount: workouts.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: 300),
              // physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final workout = workouts[index];
                final workoutHistory = workout['workout_history'];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        CustomNetworkImageWidget(
                            height: 150, image: workout["image_url"] ?? ''),
                        // Positioned(
                        //   bottom: Dimensions.paddingSizeDefault,
                        //   right: Dimensions.paddingSizeDefault,
                        //   child: ElevatedButton(style: ButtonStyle(
                        //     backgroundColor: MaterialStateProperty.all<Color>(primaryRedColor), // your desired color
                        //   ),
                        //       onPressed: () {}, child: Text("Edit")),
                        // )
                      ],
                    ),
                    sizedBox10(),
                    Text(" ${workout["goals"]['name']}",
                      style: notoSansSemiBold.copyWith(
                        fontSize: Dimensions.fontSizeDefault,
                        color: Colors.white,
                      ),
                    ),

                    Row(
                      children: [
                        Container(height: 16,width: 2,color: Theme.of(context).primaryColor,),
                        sizedBoxW10(),
                        Text(
                          "${workoutHistory
                        .map((e) => (e["subactivity_data"] as List).length)
                        .fold(0, (a, b) => a + b)
                        .toString(
                                        )
                                      } Workouts for ${title}",
                          style: notoSansSemiBold.copyWith(
                            fontSize: Dimensions.fontSizeDefault,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),


                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) => sizedBox10(),
            ),
        );
  }
}
