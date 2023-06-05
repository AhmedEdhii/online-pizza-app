import 'package:flutter/material.dart';

import '../../../constant/app_icons.dart';
import '../../../constant/colors.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 24,
      backgroundColor: MyColors.primaryColor,
      child: IconButton(
        icon: Icon(AppIcons.star_1),
        iconSize: 20,
        color: MyColors.white,
        onPressed: onPressed
      ),
    );
  }
}
