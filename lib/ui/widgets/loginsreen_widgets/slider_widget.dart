import 'package:flutter/material.dart';
import 'package:online_pizza/constant/assets.dart';
import 'package:online_pizza/constant/sizedbox.dart';
import 'package:online_pizza/constant/strings.dart';
import 'package:online_pizza/constant/styles.dart';

class PageSlider extends StatelessWidget {
  const PageSlider(
      {this.image = ImageAssets.splashLogo,
      required this.title,
      required this.description,
      super.key});

  final String image;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: 355,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(image), fit: BoxFit.fitHeight),
          ),
        ),
        SizedBoxes.verticalBig,
        Text(
          title,
          style: Styles.H1,
        ),
        SizedBoxes.verticalTiny,
        Text(
          description,
          style: Styles.body14px,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
