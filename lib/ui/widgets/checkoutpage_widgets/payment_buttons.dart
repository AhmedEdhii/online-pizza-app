import 'package:flutter/material.dart';
import 'package:online_pizza/constant/colors.dart';
import 'package:online_pizza/constant/sizedbox.dart';
import 'package:provider/provider.dart';

import '../../../controllers/cart_provider.dart';

class PaymentOptions extends StatefulWidget {
  PaymentOptions({super.key});

  @override
  State<PaymentOptions> createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  int value = 0;
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CartProvider>().initializePaymentMethod();
  }

  Widget CustomerRadioButton(String text, int ind) {
    final provider = Provider.of<CartProvider>(context, listen: false);

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          side: BorderSide(
              color: (value == ind ? MyColors.primaryColor : MyColors.uiBlock)),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: (value == ind ? Colors.white : MyColors.uiBlock),
          fixedSize: Size.square(70)),
      onPressed: () {
        setState(() {
          value = ind;
          print(value);
          if (value == 1) {
            provider.setPaymentMethod("Cash");
          }
          if (value == 2) {
            provider.setPaymentMethod("Card");
          }
          print(provider.paymentMethod);
          print(ind);
        });
      },
      child: Text(
        text,
        style: TextStyle(
          color: (value == ind) ? MyColors.primaryColor : MyColors.darkGray,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomerRadioButton("Cash", 1),
        SizedBoxes.horizontalMedium,
        CustomerRadioButton("Card", 2)
      ],
    );
  }
}
