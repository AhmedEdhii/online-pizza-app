import 'package:flutter/material.dart';
import 'package:online_pizza/constant/colors.dart';
import 'package:online_pizza/controllers/cart_provider.dart';
import 'package:provider/provider.dart';

class QtyButton extends StatefulWidget {
  QtyButton({required this.buttonType, super.key});
  IconData buttonType;

  @override
  State<QtyButton> createState() => _QtyButtonState();
}

class _QtyButtonState extends State<QtyButton> {
  @override
  Widget build(BuildContext context) {
    return widget.buttonType == Icons.add
        ? TextButton(
            onPressed: () => {
                  context.read<CartProvider>().increment(),
                  context.read<CartProvider>().increaseCurrentPriceByQty(),
                },
            child: Icon(
              widget.buttonType,
              color: MyColors.buttonTextColor,
              size: 18,
            ),
            style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                minimumSize: Size(16, 16),
                backgroundColor: MyColors.primaryColor))
        : TextButton(
            onPressed: () => {
                  context.read<CartProvider>().decrement(),
                  context.read<CartProvider>().decreaseCurrentPriceByQty(),
                },
            child: Icon(
              widget.buttonType,
              color: MyColors.darkGray,
              size: 18,
            ),
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              minimumSize: Size(16, 16),
              backgroundColor: MyColors.uiBlock,
            ));
  }
}
