import 'package:flutter/material.dart';
import 'package:online_pizza/constant/styles.dart';
import 'package:online_pizza/controllers/new_item_provider.dart';
import 'package:provider/provider.dart';

import '../form_widgets/form_widgets.dart';

// ignore: must_be_immutable
class CategoryDropdown extends StatefulWidget {
  CategoryDropdown({required this.list, super.key});
  List<String> list;

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  String dropdownValue = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    dropdownValue = widget.list.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomDropDown(
            hintText: context.watch<NewItemProvider>().getisSelected
                ? context.watch<NewItemProvider>().selectedCategory
                : 'Select Category',
            hintStyle: Styles.trailingText,
            contentPadding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
            options: widget.list
                .map((String value) =>
                    CustomDropDownOption(value: value, displayOption: value))
                .toList(),
            onChanged: (value) {
              context.read<NewItemProvider>().selectItem(value.toString());
            }),
      ],
    );
  }
}
