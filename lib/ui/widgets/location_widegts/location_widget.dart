import 'package:flutter/material.dart';
import 'package:online_pizza/controllers/location_provider.dart';
import 'package:online_pizza/controllers/user_provider.dart';
import 'package:online_pizza/data/entities/delivery_address.dart';
import 'package:online_pizza/data/models/user_model.dart';
import 'package:online_pizza/ui/widgets/global_widgets/ui_button.dart'
    as ui_button;
import 'package:provider/provider.dart';
import '../../../constant/colors.dart';
import '../../../constant/sizedbox.dart';
import '../../../constant/strings.dart';
import '../form_widgets/form_widgets.dart';
import '../global_widgets/heading_bar.dart';

class locationWidget extends StatefulWidget {
  locationWidget({Key? key}) : super(key: key);

  @override
  State<locationWidget> createState() => _locationWidgetState();
}

class _locationWidgetState extends State<locationWidget> {
  final _formKey = GlobalKey<FormState>();

  String nick = "";

  String location_address = "";

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller =
        TextEditingController(text: context.watch<LocationProvider>().address);
    return Container(
      decoration: BoxDecoration(
        color: MyColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 5), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.44,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Heading_Bar(
              title: "Add New Address",
              backButton: true,
              notifications: false,
              userAvatar: false,
            ),
            SizedBoxes.verticalMedium,
            Form(
              key: _formKey,
              child: CustomTextField(
                labelText: 'Address Nick',
                hintText: 'e.g. Home',
                onChanged: (addressNick) => nick = addressNick,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*Required';
                  }
                  if (value.length > 10) {
                    return 'Address Nick should be within 10 characters';
                  }
                  return null;
                },
              ),
            ),
            SizedBoxes.verticalMedium,
            CustomTextField(
              controller: _controller,
              labelText: "Address",
              hintText: 'e.g Block 13, Gulshan Iqbal, Karachi',
              // initialValue: initial_address,
              maxLines: 3,
              onChanged: (locationAddress) {
                location_address = locationAddress;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '*Required';
                }
                return null;
              },
            ),
            SizedBoxes.verticalMedium,
            ui_button.FilledButton(
              buttonText: "Save & Continue",
              onPressed: () async {
                DeliveryAddress newAddress = DeliveryAddress(
                  address_nick: nick,
                  address: _controller.text,
                );
                if (_formKey.currentState!.validate()) {
                  bool exists = await context
                      .read<UserProvider>()
                      .AddressExists(newAddress);

                  exists
                      ? ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            margin: EdgeInsets.all(18.0),
                            content: Text(
                              'Address Nick or Address already exists!',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : {
                          context
                              .read<UserProvider>()
                              .updateDeliveryAddresses(newAddress),
                          context.read<UserProvider>().addNick(nick),
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              margin: EdgeInsets.all(18.0),
                              content: Text(
                                'Address Added',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Navigator.of(context).pop(),
                        };
                  await context.read<UserProvider>().clearFlag();
                }
              },
              buttonSize: Size(450, 60),
              textColor: MyColors.white,
              buttonColor: MyColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
