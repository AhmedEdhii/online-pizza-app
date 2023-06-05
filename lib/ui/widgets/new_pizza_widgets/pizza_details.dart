import 'package:flutter/material.dart';
import 'package:online_pizza/constant/strings.dart';

import '../../../constant/colors.dart';
import '../../../constant/sizedbox.dart';
import '../../../constant/styles.dart';
import 'package:online_pizza/ui/widgets/global_widgets/ui_button.dart'
    as ui_button;

class PizzaDetails extends StatefulWidget {
  const PizzaDetails({Key? key}) : super(key: key);

  @override
  State<PizzaDetails> createState() => _PizzaDetailsState();
}

class _PizzaDetailsState extends State<PizzaDetails> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // Text(
          //   MyStrings.addItemPageHeading,
          //   style: Styles.vendorHeading,
          // ),
          SizedBoxes.verticalGargangua,
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name',
              hintText: 'Chicken Fajita',
            ),
            controller: name,
          ),
          SizedBoxes.verticalBig,
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Description',
              hintText: 'Buffalo Chicken',
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 60, horizontal: 10),
            ),
            controller: description,
          ),
          SizedBoxes.verticalBig,
          Container(
            height: 135,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150,
                  height: 130,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          MyStrings.addItemPageField3,
                          style: Styles.H3Regular,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: MyColors.uiBlock,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 230,
          ),
          ui_button.FilledButton(
            buttonText: MyStrings.addItemPageButton.toUpperCase(),
            onPressed: () {},
            buttonSize: const Size(360, 56),
          ),
        ],
      ),
    );
  }
}
