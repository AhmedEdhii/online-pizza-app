import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:online_pizza/constant/app_icons.dart';
import 'package:online_pizza/constant/colors.dart';
import 'package:online_pizza/constant/sizedbox.dart';
import 'package:online_pizza/constant/styles.dart';

class Ratings extends StatelessWidget {
  Ratings(
      {required this.rating,
      required this.delivery_charge,
      required this.delivery_time,
      super.key});
  String rating;
  String delivery_charge;
  String delivery_time;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            AppIcons.star_1,
            size: 20,
            color: MyColors.primaryColor,
          ),
          SizedBoxes.horizontalMicro,
          SizedBoxes.horizontalMicro,
          Text(
            rating,
            style: Styles.body14px,
          ),
          SizedBoxes.horizontalMedium,
          const Icon(
            AppIcons.delivery,
            size: 18,
            color: MyColors.primaryColor,
          ),
          SizedBoxes.horizontalLarge,
          Text(
            'Rs. ' + delivery_charge,
            style: Styles.body14px,
          ),
          SizedBoxes.horizontalMedium,
          const Icon(
            AppIcons.clock,
            size: 20,
            color: MyColors.primaryColor,
          ),
          SizedBoxes.horizontalMicro,
          SizedBoxes.horizontalMicro,
          Text(
            delivery_time + ' min',
            style: Styles.body14px,
          ),
        ],
      ),
    );
  }
}
