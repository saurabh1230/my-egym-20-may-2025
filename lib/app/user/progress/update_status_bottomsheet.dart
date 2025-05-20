import 'package:flutter/material.dart';
import 'package:myegym/utils/dimensions.dart';

class UpdateStatusBottomsheet extends StatelessWidget {
  const UpdateStatusBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius10),
              topRight: Radius.circular(Dimensions.radius10),
            )),
        child: Column(),
      ),
    );
  }
}
