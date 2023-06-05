import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:online_pizza/controllers/product_provider.dart';
import 'package:online_pizza/controllers/review_provider.dart';
import 'package:online_pizza/data/models/product_model.dart';
import 'package:online_pizza/data/models/review_model.dart';
import 'package:online_pizza/services/fire_storage_service.dart';
import 'package:provider/provider.dart';
import 'package:online_pizza/data/models/user_model.dart';
import 'package:online_pizza/controllers/user_provider.dart';

import '../widgets/form_widgets/form_widgets.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  final _formKey = GlobalKey<FormState>();
  var name = '';
  var email = '';
  var phone = '';
  var delivery_addresses = '';
  var avatar_url = '';
  var userRole = '';

  @override
  Widget build(BuildContext context) {
    final Firebase_Storage_Service storage_service = Firebase_Storage_Service();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Book'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextField(
                  hintText: 'User Name',
                  onChanged: (fullName) => name = fullName,
                ),
                CustomTextField(
                  hintText: 'User em',
                  onChanged: (Useremail) => email = Useremail,
                ),
                CustomTextField(
                  hintText: 'User phone',
                  onChanged: (Userphone) => phone = Userphone,
                ),
                CustomTextField(
                  hintText: 'User addres',
                  onChanged: (User_delivery_addresses) =>
                      delivery_addresses = User_delivery_addresses,
                ),
                CustomTextField(
                  hintText: 'User avatar',
                  onChanged: (User_avatar_url) => avatar_url = User_avatar_url,
                ),
                CustomTextField(
                  hintText: 'User role',
                  onChanged: (_userRole) => userRole = _userRole,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  // child: ElevatedButton(
                  //   onPressed: () {
                  //     if (_formKey.currentState!.validate()) {
                  //       User user = User(
                  //         userid: 'e8489469486',
                  //         name: name,
                  //         email: email,
                  //         // phone: phone,
                  //         delivery_addresses:
                  //             delivery_addresses.replaceAll(' ', '').split(','),
                  //         avatar_url:
                  //             'https://miro.medium.com/focal/70/70/50/50/1*L6gfDRU9iPXpWx978BzcOw.png',
                  //         userRole: userRole,
                  //         subscribed_Restaurants: null,
                  //       );
                  //       print(avatar_url);
                  //       context.read<UserProvider>().addUser(user);
                  //     }
                  //   },
                  //   child: const Text('Add Name'),
                  // ),

                  child: ElevatedButton(
                    // onPressed: () async {
                    //   final results = await FilePicker.platform.pickFiles(
                    //     allowMultiple: false,
                    //     type: FileType.custom,
                    //     allowedExtensions: ['png', 'jpg'],
                    //   );

                    //   if (results == null) {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(
                    //         content: Text('No File Selected'),
                    //       ),
                    //     );
                    //     return null;
                    //   }

                    //   final path = results.files.single.path!;
                    //   final fileName = results.files.single.name;

                    //   storage_service.uploadFile(path, fileName);

                    //   final firebase_url =
                    //       storage_service.downloadUrl(fileName);
                    // },

                    onPressed: () {
                      Review review=Review(userid: "1254", review_date: "09/12/22", review_title: "POOR SERVICE", restaurantID: "4567", review_description: "GGGGGSISISISISISISISIIIIISIISISISISISISISISISIEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE", rating: "2");
                      context.read<ReviewProvider>().addNewReview(review);
                      // await var url = forebase storage provider that will return image url
                      // Product product = Product(
                      //     product_name: 'Chicken Tikka',
                      //     product_type: 'Pizza',
                      //     product_description: 'Great Pizza',
                      //     base_price: 300,
                      //     isFeatured: true,
                      //     restaurantID: 'qwfqCTxk5SWfRzw6yeGw');
                      // Product product = Product(
                      //     product_name: 'Test Sauce 3',
                      //     product_type: 'Sauce',
                      //     product_description: 'test',
                      //     base_price: 40,
                      //     isFeatured: false,
                      //     restaurantID: 'curGRfmuPssr9oW1ryYI');

                      // context.read<ProductProvider>().addNewProduct(product);

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         const VendorNavBarNavigationPage(),
                      //   ),
                      // );
                    },
                    child: const Text('Add Product'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
