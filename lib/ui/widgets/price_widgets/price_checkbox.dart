import 'package:flutter/material.dart';
import 'package:online_pizza/constant/colors.dart';
import 'package:online_pizza/constant/styles.dart';
import 'package:online_pizza/ui/widgets/form_widgets/form_widgets.dart';
import 'package:provider/provider.dart';

import '../../../controllers/new_item_provider.dart';

class PriceCheckbox extends StatefulWidget {
  final String size;

  const PriceCheckbox({super.key, required this.size});

  @override
  State<PriceCheckbox> createState() => _PriceCheckboxState();
}

class _PriceCheckboxState extends State<PriceCheckbox> {
  bool _value = false;
  String itemPrice = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CheckboxListTile(
            contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            title: Text(
              widget.size,
              style: Styles.H3Regular,
            ),
            // subtitle: const Text('A computer science portal for geeks.'),
            secondary: Container(
              width: MediaQuery.of(context).size.width * 0.50,
              child: CustomTextField(
                enabled: _value,
                hintText: 'e.g 1000',
                labelText: 'Price',
                keyboardType: TextInputType.number,
                   validator: (value) {
                    if (_value==true){
                                    if (value == null || value.isEmpty) {
                                      return '*Required';
                                    } else if (!isValidInt(value)) {
                                      return '*Please Enter an Integer';
                                    }
                                    return null;}
                    return null;
                                  },
                onChanged: (price) => {
                  itemPrice = price,
                  if (itemPrice.isNotEmpty)
                    {
                      context
                          .read<NewItemProvider>()
                          .addPrice(widget.size.toLowerCase(), itemPrice),
                    }
                  else
                    {
                      context
                          .read<NewItemProvider>()
                          .removePrice(widget.size.toLowerCase(), itemPrice),
                    }
                },
              ),
            ),
            autofocus: false,
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: MyColors.primaryColor,
            checkColor: Colors.white,
            selected: _value,
            value: _value,
            onChanged: (value) {
              setState(
                () {
                  _value = value!;

                  if (value == true) {
                    context
                        .read<NewItemProvider>()
                        .addSize(widget.size.toLowerCase());
                  } else {
                    context
                        .read<NewItemProvider>()
                        .removeSize(widget.size.toLowerCase());
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
  bool isValidInt(String input) {
    final exp = RegExp('[0-9]+');
    return exp.hasMatch(input);
  }

