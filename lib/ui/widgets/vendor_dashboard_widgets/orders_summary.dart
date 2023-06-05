import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_pizza/controllers/restaurant_provider.dart';
import 'package:provider/provider.dart';

import '../../../constant/colors.dart';
import '../../../constant/sizedbox.dart';
import '../../../constant/strings.dart';
import '../../../constant/styles.dart';
import 'package:online_pizza/ui/widgets/global_widgets/ui_button.dart'
    as ui_button;

import '../../../controllers/order_provider.dart';
import '../../../data/models/order_model.dart';

class OrdersSummary extends StatefulWidget {
  const OrdersSummary({Key? key}) : super(key: key);

  @override
  State<OrdersSummary> createState() => _OrdersSummaryState();
}

class _OrdersSummaryState extends State<OrdersSummary> {
  var activeOrders;
  var deliveredOrders;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RestaurantProvider>().fetchVendorRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    final restaurantID =
        context.watch<RestaurantProvider>().restaurant.restaurantID;
    final provider = Provider.of<OrderProvider>(context, listen: false);
    provider.fetchVendorDeliveredOrderList(restaurantID);
    provider.fetchVendorActiveOrderList(restaurantID);
    activeOrders = provider.activeOrders;
    deliveredOrders = provider.deliveredOrders;
    // print(activeOrders.length);
    return Container(
        height: 110,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: InkWell(
                onTap: () {
                  print("Container 1 pressed");
                  _settingModalBottomSheet(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.25,
//                width: 164,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: MyColors.primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            activeOrders.length > 0 && activeOrders.length < 10
                                ? "0" + activeOrders.length.toString()
                                : activeOrders.length.toString(),
                            style: Styles.activeOrderCount),
                        Text(
                          MyStrings.vendorPageTab1.toUpperCase(),
                          style: Styles.activeOrder,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              // splashColor: Colors.grey, // Splash color
              onTap: () {
                // print("Container 2 pressed");
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2.25,
                //width: 164,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: MyColors.uiBlock,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          deliveredOrders.length > 0 &&
                                  deliveredOrders.length < 10
                              ? "0" + deliveredOrders.length.toString()
                              : deliveredOrders.length.toString(),
                          style: Styles.deliveredOrderCount),
                      Text(
                        MyStrings.vendorPageTab2.toUpperCase(),
                        style: Styles.deliveredOrder,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

void _settingModalBottomSheet(context) {
  final provider = Provider.of<OrderProvider>(context, listen: false);
  final activeOrders = provider.activeOrders;
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
      ),
      context: context,
      builder: (BuildContext bc) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBoxes.verticalMicro,
                Center(
                  child: Container(
                    height: 6,
                    width: 48,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 226, 227, 232),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                SizedBoxes.verticalMedium,
                Text(
                  activeOrders.length > 0 && activeOrders.length < 10
                      ? "0" + activeOrders.length.toString() + " Active Orders"
                      : activeOrders.length.toString() + " Active Orders",
                  style: Styles.bottomSheetTitle,
                ),
                SizedBoxes.verticalBig,
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: activeOrders.length,
                  itemBuilder: (BuildContext context, int index) =>
                      bottomsheet_order_card(
                    order: activeOrders[index],
                    index: index,
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

class bottomsheet_order_card extends StatelessWidget {
  bottomsheet_order_card({Key? key, required this.order, required this.index})
      : super(key: key);
  Order order;
  int index;

  @override
  Widget build(BuildContext context) {
    int value = index + 1;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: Container(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: MyColors.uiBlock,
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order " + value.toString(),
                          style: Styles.bottomSheetText,
                        ),
                        Text(
                          DateFormat.yMMMd()
                              .format(
                                  (DateTime.parse(order.order_date.toString())))
                              .toString(),
                          style: Styles.bottomSheetSubText,
                        ),
                      ],
                    ),
                    Text(
                      "${MyStrings.unit}" + order.total_price,
                      style: Styles.H3Bold,
                    ),
                  ],
                ),
              ),
            ),
            ui_button.FilledButton(
              buttonText: "Mark Delivered",
              onPressed: () async {
                final provider =
                    Provider.of<OrderProvider>(context, listen: false);
                provider.markCompleted(order.orderID);
                bool isDelivered = await provider.isDelivered;
                if (isDelivered) {
                  Navigator.of(context)..pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      margin: EdgeInsets.all(18.0),
                      content: Text(
                        'Order Marked as Delivered!',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              },
              buttonSize: const Size(80, 40),
            ),
          ],
        ),
      ),
    );
  }
}
