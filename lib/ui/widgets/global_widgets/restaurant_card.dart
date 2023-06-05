import 'package:flutter/material.dart';
import 'package:online_pizza/constant/colors.dart';
import 'package:online_pizza/constant/sizedbox.dart';
import 'package:online_pizza/constant/styles.dart';
import 'package:online_pizza/data/models/restaurant_model.dart';
import 'package:online_pizza/ui/screens/restaurant_view/restaurant_view.dart';
import 'package:online_pizza/ui/widgets/global_widgets/restaurant_ratings.dart';

import '../../../constant/assets.dart';
import '../../screens/vendor_navbar_navigation_page.dart';

class RestaurantCard extends StatefulWidget {

  RestaurantCard(
      {required this.restaurant, required this.notifications, super.key});

  Restaurant restaurant;
  bool notifications;
 

  @override
  State<RestaurantCard> createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: onTap,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          height: 270,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: <Widget>[
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    image: widget.restaurant.cover_image_URL != ''
                        ? DecorationImage(
                            image: NetworkImage(
                                widget.restaurant.cover_image_URL!),
                            fit: BoxFit.fill)
                        : DecorationImage(
                            image:
                                AssetImage(ImageAssets.restaurantDefaultImage),
                            fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(10),
                    color: MyColors.uiBlock,
                  ),
                ),
                // Positioned(
                //   child: SetNotifications(
                //       onTap: () {
                //         setState(
                //           () {
                //             widget.notifications = !widget.notifications;
                //           },
                //         );
                //       },
                //       set: widget.notifications),
                //   top: 10,
                //   right: 10,
                // ),
              ]),
              SizedBoxes.verticalMedium,
              Text(widget.restaurant.restaurant_name, style: Styles.H1),
              SizedBoxes.verticalMicro,
              SizedBoxes.verticalMicro,
              Ratings(
                  rating: "3.0",
                  delivery_charge: widget.restaurant.delivery_cost,
                  delivery_time: widget.restaurant.delivery_time),
            ],
          ),
        ),
      ),
    );
  }

  void onTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RestaurantView(
          restaurant: widget.restaurant,
        ),
      ),
    );
  }
}

class SetNotifications extends StatelessWidget {
  const SetNotifications({Key? key, required this.onTap, required this.set})
      : super(key: key);
  final VoidCallback onTap;
  final bool set;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        child: Icon(
          Icons.notifications_none_outlined,
          color: set ? Colors.white : MyColors.darkGray,
        ),
        backgroundColor:
            set ? MyColors.primaryColor : Color.fromARGB(32, 43, 43, 43),
      ),
    );
  }
}
