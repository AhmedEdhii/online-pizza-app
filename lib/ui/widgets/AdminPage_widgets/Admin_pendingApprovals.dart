import 'package:flutter/material.dart';
import 'package:online_pizza/ui/widgets/global_widgets/user_avatar.dart';
import 'package:provider/provider.dart';
import '../../../constant/app_icons.dart';
import '../../../controllers/restaurant_provider.dart';
import '../global_widgets/ui_button.dart' as ui_button;
import '../../../constant/colors.dart';
import '../../../constant/strings.dart';

class pendingApprovals extends StatefulWidget {
  const pendingApprovals({Key? key}) : super(key: key);

  String getTabName() {
    return MyStrings.adminPageTab1;
  }

  @override
  State<pendingApprovals> createState() => _pendingApprovalsState();
}

class _pendingApprovalsState extends State<pendingApprovals> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RestaurantProvider>().fetchNotApprovedRestaurants();
  }

  List<MyApprovals> Approvals = [
    MyApprovals(id: 1, name: "PizzaHut"),
    MyApprovals(id: 2, name: "PizzaHut"),
    MyApprovals(id: 3, name: "Domino's"),
    MyApprovals(id: 4, name: "Carlifornia Pizza")
  ];

  @override
  Widget build(BuildContext context) {
    final pendingRestaurants =
        context.watch<RestaurantProvider>().pendingRestaurants;

    return context.watch<RestaurantProvider>().isFetching
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.separated(
            padding: EdgeInsets.only(top: 16, bottom: 16),
            itemCount: pendingRestaurants.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  border: index == pendingRestaurants.length - 1
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
                  title: Text(pendingRestaurants[index].restaurant_name),
                  trailing: ui_button.FilledButton(
                    buttonText: "Approve",
                    onPressed: () async {
                      final provider = Provider.of<RestaurantProvider>(context,
                          listen: false);
                      await provider.approveVendorAndRestaurant(
                          pendingRestaurants[index].vendorID);
                      if (await provider.isApproved) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            margin: EdgeInsets.all(18.0),
                            content: Text(
                              'Restaurant Approved!',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                    },
                    buttonSize: const Size(80, 40),
                  ),
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

class MyApprovals {
  final int id;
  final String name;

  MyApprovals({required this.id, required this.name});
}
