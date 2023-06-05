import 'package:flutter/material.dart';
import 'package:online_pizza/ui/screens/vendor/new_item/new_item.dart';
import 'package:online_pizza/ui/widgets/global_widgets/heading_bar.dart';
import 'package:online_pizza/ui/widgets/global_widgets/ui_button.dart'
    as button;
import 'package:online_pizza/ui/widgets/new_pizza_widgets/category_dropdown.dart';
import 'package:provider/provider.dart';

import '../../../../constant/sizedbox.dart';
import '../../../../constant/styles.dart';
import '../../../../controllers/new_item_provider.dart';

class SelectCategory extends StatefulWidget {
  const SelectCategory({Key? key}) : super(key: key);

  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  List<String> product_type_list = ["Pizza", "Sauce", "Drink"];
  bool isSelected = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80), // Set this height
          child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Top Bar Homepage
                    Heading_Bar(
                        title: "Select Category",
                        backButton: false,
                        notifications: false,
                        userAvatar: false),
                  ]),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.99,
                  child: CategoryDropdown(
                    list: product_type_list,
                  ),
                ),
                SizedBoxes.verticalLarge,
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBoxes.verticalExtraGargangua,
                    button.FilledButton(
                      isActive: isSelected =
                          context.watch<NewItemProvider>().getisSelected,
                      buttonText: "Next",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewItem(),
                          ),
                        );
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
