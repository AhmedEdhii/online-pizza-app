import 'package:flutter/material.dart';
import 'package:online_pizza/constant/colors.dart';

import '../../../constant/strings.dart';


class MenuItems extends StatefulWidget {
  MenuItems({Key? key, required this.tabID}) : super(key: key);

  String getTabName() {
    if (tabID == 1) {
      return MyStrings.menuPageTab1;
    }
    if (tabID == 2) {
      return MyStrings.menuPageTab2;
    }
    if (tabID == 3) {
      return MyStrings.menuPageTab3;
    }
    if (tabID == 4) {
      return "hello";
    }
    return '';
  }

  int tabID;
  @override
  State<MenuItems> createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.only(top: 16, bottom: 16),
        itemCount: Menu.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: index == Menu.length - 1
                  ? const Border(
                      bottom: BorderSide(
                          width: 1,
                          color: MyColors
                              .uiBlock)) // This will create no border for the first item
                  : const Border(),
            ),
            child: ListTile(
              leading: Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        image: NetworkImage(
                            "https://www.wholesomeyum.com/wp-content/uploads/2017/04/wholesomeyum-Fathead-Pizza-Crust-Recipe-Low-Carb-Keto-Pizza-4-Ingredients-17.jpg"),
                        fit: BoxFit.cover)),
              ),
              title: Text(Menu[index].name),
              trailing: const Icon(Icons.more_horiz),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            color: MyColors.uiBlock,
            thickness: 1,
          );
        });
  }
}

class MyMenu {
  final int ID;
  final int categoryID;
  final String name;

  MyMenu({required this.ID, required this.categoryID, required this.name});
}

List<MyMenu> Menu = [
  MyMenu(ID: 1, categoryID: 1, name: "Chicken Tikka"),
  MyMenu(ID: 2, categoryID: 2, name: "Pepsi"),
  MyMenu(ID: 3, categoryID: 3, name: "Chilli Ketchup"),
  MyMenu(ID: 4, categoryID: 1, name: "Chicken Tikka"),
  MyMenu(ID: 5, categoryID: 2, name: "Pepsi"),
  MyMenu(ID: 6, categoryID: 3, name: "Chilli Ketchup"),
  MyMenu(ID: 7, categoryID: 1, name: "Chicken Tikka"),
  MyMenu(ID: 8, categoryID: 2, name: "Pepsi"),
  MyMenu(ID: 9, categoryID: 3, name: "Chilli Ketchup"),
  MyMenu(ID: 10, categoryID: 1, name: "Chicken Tikka"),
  MyMenu(ID: 11, categoryID: 2, name: "Pepsi"),
  MyMenu(ID: 12, categoryID: 3, name: "Chilli Ketchup"),
];
