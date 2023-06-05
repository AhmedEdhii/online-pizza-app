import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:online_pizza/constant/sizedbox.dart';
import 'package:online_pizza/controllers/user_provider.dart';
import 'package:online_pizza/ui/widgets/form_widgets/form_widgets.dart';
import 'package:online_pizza/ui/widgets/global_widgets/heading_bar.dart';
import 'package:online_pizza/ui/widgets/global_widgets/ui_button.dart';
import 'package:provider/provider.dart';

import '../../../../constant/colors.dart';
import '../../../../data/models/user_model.dart';
import '../../../widgets/global_widgets/user_avatar.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  void initState() {
    // TODO: implement initState
    context.read<UserProvider>().getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final current_user = context.watch<UserProvider>().current_user;
    String changedUserName = "";
    String changedCurrentUserEmail = "";

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80), // Set this height
        child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Top Bar Homepage
                Heading_Bar(
                    backButton: true,
                    title: "Personal Details",
                    notifications: false,
                    userAvatar: false),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBoxes.verticalLarge,
                UserAvatar(
                    radius: 70,
                    backgroundColor: MyColors.uiBlock,
                    iconColor: MyColors.lightGray),
                SizedBoxes.verticalExtraGargangua,
                CustomTextField(
                  labelText: 'Full Name',
                  // hintText: 'e.g. Pizza Hut',

                  initialValue: current_user.name,
                  onChanged: (currentUser) => changedUserName = currentUser,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required';
                    }
                    return null;
                  },
                ),
                SizedBoxes.verticalBig,
                CustomTextField(
                  labelText: "Email",
                  //hintText: 'e.g. Pizza Hut',
                  readOnly: true,
                  initialValue: current_user.email,
                  // onChanged: (userEmail) =>
                  // changedCurrentUserEmail = userEmail,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return '*Required';
                  //   }
                  //   return null;
                  // },
                ),
                SizedBoxes.verticalBig,
              ],
            ),
            FilledButton(
              buttonText: "Edit Changes",
              onPressed: () async {
                //print(current_user.name);
                User updatedUser = current_user;
                //print(changedUserName);
                if (changedUserName != "") updatedUser.name = changedUserName;
                //print(updatedUser.name);
                // if (changedCurrentUserEmail != "")
                //   updatedUser.email = changedCurrentUserEmail;
                await context
                    .read<UserProvider>()
                    .updateCurrentUser(updatedUser.userid, updatedUser);
                final provider =
                    Provider.of<UserProvider>(context, listen: false);
                bool isCurrentUserUpdated = await provider.isCurrentUserUpdated;
                if (isCurrentUserUpdated) {
                  Navigator.of(context)..pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      margin: EdgeInsets.all(18.0),
                      content: Text(
                        'Details Updated!',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
