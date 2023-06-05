import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_pizza/constant/styles.dart';
import 'package:online_pizza/controllers/restaurant_provider.dart';
import 'package:online_pizza/ui/widgets/global_widgets/heading_bar.dart';
import 'package:online_pizza/ui/widgets/global_widgets/restaurant_card.dart';
import 'package:online_pizza/ui/widgets/homepage_widgets/searchbar.dart';
import 'package:provider/provider.dart';

import '../../../../constant/sizedbox.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({Key? key}) : super(key: key);

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RestaurantProvider>().fetchRestaurants();
  }
  void _searchResult(String restraurantName) async{
    setState(()  {
      context.read<RestaurantProvider>().fetchSearchedRestaurants(restraurantName);

    });

  }

  @override
  Widget build(BuildContext context) {
    final restaurants = context.watch<RestaurantProvider>().searchedRestaurants;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150), // Set this height
        child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 56, 16, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Top Bar Homepage
                Heading_Bar(
                    title: "Search Restaurants",
                    backButton: true,
                    notifications: false,
                    userAvatar: false),
                SizedBoxes.verticalBig,
                SearchBar(
                  navigate: false, searchStringChange: (String value ) {_searchResult(value); },
                ),
              ],
            ),
          ),
        ),
      ),
      body: context.watch<RestaurantProvider>().isRestaurantsFetching
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Padding(

                padding: const EdgeInsets.fromLTRB(2, 16, 2, 0),
                child:  context.watch<RestaurantProvider>().isRestaurantSearched ?Column(
                  children: [
                    SizedBoxes.verticalMedium,
                    Expanded(
                      child:ListView.builder(
                        itemCount: restaurants.length,
                        itemBuilder: (BuildContext context, int index) {
                          return RestaurantCard(
                            restaurant: restaurants[index],
                            notifications: false,
                          );
                        },
                      )

                    ),
                  ],
                )
                    : Center(child: Text("Not Found. Try Again",textAlign: TextAlign.center, style: Styles.body14px,)),
              ),
            ),
    );
  }
}
