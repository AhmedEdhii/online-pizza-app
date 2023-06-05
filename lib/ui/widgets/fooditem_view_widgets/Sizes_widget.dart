import 'package:flutter/material.dart';
import 'package:online_pizza/constant/colors.dart';
import 'package:online_pizza/constant/sizedbox.dart';
import 'package:online_pizza/constant/styles.dart';
import 'package:online_pizza/controllers/cart_provider.dart';
import 'package:provider/provider.dart';

class Sizes extends StatefulWidget {
  Sizes({
    required this.productSizes,
    required this.productPrices,
    super.key,
  });
  List<String> productSizes;
  List<String> productPrices;
  @override
  State<Sizes> createState() => _SizesState();
}

class _SizesState extends State<Sizes> {
  int value = 0;
  Widget SizeRadio(
    int ind,
    String size,
  ) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          side: BorderSide(
            width: 0,
            color: Colors.transparent,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor:
              (value == ind ? MyColors.primaryColor : MyColors.uiBlock),
          fixedSize: Size(100, 40)),
      onPressed: () {
        setState(
          () {
            value = ind;
            context.read<CartProvider>().setInitialQuantity();
            context
                .read<CartProvider>()
                .setCurrentProductPrice(widget.productPrices[value]);
            context
                .read<CartProvider>()
                .setSelectedSize(widget.productSizes[value]);
          },
        );
      },
      child: Text(size,
          style: (value == ind) ? Styles.buttonText : Styles.buttonTextDark),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        childAspectRatio: 2.5,
      ),
      padding: EdgeInsets.all(0),
      itemCount: widget.productSizes.length,
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (widget.productSizes[index] != '')
          return Center(
            child: SizeRadio(
              index,
              widget.productSizes[index].capitalize(),
            ),
          );
        return SizedBoxes.horizontalBig;
      },
    );
  }
}
