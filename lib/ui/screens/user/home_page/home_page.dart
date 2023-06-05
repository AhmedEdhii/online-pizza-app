import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_pizza/constant/assets.dart';
import 'package:online_pizza/constant/colors.dart';
import 'package:online_pizza/constant/sizedbox.dart';
import 'package:online_pizza/constant/strings.dart';
import 'package:online_pizza/constant/styles.dart';
import 'package:online_pizza/controllers/user_provider.dart';
import 'package:online_pizza/ui/screens/user/all_restaurants/all_restaurants.dart';
import 'package:online_pizza/ui/widgets/homepage_widgets/deals.dart';
import 'package:online_pizza/ui/widgets/homepage_widgets/greeting.dart';
import 'package:online_pizza/ui/widgets/homepage_widgets/searchbar.dart';
import 'package:online_pizza/ui/widgets/homepage_widgets/topbar.dart';
import 'package:provider/provider.dart';

import '../../../../controllers/restaurant_provider.dart';
import '../../../widgets/global_widgets/restaurant_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String Username = "Ebrahim";
  List<String> dealImages = <String>[
    ImageAssets.deal_1,
    ImageAssets.deal_2,
    ImageAssets.deal_3
  ];

  NetworkImage deal = const NetworkImage(
      'https://res.cloudinary.com/csnetworkco/image/upload/v1641975630/csnimages/tmp/phpMTbbvE.png');

  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RestaurantProvider>().fetchRestaurants();
    context.read<UserProvider>().getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final restaurants = context.watch<RestaurantProvider>().restaurants;
    final current_user = context.watch<UserProvider>().current_user;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(200), // Set this height
            child: Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Top Bar Homepage
                    Topbar(
                      avatar: true,
                    ),
                    SizedBoxes.verticalMicro,

                    //Greetings
                    Greetings(name: current_user.name),
                    SizedBoxes.verticalMicro,

                    //SerachBar
                    SearchBar(
                      navigate: true,
                      searchStringChange: (String) {},
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Adding horizontal Banner Carousel

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                  child: SizedBox(
                    height: 158.0,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: dealImages.length,
                      itemBuilder: (BuildContext context, int index) => Deals(
                        deal: dealImages[index],
                        ordernow: () {},
                      ),
                    ),
                  ),
                ),

                SizedBoxes.verticalBig,
                //Adding Headings
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        MyStrings.homePageRestaurants,
                        style: Styles.H2,
                      ),
                      InkWell(
                        onTap: onTap,
                        child: Row(
                          children: [
                            Text(
                              MyStrings.homePageSeeAll,
                              style: Styles.trailingText,
                            ),
                            SizedBoxes.horizontalMicro,
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: MyColors.lightGray,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBoxes.verticalBig,
                context.watch<RestaurantProvider>().isRestaurantsFetching
                    ? const CircularProgressIndicator()
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: restaurants.length,
                        itemBuilder: (BuildContext context, int index) =>
                            RestaurantCard(
                          restaurant: restaurants[index],
                          notifications: false,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AllRestaurantPage(),
      ),
    );
  }
}
