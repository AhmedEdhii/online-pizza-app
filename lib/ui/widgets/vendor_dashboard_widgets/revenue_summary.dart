import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constant/colors.dart';
import '../../../constant/sizedbox.dart';
import '../../../constant/strings.dart';
import '../../../constant/styles.dart';
import '../../../controllers/order_provider.dart';
import '../../../controllers/restaurant_provider.dart';

class RevenueSummary extends StatefulWidget {
  const RevenueSummary({Key? key}) : super(key: key);

  @override
  State<RevenueSummary> createState() => _RevenueSummaryState();
}

class _RevenueSummaryState extends State<RevenueSummary> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RestaurantProvider>().fetchVendorRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    int revenue = 0;
    final restaurantID =
        context.watch<RestaurantProvider>().restaurant.restaurantID;
    final provider = Provider.of<OrderProvider>(context, listen: false);
    provider.fetchVendorOrderList(restaurantID);
    final orders = provider.allOrders;
    for (var i = 0; i < orders.length; i++) {
      revenue = revenue + int.parse(orders[i].total_price);
    }
    return Container(
        height: 90,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: MyColors.lightGray)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16,12, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    MyStrings.vendorPageRevenueHeading,
                    style: Styles.body14px,
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     // print('Text Clicked');
                  //   },
                  //   child: Text(
                  //     MyStrings.vendorPageRevenueDetails,
                  //     style: (Styles.clickableText),
                  //   ),
                  // ),
                ],
              ),
              SizedBoxes.verticalMicro,
              Text(
                "Rs. " + revenue.toString(),
                style: (Styles.H1),
              ),
            ],
          ),
        ));
  }
}
