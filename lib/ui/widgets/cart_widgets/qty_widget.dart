import 'package:flutter/material.dart';
import 'package:online_pizza/constant/styles.dart';
import 'package:online_pizza/controllers/cart_provider.dart';
import 'package:online_pizza/ui/widgets/cart_widgets/qty_button.dart';
import 'package:provider/provider.dart';

class QtyWidget extends StatefulWidget {
  const QtyWidget({super.key});

  @override
  State<QtyWidget> createState() => _QtyWidgetState();
}

class _QtyWidgetState extends State<QtyWidget> {
  @override
  Widget build(BuildContext context) {
    //final value = context.watch<Counter>().count.toString();
    return Container(
      width: MediaQuery.of(context).size.width * 0.28,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          QtyButton(buttonType: Icons.remove),
          Text(
            context.watch<CartProvider>().count.toString(),
            style: Styles.H3Medium,
          ),
          QtyButton(buttonType: Icons.add),
        ],
      ),
    );
  }
}
