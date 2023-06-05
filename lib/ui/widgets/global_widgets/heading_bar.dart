import 'package:flutter/material.dart';
import 'package:online_pizza/constant/sizedbox.dart';

import 'package:online_pizza/constant/styles.dart';
import 'package:online_pizza/ui/screens/reviews.dart';
import 'package:online_pizza/ui/widgets/global_widgets/user_avatar.dart';

import 'custom_back_button.dart';
import 'notification_iconbutton.dart';

class Heading_Bar extends StatelessWidget {
  Heading_Bar({
    required this.title,
    required bool this.notifications,
    required bool this.userAvatar,
    required bool this.backButton,
    this.restaurant_id,
    super.key,
    this.onPressed,
  });
  String title;
  bool notifications;
  bool backButton;
  String? restaurant_id;
  bool userAvatar;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    if (backButton == false && notifications == false && userAvatar == false)
      return Text(
        title,
        style: Styles.H2,
      );
    else
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (backButton == true) CustomBackButton(onPressed: onPressed),
          Text(
            title,
            style: Styles.H2,
          ),
          if (notifications == true)
            NotificationButton(onPressed: () {
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Reviews(restaurantID: restaurant_id!),
                  ),
                );
              }
            })
          else if (userAvatar == true)
            UserAvatar()
          else
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 24,
            ),
        ],
      );
  }
}
