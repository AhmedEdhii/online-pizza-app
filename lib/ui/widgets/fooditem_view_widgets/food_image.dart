import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../constant/assets.dart';

class FoodImage extends StatelessWidget {
  FoodImage({Key? key, String? product_image_url}) : super(key: key) {
    if (product_image_url!.isNotEmpty) {
      URL = NetworkImage(product_image_url);
    }
  }

  ImageProvider URL = AssetImage(ImageAssets.restaurantDefaultImage);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(image: URL, fit: BoxFit.fitHeight)),
    );
  }
}
