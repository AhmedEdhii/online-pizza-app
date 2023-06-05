import 'package:flutter/material.dart';
import 'package:online_pizza/constant/app_icons.dart';
import 'package:online_pizza/ui/screens/notification/Notifications_screen.dart';
import 'package:online_pizza/ui/screens/user/address_page/address_page.dart';
import 'package:online_pizza/ui/screens/user/personal%20details/personal_details.dart';
import 'package:online_pizza/ui/widgets/global_widgets/user_avatar.dart';
import 'package:provider/provider.dart';
import '../../../../constant/colors.dart';
import '../../../../constant/sizedbox.dart';
import '../../../../constant/strings.dart';
import '../../../../constant/styles.dart';
import '../../../../controllers/user_provider.dart';
import '../../../../services/google_signin_service.dart';
import '../../../widgets/global_widgets/heading_bar.dart';
import '../../../widgets/global_widgets/ui_button.dart' as ui_button;
import '../../../widgets/profile_widgets/profile_navigations.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<UserProvider>().getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<UserProvider>().current_user;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100), // Set this height
        child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //Top Bar Homepage
                  Heading_Bar(
                    title: MyStrings.profilePageHeading,
                    backButton: false,
                    notifications: false,
                    userAvatar: false,
                  ),
                ]),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SafeArea(
            child: Column(
              children: [
                SizedBoxes.verticalLarge,
                UserAvatar(
                    radius: 70,
                    backgroundColor: MyColors.uiBlock,
                    iconColor: MyColors.lightGray),
                SizedBoxes.verticalLarge,
                Text(
                  firebaseUser.name,
                  style: Styles.H2,
                ),
                SizedBoxes.verticalGargangua,
                ProfileNavigations(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PersonalDetails(),
                      ),
                    );
                  },
                  leadingIcon: Icons.account_circle,
                  title: MyStrings.profilePageField1,
                  trailingIcon: Icons.arrow_forward_ios,
                  flag: true,
                ),
                ProfileNavigations(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddressPage(),
                      ),
                    );
                  },
                  leadingIcon: Icons.location_pin,
                  title: MyStrings.customerProfilePageField2,
                  trailingIcon: Icons.arrow_forward_ios,
                  flag: false,
                ),
                // ProfileNavigations(
                //   onTap: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => const NotificationScreen(),
                //         ));
                //   },
                //   leadingIcon: Icons.circle_notifications,
                //   title: MyStrings.customerProfilePageField3,
                //   trailingIcon: Icons.arrow_forward_ios,
                //   flag: false,
                // ),
                SizedBoxes.verticalGargangua,
                ui_button.IconButton(
                  buttonText: 'LOG OUT',
                  onPressed: () {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.logout();
                  },
                  buttonSize: const Size(360, 56),
                  icon: AppIcons.logout,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
