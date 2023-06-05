import 'package:flutter/material.dart';
import 'package:online_pizza/constant/sizedbox.dart';
import 'package:online_pizza/constant/strings.dart';

import '../../../constant/colors.dart';
import '../../../constant/styles.dart';
import '../../../data/entities/delivery_address.dart';

class AddressListTile extends StatelessWidget {
  const AddressListTile({Key? key, required this.address, required this.flag})
      : super(key: key);

  final DeliveryAddress address;
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
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor: MyColors.uiBlock,
                    radius: 24,
                    child: Icon(
                      Icons.location_pin,
                      color: MyColors.primaryColor,
                      size: 24,
                    ),
                  ),
                  title: Text(
                    address.address_nick,
                    style: Styles.H3Regular,
                  ),
                  subtitle: Text(
                    address.address.substring(0, address.address.length) +
                        ' ....',
                    style: Styles.body14px,
                  ),
                  // trailing: Icon(
                  //   Icons.delete,
                  //   color: MyColors.primaryColor,
                  //   size: 24,
                  // ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onTap() {}
}
