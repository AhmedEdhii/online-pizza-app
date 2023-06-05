import 'package:flutter/material.dart';
import 'package:online_pizza/constant/assets.dart';
import 'package:online_pizza/constant/sizedbox.dart';
import 'package:online_pizza/constant/strings.dart';
import 'package:online_pizza/constant/styles.dart';

class Greetings extends StatelessWidget {
  Greetings({required this.name, super.key});
  String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBoxes.horizontalMedium,
        Text(
          MyStrings.homePageHello + name + " ",
          style: Styles.H3Medium,
        ),
        SizedBox(
          height: 24,
          width: 24,
          child: Image.asset(ImageAssets.wave),
        ),
      ],
    );
  }
}
