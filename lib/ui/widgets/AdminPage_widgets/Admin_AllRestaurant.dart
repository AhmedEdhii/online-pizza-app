import 'package:flutter/material.dart';
import 'package:online_pizza/constant/app_icons.dart';
import 'package:online_pizza/constant/strings.dart';
import 'package:provider/provider.dart';
import '../../../constant/colors.dart';
import '../../../controllers/restaurant_provider.dart';
import '../../../constant/strings.dart';
import '../global_widgets/ui_button.dart' as ui_button;
import '../global_widgets/user_avatar.dart';

class AllRestaurant extends StatefulWidget {
  const AllRestaurant({Key? key}) : super(key: key);

  String getTabName() {
    return MyStrings.adminPageTab2;
  }

  @override
  State<AllRestaurant> createState() => _AllRestaurantState();
}

class _AllRestaurantState extends State<AllRestaurant> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RestaurantProvider>().fetchRestaurants();
  }

  List<MyRestaurant> Restaurants = [
    MyRestaurant(id: 1, name: "PizzaHut"),
    MyRestaurant(id: 2, name: "O Famous"),
    MyRestaurant(id: 3, name: "Domino's"),
    MyRestaurant(id: 4, name: "Carlifornia Pizza")
  ];
  @override
  Widget build(BuildContext context) {
    final restaurants = context.watch<RestaurantProvider>().restaurants;
    return context.watch<RestaurantProvider>().isRestaurantsFetching
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.separated(
            padding: EdgeInsets.only(top: 16, bottom: 16),
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  border: index == restaurants.length - 1
                      ? const Border(
                          bottom: BorderSide(
                              width: 1,
                              color: MyColors
                                  .uiBlock)) // This will create no border for the first item
                      : const Border(),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: MyColors.uiBlock,
                    child: IconButton(
                        icon: Icon(AppIcons.window),
                        iconSize: 20,
                        color: MyColors.lightGray,
                        onPressed: (() {})),
                  ),
                  title: Text(restaurants[index].restaurant_name),
                  // trailing: Icon(Icons.keyboard_arrow_right,
                  //     color: MyColors.primaryColor),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: MyColors.uiBlock,
                thickness: 1,
              );
            },
          );
  }
}

class MyRestaurant {
  final int id;
  final String name;

  MyRestaurant({required this.id, required this.name});
}
