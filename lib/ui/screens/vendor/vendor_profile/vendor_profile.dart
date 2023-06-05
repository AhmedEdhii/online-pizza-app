import 'package:flutter/material.dart';
import 'package:online_pizza/ui/screens/vendor/store_details/store_details.dart';
import 'package:online_pizza/ui/widgets/global_widgets/user_avatar.dart';
import 'package:provider/provider.dart';
import '../../../../constant/app_icons.dart';
import '../../../../constant/colors.dart';
import '../../../../constant/sizedbox.dart';
import '../../../../constant/strings.dart';
import '../../../../constant/styles.dart';
import '../../../../controllers/user_provider.dart';
import '../../../../services/google_signin_service.dart';
import '../../../widgets/global_widgets/heading_bar.dart';
import '../../../widgets/global_widgets/ui_button.dart' as ui_button;
import '../../../widgets/profile_widgets/profile_navigations.dart';

class VendorProfile extends StatefulWidget {
  const VendorProfile({Key? key}) : super(key: key);

  @override
  State<VendorProfile> createState() => _VendorProfileState();
}

class _VendorProfileState extends State<VendorProfile> {
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
                    backButton: false,
                    title: 'Vendor Profile',
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
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                //   child: Heading_Bar(
                //     title: MyStrings.profilePageHeading,
                //     notifications: false,
                //     userAvatar: false,
                //   ),
                // ),
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
                // ProfileNavigations(
                //   onTap: (){},
                //   leadingIcon: Icons.account_circle,
                //   title: MyStrings.profilePageField1,
                //   trailingIcon: Icons.arrow_forward_ios,
                //   flag: true,
                // ),
                // ProfileNavigations(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => StoreDetails(),
                //       ),
                //     );
                //   },
                //   leadingIcon: AppIcons.edit,
                //   title: MyStrings.vendorProfilePageField2,
                //   trailingIcon: Icons.arrow_forward_ios,
                //   flag: false,
                // ),
                // ProfileNavigations(
                //   onTap: (){},
                //   leadingIcon: Icons.circle_notifications,
                //   title: MyStrings.vendorProfilePageField3,
                //   trailingIcon: Icons.arrow_forward_ios,
                //   flag: false,
                // ),
                SizedBoxes.verticalMedium,

                ui_button.IconButton(
                  buttonText: MyStrings.profilePageButton,
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
