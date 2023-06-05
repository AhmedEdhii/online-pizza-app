import 'package:flutter/material.dart';
import 'package:online_pizza/constant/colors.dart';
import 'package:online_pizza/constant/sizedbox.dart';
import 'package:online_pizza/constant/strings.dart';
import 'package:online_pizza/constant/styles.dart';
import 'package:online_pizza/ui/widgets/global_widgets/user_avatar.dart';

import 'package:online_pizza/ui/widgets/global_widgets/location_dropdown.dart';

class Topbar extends StatefulWidget {
  Topbar({required this.avatar, super.key});
  bool avatar;

  @override
  State<Topbar> createState() => _TopbarState();
}

class _TopbarState extends State<Topbar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundColor: MyColors.uiBlock,
              radius: 24,
              child: Icon(
                Icons.location_pin,
                color: MyColors.primaryColor,
                size: 24,
              ),
            ),
            SizedBoxes.horizontalMedium,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  MyStrings.addressDetailsHeading,
                  style: Styles.SH1Primary,
                ),
                SizedBox(
                  width: 150,
                  child: LocationDropDown(),
                ),
              ],
            ),
          ],
        ),
        UserAvatar(),
      ],
    );
  }
}
