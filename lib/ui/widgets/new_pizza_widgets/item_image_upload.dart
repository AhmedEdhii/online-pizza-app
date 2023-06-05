import 'package:flutter/material.dart';
import 'package:online_pizza/controllers/new_item_provider.dart';
import 'package:provider/provider.dart';

import '../../../constant/assets.dart';
import '../../../constant/strings.dart';
import '../../widgets/global_widgets/ui_button.dart' as ui_button;

class UploadPicture extends StatefulWidget {
  UploadPicture({
    Key? key,
  }) : super(key: key);

  @override
  State<UploadPicture> createState() => _UploadPictureState();
}

class _UploadPictureState extends State<UploadPicture> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        context.read<NewItemProvider>().imageUplaoding
            ? Image.file(
                context.read<NewItemProvider>().imageFile,
                fit: BoxFit.fitHeight,
                height: 150,
                width: 180,
              )
            : Container(
                width: 180,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage(ImageAssets.restaurantDefaultImage),
                      fit: BoxFit.fitHeight),
                ),
              ),
        Container(
          width: 150,
          height: 60,
          child: ui_button.FilledButton(
            buttonText: 'Upload Picture',
            onPressed: () async {
              context.read<NewItemProvider>().uploadImage();
            },
            buttonSize: const Size(10, 40),
          ),
        ),
      ],
    );
  }
}
