import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:online_pizza/constant/colors.dart';
import 'package:online_pizza/constant/strings.dart';
import 'package:online_pizza/ui/screens/user/all_restaurants/all_restaurants.dart';
import 'package:online_pizza/ui/screens/user/search_results/search_results.dart';

import '../../../constant/sizedbox.dart';
import '../../../constant/styles.dart';
import '../form_widgets/form_widgets.dart';

class SearchBar extends StatefulWidget {
  SearchBar({super.key, required this.navigate,  required this.searchStringChange});

  final bool navigate;
  Function(String) searchStringChange;
  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {


  @override
  Widget build(BuildContext context) {
    return widget.navigate
        ? CustomTextField(
            readOnly: true,
            // hintText: 'Search for Restaurants',
            initialValue: 'Search for Restaurants',
            contentStyle: Styles.body14px,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: MyColors.darkGray,
              ),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchResults(),
              ),
            ),

            prefixIcon: Icon(
              Icons.search,
              color: MyColors.darkGray,
              size: 24,
            ),
          )
        : CustomTextField(
            hintText: 'Search for Restaurants',
            prefixIcon: Icon(
              Icons.search,
              color: MyColors.darkGray,
              size: 24,
            ),
      onChanged: (value){
              widget.searchStringChange(value);
      },
          );
  }
}
