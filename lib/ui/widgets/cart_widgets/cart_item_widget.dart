import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:online_pizza/constant/colors.dart';
import 'package:online_pizza/constant/sizedbox.dart';
import 'package:online_pizza/constant/strings.dart';
import 'package:online_pizza/constant/styles.dart';
import 'package:online_pizza/data/models/cart_item.dart';
import 'package:online_pizza/ui/widgets/cart_widgets/qty_widget.dart';
import 'package:provider/provider.dart';

import '../../../controllers/cart_provider.dart';

class CartItemWidget extends StatefulWidget {
  CartItemWidget({required this.cartItem, required this.index, super.key});

  CartItem cartItem;
  int index;
  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // QtyWidget(),
              SizedBoxes.horizontalMedium,
              Text(
                widget.cartItem.quantity,
                style: Styles.H3Medium,
              ),
              SizedBoxes.horizontalExtraGargangua,
              Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(widget.cartItem.img_url!),
                        fit: BoxFit.cover)),
              ),
              SizedBoxes.horizontalMedium,
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.cartItem.name,
                    style: Styles.H3Regular,
                    textAlign: TextAlign.left,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.cartItem.size!,
                        style: Styles.body12px,
                      ),
                      SizedBoxes.horizontalTiny,
                      Text(
                        "${MyStrings.unit}" + widget.cartItem.unit_price,
                        style: Styles.body12pxBlackbold,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          InkWell(
            onTap: () {
              print(widget.index);
              context.read<CartProvider>().deleteFromCart(widget.index);
            },
            child: Icon(
              Icons.delete,
              color: MyColors.primaryColor,
              size: 24,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 3.0),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.end,
          //     children: [
          //       Text(
          //         widget.item.size!,
          //         style: Styles.body12px,
          //       ),
          //       Text(
          //         "${MyStrings.unit}" + widget.item.price,
          //         style: Styles.body12pxBlackbold,
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
