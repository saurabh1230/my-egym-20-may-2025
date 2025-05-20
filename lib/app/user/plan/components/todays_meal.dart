import 'package:flutter/material.dart';
import 'package:myegym/app/widgets/custom_app.dart';
import 'package:myegym/app/widgets/custom_containers.dart';
import 'package:myegym/app/widgets/meal_card_component.dart';
import 'package:myegym/utils/dimensions.dart';
import 'package:myegym/utils/sizeboxes.dart';
import 'package:myegym/utils/styles.dart';

class TodaysMeal extends StatelessWidget {
  const TodaysMeal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Today’s Meal",
        isBackButtonExist: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (_, i) {
                  return Column(
                    children: [
                      MealCardComponent(
                          image: "assets/icons/icmeal.png",
                          title: "Breakfast",
                          icon1: Icons.access_time,
                          icon2: Icons.whatshot,
                          subTitle: "40 gm",
                          contentTitle: "Quinoa with carrot",
                          iconTitle1: "30 mins",
                          iconTitle2: "507 Kcal"),
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    sizedBoxDefault(),
              ),
              sizedBoxDefault(),
              Row(
                children: [
                  Expanded(
                    child: CustomDecoratedContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Foods To Avoid",
                            style:
                                notoSansRegular.copyWith(color: Colors.white),
                          ),
                          Wrap(
                            direction: Axis
                                .horizontal, // The direction to wrap elements, can also be Axis.vertical
                            alignment: WrapAlignment
                                .start, // How the runs themselves should be placed in the wrap
                            spacing:
                                8.0, // The space between children in the main axis (horizontally in this case)

                            children: <Widget>[
                              Chip(
                                labelStyle: notoSansRegular.copyWith(
                                    color: Colors.white,
                                    fontSize: Dimensions.fontSize12),
                                backgroundColor: Theme.of(context).primaryColor,
                                label: Text('Fast Food'),
                              ),
                              Chip(
                                labelStyle: notoSansRegular.copyWith(
                                    color: Colors.white,
                                    fontSize: Dimensions.fontSize12),
                                backgroundColor: Theme.of(context).primaryColor,
                                label: Text('Green Veggies'),
                              ),
                              Chip(
                                labelStyle: notoSansRegular.copyWith(
                                    color: Colors.white,
                                    fontSize: Dimensions.fontSize12),
                                backgroundColor: Theme.of(context).primaryColor,
                                label: Text('Meats'),
                              ),
                              Chip(
                                labelStyle: notoSansRegular.copyWith(
                                    color: Colors.white,
                                    fontSize: Dimensions.fontSize12),
                                backgroundColor: Theme.of(context).primaryColor,
                                label: Text('Boiled Food'),
                              ),
                              // ... more widgets
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
