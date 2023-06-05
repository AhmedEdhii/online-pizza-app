import 'package:flutter/material.dart';
import 'package:online_pizza/constant/strings.dart';
import 'package:online_pizza/ui/widgets/global_widgets/user_avatar.dart';

import '../../../constant/sizedbox.dart';
import '../../../constant/styles.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const UserAvatar(),
        // CircleAvatar(
        //   backgroundColor: MyColors.darkGray,
        //   radius: 22.5,
        // ),
        SizedBoxes.horizontalMedium,
        Text(
          MyStrings.vendorPageHeading,
          style: Styles.vendorHeading,
        )
      ],
    ));
  }
}
