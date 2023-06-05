import 'package:flutter/material.dart';
import 'package:online_pizza/constant/app_icons.dart';
import 'package:online_pizza/constant/assets.dart';
import 'package:online_pizza/constant/sizedbox.dart';
import 'package:online_pizza/constant/strings.dart';
import 'package:online_pizza/controllers/restaurant_provider.dart';
import 'package:online_pizza/ui/widgets/global_widgets/heading_bar.dart';

import 'package:online_pizza/ui/screens/restaurant_view/restaurant_Items_View.dart';
import 'package:provider/provider.dart';

import '../../../../constant/colors.dart';
import '../../../../constant/styles.dart';
import '../../../widgets/global_widgets/restaurant_ratings.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RestaurantProvider>().fetchVendorRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    final vendorRestaurant = context.watch<RestaurantProvider>().restaurant;
    var file = context.watch<RestaurantProvider>().imageFile;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80), // Set this height
          child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Top Bar Homepage
                  Heading_Bar(
                      title: vendorRestaurant.restaurant_name,
                      backButton: false,
                      notifications: false,
                      userAvatar: false),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                context.read<RestaurantProvider>().imageUplaoding
                    ? file.path.isEmpty
                        ? CircularProgressIndicator()
                        : Stack(
                            children: [
                              Image.file(
                                context.read<RestaurantProvider>().imageFile,
                                fit: BoxFit.fitWidth,
                                height: 160,
                                width: MediaQuery.of(context).size.width * 0.9,
                              ),
                              Positioned(
                                child: InkWell(
                                  onTap: () async {
                                    context
                                        .read<RestaurantProvider>()
                                        .uploadImage();
                                  },
                                  child: CircleAvatar(
                                      child: Icon(
                                        AppIcons.edit,
                                        color: Colors.white,
                                      ),
                                      backgroundColor: MyColors.primaryColor),
                                ),
                                bottom: 10,
                                right: 10,
                              ),
                            ],
                          )
                    : Stack(
                        children: [
                          Container(
                            height: 160,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              image: vendorRestaurant.cover_image_URL != ''
                                  ? DecorationImage(
                                      image: NetworkImage(
                                          vendorRestaurant.cover_image_URL!),
                                      fit: BoxFit.fill)
                                  : DecorationImage(
                                      image: AssetImage(
                                          ImageAssets.restaurantDefaultImage),
                                      fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(4),
                              color: MyColors.uiBlock,
                            ),
                          ),
                          Positioned(
                            child: InkWell(
                              onTap: () async {
                                final provider =
                                    Provider.of<RestaurantProvider>(context,
                                        listen: false);
                                await provider
                                    .setVendorID(vendorRestaurant.vendorID);
                                bool isUploaded = await provider.uploadImage();
                                //print(provider.isImageUpdated);

                                //if(await provider.isImageUpdated){
                                if (isUploaded) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      margin: EdgeInsets.all(18.0),
                                      content: Text(
                                        'Restaurant Cover Updated!',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: CircleAvatar(
                                  child: Icon(
                                    AppIcons.edit,
                                    color: Colors.white,
                                  ),
                                  backgroundColor: MyColors.primaryColor),
                            ),
                            bottom: 10,
                            right: 10,
                          ),
                        ],
                      ),

                // Container(
                //   height: 160,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     image: DecorationImage(
                //         image: AssetImage(ImageAssets.restaurantDefaultImage),
                //         fit: BoxFit.fitHeight),
                //   ),
                // ),
                SizedBoxes.verticalMedium,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Ratings(
                        rating: '2',
                        delivery_charge: vendorRestaurant.delivery_cost,
                        delivery_time: vendorRestaurant.delivery_time),
                  ],
                ),
                SizedBoxes.verticalBig,
                RestaurantItemsView(
                  isVendor: true,
                ),
                //ProductCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
