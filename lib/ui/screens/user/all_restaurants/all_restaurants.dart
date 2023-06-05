import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_pizza/controllers/restaurant_provider.dart';
import 'package:online_pizza/ui/widgets/global_widgets/heading_bar.dart';
import 'package:online_pizza/ui/widgets/global_widgets/restaurant_card.dart';
import 'package:provider/provider.dart';

import '../../../../constant/sizedbox.dart';

class AllRestaurantPage extends StatefulWidget {
  const AllRestaurantPage({Key? key}) : super(key: key);

  @override
  State<AllRestaurantPage> createState() => _AllRestaurantPageState();
}

class _AllRestaurantPageState extends State<AllRestaurantPage> {
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RestaurantProvider>().fetchRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    final restaurants = context.watch<RestaurantProvider>().restaurants;
    return Scaffold(
      body: context.watch<RestaurantProvider>().isRestaurantsFetching
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(2, 16, 2, 0),
                child: Column(
                  children: [
                    Heading_Bar(
                      backButton: true,
                      title: 'All Restaurants',
                      notifications: false,
                      userAvatar: false,
                    ),
                    SizedBoxes.verticalMedium,
                    Expanded(
                      child: ListView.builder(
                        itemCount: restaurants.length,
                        itemBuilder: (BuildContext context, int index) {
                          // print(books[index].id);
                          return RestaurantCard(
                            restaurant: restaurants[index],
                            notifications: false,
                          );
                        },
                      ),
                    ),

                    // Restaurant(
                    //   logo: const NetworkImage(
                    //       "https://thumbs.dreamstime.com/b/pizza-hut-logo-19447536.jpg"),
                    //   name: "Pizza Hut",
                    //   rating: "4.7",
                    //   delivery_charge: "free",
                    //   delivery_time: "20",
                    //   notifications: false,
                    // ),
                    // Restaurant(
                    //   logo: const NetworkImage(
                    //       "https://thumbs.dreamstime.com/b/pizza-hut-logo-19447536.jpg"),
                    //   name: "Pizza Hut",
                    //   rating: "4.7",
                    //   delivery_charge: "free",
                    //   delivery_time: "20",
                    //   notifications: false,
                    // ),
                    // Restaurant(
                    //   logo: const NetworkImage(
                    //       "https://thumbs.dreamstime.com/b/pizza-hut-logo-19447536.jpg"),
                    //   name: "Pizza Hut",
                    //   rating: "4.7",
                    //   delivery_charge: "free",
                    //   delivery_time: "20",
                    //   notifications: false,
                    // ),
                    // Restaurant(
                    //   logo: const NetworkImage(
                    //       "https://thumbs.dreamstime.com/b/pizza-hut-logo-19447536.jpg"),
                    //   name: "Pizza Hut",
                    //   rating: "4.7",
                    //   delivery_charge: "free",
                    //   delivery_time: "20",
                    //   notifications: false,
                    // ),
                  ],
                ),
              ),
            ),
    );
  }
}
