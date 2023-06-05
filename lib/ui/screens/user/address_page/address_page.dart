import 'package:flutter/material.dart';
import 'package:online_pizza/constant/app_icons.dart';
import 'package:online_pizza/data/entities/delivery_address.dart';
import 'package:online_pizza/ui/screens/location/location_screen.dart';
import 'package:online_pizza/ui/screens/notification/Notifications_screen.dart';
import 'package:online_pizza/ui/widgets/address_list/address_list_widget.dart';
import 'package:provider/provider.dart';
import '../../../../constant/sizedbox.dart';
import '../../../../controllers/user_provider.dart';
import '../../../widgets/global_widgets/heading_bar.dart';
import '../../../widgets/global_widgets/ui_button.dart' as ui_button;

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<UserProvider>().getCurrentUser();
    context.read<UserProvider>().fetchUserAddresses(
        Provider.of<UserProvider>(context, listen: false).current_user.userid);
  }

  @override
  Widget build(BuildContext context) {
    List<DeliveryAddress> myAddresses =
        context.watch<UserProvider>().userAddressList;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100), // Set this height
        child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 64, 16, 16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //Top Bar Homepage
                  Heading_Bar(
                    title: 'Your Addresses',
                    backButton: true,
                    notifications: false,
                    userAvatar: false,
                  ),
                ]),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: myAddresses.length,
                itemBuilder: (BuildContext context, int index) =>
                    AddressListTile(
                  address: myAddresses[index],
                  flag: true,
                ),
              ),
              SizedBoxes.verticalGargangua,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ui_button.FilledButton(
                  buttonText: 'ADD A NEW ADDRESS',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocationScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
