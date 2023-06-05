import 'package:flutter/material.dart';
import 'package:online_pizza/constant/sizedbox.dart';
import 'package:online_pizza/constant/strings.dart';
import 'package:online_pizza/controllers/cart_provider.dart';
import 'package:online_pizza/controllers/product_provider.dart';
import 'package:online_pizza/ui/screens/reviews.dart';
import 'package:online_pizza/ui/screens/user/food_item_view/food_item_view.dart';
import 'package:online_pizza/ui/widgets/global_widgets/heading_bar.dart';
import 'package:online_pizza/ui/widgets/product_widgets/product_card.dart';
import 'package:online_pizza/ui/widgets/global_Widgets/TabBar.dart' as tabBar;
import 'package:online_pizza/ui/screens/restaurant_view/restaurant_Items_View.dart';
import 'package:provider/provider.dart';

import '../../../constant/styles.dart';
import '../../../data/models/restaurant_model.dart';
import '../../widgets/global_widgets/restaurant_ratings.dart';
import '../../widgets/product_widgets/featured_product_card.dart';

class RestaurantView extends StatefulWidget {
  RestaurantView({
    super.key,
    required this.restaurant,
  });

  Restaurant restaurant;
  @override
  State<RestaurantView> createState() => _RestaurantViewState();
}

class _RestaurantViewState extends State<RestaurantView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<ProductProvider>()
        .fetchFeaturedProductsList(widget.restaurant.restaurantID);
    context
        .read<CartProvider>()
        .setRestaurantID(widget.restaurant.restaurantID);

    //print(widget.restaurant.restaurantID);
  }

  @override
  Widget build(BuildContext context) {
    final featuredProducts = context.watch<ProductProvider>().featuredProducts;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80), // Set this height
        child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Top Bar Homepage
                Heading_Bar(
                  title: widget.restaurant.restaurant_name,
                  backButton: true,
                  notifications: true,
                  userAvatar: false,
                  restaurant_id: widget.restaurant.restaurantID,
                )
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Ratings(
                    rating: '2',
                    delivery_charge: widget.restaurant.delivery_cost,
                    delivery_time: widget.restaurant.delivery_time),
              ],
            ),
            context.watch<ProductProvider>().isFeaturedProductsFetching
                ? SizedBoxes.verticalBig
                : featuredProducts.length == 0
                    ? const Text("")
                    : Column(
                        children: [
                          SizedBoxes.verticalBig,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                MyStrings.restaurantViewPageHeading,
                                style: Styles.H2,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 230.0,
                            child: ListView.builder(
                              clipBehavior: Clip.none,
                              // shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: featuredProducts.length,
                              itemBuilder: (BuildContext context, int index) {
                                return FeaturedProductCard(
                                  product: featuredProducts[index],
                                  isVendor: false,
                                  restaurantID: widget.restaurant.restaurantID,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
            RestaurantItemsView(
                isVendor: false, restaurantID: widget.restaurant.restaurantID)
            //ProductCard(),
          ],
        ),
      ),
    );
  }
}
