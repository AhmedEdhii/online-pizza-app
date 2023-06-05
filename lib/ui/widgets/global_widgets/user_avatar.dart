import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_pizza/constant/app_icons.dart';

import '../../../constant/colors.dart';



class UserAvatar extends StatelessWidget {
  const UserAvatar({
    this.radius = 24.0,
    this.backgroundColor = MyColors.primaryColor,
    this.iconColor = MyColors.white,
    Key? key,
  }) : super(key: key);

  final double radius;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return CircleAvatar(
      //backgroundColor: MyColors.uiBlock,
      // backgroundImage: user.photoURL != null ? NetworkImage(user.photoURL!) : (),
      backgroundImage: NetworkImage(user.photoURL!),
      backgroundColor: backgroundColor,
      // child: Icon(
      //   AppIcons.user,
      //   color: iconColor,
      //   size: radius,
      // ),
      radius: radius,
    );
  }
}
