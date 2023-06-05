import 'package:flutter/material.dart';
import 'package:online_pizza/constant/sizedbox.dart';
import 'package:online_pizza/constant/strings.dart';

import '../../../constant/colors.dart';
import '../../../constant/styles.dart';

class ProfileNavigations extends StatelessWidget {
  const ProfileNavigations(
      {Key? key,
      required this.onTap,
      required this.leadingIcon,
      required this.title,
      required this.trailingIcon,
      required this.flag})
      : super(key: key);

  final VoidCallback onTap;
  final IconData leadingIcon;
  final String title;
  final IconData trailingIcon;
  final bool flag;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                border: flag
                    ? Border(
                        top: BorderSide(width: 1.0, color: MyColors.uiBlock),
                        bottom: BorderSide(width: 1.0, color: MyColors.uiBlock),
                      )
                    : Border(
                        bottom: BorderSide(width: 1.0, color: MyColors.uiBlock),
                      ),
                // color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ListTile(
                  // shape: RoundedRectangleBorder(
                  //   side: BorderSide(color: MyColors.lightGray, width: 1),
                  // ),
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.transparent,
                    child: IconButton(
                        icon: Icon(leadingIcon),
                        iconSize: 28,
                        color: MyColors.primaryColor,
                        onPressed: (() {})),
                  ),

                  title: Text(
                    title,
                    style: Styles.H3Regular,
                  ),
                  trailing: Icon(
                    trailingIcon,
                    color: MyColors.primaryColor,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
