import 'package:flutter/material.dart';
import 'package:online_pizza/constant/colors.dart';
import 'package:online_pizza/controllers/new_item_provider.dart';
import 'package:provider/provider.dart';

class FeaturedSwitch extends StatefulWidget {
  const FeaturedSwitch({super.key});

  @override
  State<FeaturedSwitch> createState() => _FeaturedSwitchState();
}

// class _FeaturedSwitchState extends State<FeaturedSwitch> {
//   @override
//   Widget build(BuildContext context) {
//     return Transform.scale(
//       scale: 1.3,
//       child: Switch(
//         onChanged: ((value) =>
//             context.read<NewItemProvider>().markasFeatured()),
//         value: context.watch<NewItemProvider>().getisFeatured,
//         activeColor: MyColors.primaryColor,
//         activeTrackColor: MyColors.uiBlock,
//         inactiveThumbColor: MyColors.lightGray,
//         inactiveTrackColor: MyColors.uiBlock,
//       ),
//     );
//   }

class _FeaturedSwitchState extends State<FeaturedSwitch> {
  bool isSwitched = false;
  var textValue = 'Switch is OFF';

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'Switch Button is ON';
      });

      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'Switch Button is OFF';
      });
      print('Switch Button is OFF');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.3,
      child: Switch(
        onChanged: (value) {
          setState(
            () {
              isSwitched = value;
              context.read<NewItemProvider>().markasFeatured();
            },
          );
        },
        value: isSwitched,
        activeColor: MyColors.primaryColor,
        activeTrackColor: MyColors.uiBlock,
        inactiveThumbColor: MyColors.lightGray,
        inactiveTrackColor: MyColors.uiBlock,
      ),
    );
  }
}
