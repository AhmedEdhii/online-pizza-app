import 'package:flutter/material.dart';
import 'package:online_pizza/controllers/restaurant_provider.dart';
import 'package:online_pizza/ui/screens/reviews.dart';
import 'package:online_pizza/ui/widgets/vendor_dashboard_widgets/orders_summary.dart';
import 'package:online_pizza/ui/widgets/vendor_dashboard_widgets/welcome.dart';
import 'package:provider/provider.dart';

import '../../../../constant/sizedbox.dart';
import '../../../../constant/strings.dart';
import '../../../../constant/styles.dart';
import '../../../../controllers/product_provider.dart';
import '../../../../controllers/user_provider.dart';
import '../../../widgets/product_widgets/featured_product_card.dart';
import '../../../widgets/vendor_dashboard_widgets/revenue_summary.dart';
import '../../../widgets/vendor_dashboard_widgets/reviews_summary.dart';

class VendorDashboard extends StatefulWidget {
  const VendorDashboard({Key? key}) : super(key: key);

  @override
  State<VendorDashboard> createState() => _VendorDashboardState();
}

class _VendorDashboardState extends State<VendorDashboard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProductProvider>().fetchVendorFeaturedProductsList();
    context.read<RestaurantProvider>().fetchVendorRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    final featuredProducts = context.watch<ProductProvider>().featuredProducts;
    final vendor_restaurant = context.watch<RestaurantProvider>().restaurant;
    bool test_check = false;
    return Scaffold(
      body: test_check
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBoxes.verticalLarge,
                    Welcome(),
                    SizedBoxes.verticalLarge,
                    RevenueSummary(),
                    SizedBoxes.verticalLarge,
                    OrdersSummary(),
                    SizedBoxes.verticalLarge,

                    GestureDetector(
                      child: ReviewsSummary(restaurant_id: vendor_restaurant.restaurantID),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Reviews(
                                restaurantID: vendor_restaurant.restaurantID),
                          ),
                        );
                      },
                    ),
                    SizedBoxes.verticalLarge,
                    Text(
                      MyStrings.restaurantViewPageHeading,
                      style: Styles.H2,
                    ),
                    SizedBoxes.verticalLarge,
                    // context.watch<ProductProvider>().isFeaturedProductsFetching
                    //     ? Center(child: const CircularProgressIndicator())
                    //     :
                    SizedBox(
                      height: 230.0,
                      child: featuredProducts.length == 0
                          ? Center(
                              child: const Text("No Featured Product Found"))
                          : ListView.builder(
                              clipBehavior: Clip.none,
                              // shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: featuredProducts.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  FeaturedProductCard(
                                      product: featuredProducts[index], isVendor: true, restaurantID: vendor_restaurant.restaurantID,),
                            ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
