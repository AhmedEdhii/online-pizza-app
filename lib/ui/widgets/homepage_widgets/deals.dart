import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:online_pizza/constant/colors.dart';
import 'package:online_pizza/constant/sizedbox.dart';
import 'package:online_pizza/constant/strings.dart';
import 'package:online_pizza/constant/styles.dart';
import 'package:online_pizza/ui/widgets/global_widgets/ui_button.dart'
    as ui_button;

class Deals extends StatefulWidget {
  Deals({required this.deal, required this.ordernow, super.key});
  String deal;
  Function ordernow;

  @override
  State<Deals> createState() => _DealsState();
}

class _DealsState extends State<Deals> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBoxes.horizontalMedium,
        InkWell(
          onTap: () {
            widget.ordernow;
          },
          child: Container(
            height: 150,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: MyColors.uiBlock,
              image: DecorationImage(
                image: AssetImage(widget.deal),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
