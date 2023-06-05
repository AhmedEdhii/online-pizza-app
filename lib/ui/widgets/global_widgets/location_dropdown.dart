import 'package:flutter/material.dart';
import 'package:online_pizza/constant/styles.dart';
import 'package:provider/provider.dart';

import '../../../controllers/user_provider.dart';
import '../../screens/location/location_screen.dart';
import '../form_widgets/form_widgets.dart';

class LocationDropDown extends StatefulWidget {
  LocationDropDown({this.height, super.key});

  double? height;

  @override
  State<LocationDropDown> createState() => _LocationDropDownState();
}

class _LocationDropDownState extends State<LocationDropDown> {
  String dropdownValue = '';
  String option = '';
  @override
  void initState() {
    super.initState();
    context.read<UserProvider>().getCurrentUser();
    context.read<UserProvider>().fetchNick();
  }

  @override
  Widget build(BuildContext context) {
    var addressList =
        context.watch<UserProvider>().current_user.delivery_addresses;
    if (addressList.isEmpty) {
      context.read<UserProvider>().addNick('Add Address');
      dropdownValue = 'Add Address';
      setState(() {});
    } else {
      addressList
          .forEach((e) => context.read<UserProvider>().addNick(e.address_nick));
      dropdownValue = '';
      dropdownValue =
          Provider.of<UserProvider>(context, listen: false).selectedAddressNick;
      setState(() {});
      if (dropdownValue == '') {
        print(dropdownValue);
        dropdownValue =
            Provider.of<UserProvider>(context, listen: false).nicks.first;
      }
      setState(() {});
      context.read<UserProvider>().setAddressNick(dropdownValue);
    }
    List<String> nicks = context.watch<UserProvider>().nicks;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: widget.height == true ? widget.height : 40,
          child: CustomDropDown(
            hintText: dropdownValue,
            hintStyle: Styles.trailingText,
            contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            options: nicks
                .map((String value) =>
                    CustomDropDownOption(value: value, displayOption: value))
                .toList(),
            onChanged: (nick) {
              if (nick == "Add Address") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LocationScreen(),
                  ),
                );
              } else {
                context.read<UserProvider>().setAddressNick(nick!);
              }
            },
          ),
        ),
      ],
    );
  }
}
