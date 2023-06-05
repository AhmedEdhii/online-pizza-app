import 'package:flutter/material.dart';
import 'package:online_pizza/constant/colors.dart';
import 'package:online_pizza/constant/sizedbox.dart';
import 'package:online_pizza/constant/strings.dart';
import 'package:online_pizza/constant/styles.dart';
import 'package:online_pizza/controllers/cart_provider.dart';
import 'package:online_pizza/controllers/topping_provider.dart';
import 'package:provider/provider.dart';

import '../../../data/models/topping_model.dart';

class Extras extends StatefulWidget {
  Extras({required this.topping, super.key});
  Topping topping;

  @override
  State<Extras> createState() => _ExtrasState();

  bool check = false;
}

class _ExtrasState extends State<Extras> {
  @override
  Widget build(BuildContext context) {
    String name = widget.topping.toppingName;
    String price = widget.topping.toppingPrice;
    return ListTile(
      tileColor: widget.check ? MyColors.uiBlock : Colors.white,
      leading: Text(
        name,
        style: Styles.H3,
      ),
      title: Text(
        MyStrings.unit + price,
        style: Styles.body12pxdark,
      ),
      trailing: widget.check
          ? const Icon(
              Icons.check,
              color: MyColors.primaryColor,
            )
          : SizedBoxes.horizontalTiny,
      onTap: () {
        setState(() {
          widget.check = !widget.check;
          //print(widget.check);
          if (widget.check) {
            context.read<CartProvider>().increaseCurrentCartPrice(price);
            context
                .read<ToppingProvider>()
                .addTopping(widget.topping);
          } else {
            context.read<CartProvider>().decreaseCurrentCartPrice(price);
            context
                .read<ToppingProvider>()
                .removeTopping(widget.topping);
          }
        });
      },
    );
  }
}
