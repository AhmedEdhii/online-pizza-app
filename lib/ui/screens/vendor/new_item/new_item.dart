import 'package:flutter/material.dart';

import 'package:online_pizza/controllers/new_item_provider.dart';
import 'package:online_pizza/controllers/product_provider.dart';
import 'package:online_pizza/ui/widgets/form_widgets/form_widgets.dart';
import 'package:online_pizza/ui/widgets/new_pizza_widgets/featured_switch.dart';
import 'package:provider/provider.dart';

import '../../../../constant/sizedbox.dart';

import '../../../../constant/styles.dart';
import '../../../../controllers/restaurant_provider.dart';
import '../../../widgets/global_widgets/heading_bar.dart';
import '../../../widgets/global_widgets/ui_button.dart' as ui_button;
import '../../../widgets/new_pizza_widgets/item_image_upload.dart';
import '../../../widgets/price_widgets/price_checkbox.dart';

class NewItem extends StatefulWidget {
  NewItem({
    Key? key,
  }) : super(key: key);

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  bool _canPop = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_canPop) {
          return true;
        } else {
          exitDialog(context);
          return false;
        }
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80), // Set this height
            child: Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Top Bar Homepage
                    Heading_Bar(
                      title: "Add New" +
                          " " +
                          context.watch<NewItemProvider>().selectedCategory,
                      onPressed: () => {
                        // context.read<NewItemProvider>().unselectItem(),
                        // context.read<NewItemProvider>().clearImagePath(),
                        // Navigator.maybePop(context),
                        exitDialog(context),
                      },
                      backButton: true,
                      notifications: false,
                      userAvatar: false,
                    ),
                  ],
                ),
              ),
            ),
          ),
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: (context.watch<NewItemProvider>().selectedCategory ==
                        'Pizza')
                    ? PizzaForm()
                    : (context.watch<NewItemProvider>().selectedCategory ==
                            'Sauce')
                        ? SauceForm()
                        : (context.watch<NewItemProvider>().selectedCategory ==
                                'Drink')
                            ? DrinkForm()
                            : SizedBoxes.verticalBig),
          ),
        ),
      ),
    );
  }

  Future<dynamic> exitDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Alert"),
        content: Text("Are you sure you want to exit?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("No"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _canPop = true;
              });
              context.read<NewItemProvider>().clearProviders();
              Navigator.of(context)
                ..pop()
                ..pop();
            },
            child: Text("Yes"),
          ),
        ],
      ),
    );
  }
}

class PizzaForm extends StatefulWidget {
  PizzaForm({
    Key? key,
  }) : super(key: key);

  @override
  State<PizzaForm> createState() => _PizzaFormState();
}

class _PizzaFormState extends State<PizzaForm> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RestaurantProvider>().fetchVendorRestaurant();
  }

  final _formKey = GlobalKey<FormState>();

  var product_name = '';

  var product_description = '';

  @override
  Widget build(BuildContext context) {
    final restaurant_id =
        context.watch<RestaurantProvider>().restaurant.restaurantID;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBoxes.verticalLarge,
          CustomTextField(
            labelText: "Name",
            hintText: 'e.g Chicken Tikka',
            onChanged: (productName) => product_name = productName,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '*Required';
              }
              if (value.length > 35) {
                return 'Name must be 25 characters long';
              }
              return null;
            },
          ),
          SizedBoxes.verticalLarge,
          CustomTextField(
            labelText: "Description",
            hintText: 'e.g Chicken Tikka, Onions, Marinara, Mozzarella',
            maxLines: 3,
            onChanged: (productDescription) =>
                product_description = productDescription,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '*Required';
              }
              if (value.length > 35) {
                return 'Description must be 25 characters long';
              }
              return null;
            },
          ),
          SizedBoxes.verticalBig,
          UploadPicture(),
          SizedBoxes.verticalBig,
          PriceCheckbox(
            size: 'Small',
          ),
          PriceCheckbox(
            size: 'Regular',
          ),
          PriceCheckbox(
            size: 'Large',
          ),
          PriceCheckbox(
            size: 'Jumbo',
          ),
          SizedBoxes.verticalExtraGargangua,
          MarkAsFeatured(),
          SizedBoxes.verticalExtraGargangua,
          ui_button.FilledButton(
            buttonText: "Add New" +
                " " +
                context.watch<NewItemProvider>().selectedCategory,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<NewItemProvider>().setProductDetails(
                      product_name,
                      product_description,
                    );
                context.read<NewItemProvider>().createPizza(
                      Provider.of<NewItemProvider>(context, listen: false)
                          .selectedCategory
                          .toLowerCase(),
                      restaurant_id,
                    );
                context.read<ProductProvider>().addNewProduct(
                      Provider.of<NewItemProvider>(context, listen: false)
                          .newProduct,
                    );
                context.read<NewItemProvider>().clearProviders();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    margin: EdgeInsets.all(18.0),
                    content: Text(
                      'Pizza Added Successfully!',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
            },
          ),
          SizedBoxes.verticalExtraGargangua,
        ],
      ),
    );
  }
}

class SauceForm extends StatefulWidget {
  SauceForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SauceForm> createState() => _SauceFormState();
}

class _SauceFormState extends State<SauceForm> {
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RestaurantProvider>().fetchVendorRestaurant();
  }

  final _formKey = GlobalKey<FormState>();

  var product_name = '';

  var product_description = '';

  var product_price = '';

  @override
  Widget build(BuildContext context) {
    final restaurant_id =
        context.watch<RestaurantProvider>().restaurant.restaurantID;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBoxes.verticalLarge,
          CustomTextField(
            labelText: "Name",
            hintText: 'e.g Hot Sauce',
            onChanged: (productName) => product_name = productName,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '*Required';
              }
              if (value.length > 35) {
                return 'Name must be 25 characters long';
              }
              return null;
            },
          ),
          SizedBoxes.verticalLarge,
          CustomTextField(
            labelText: "Description",
            hintText: 'e.g Extra Spicy',
            maxLines: 3,
            onChanged: (productDescription) =>
                product_description = productDescription,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '*Required';
              }
              if (value.length > 35) {
                return 'Description must be 25 characters long';
              }
              return null;
            },
          ),
          SizedBoxes.verticalBig,
          CustomTextField(
              labelText: "Price",
              hintText: 'e.g 100',
              keyboardType: TextInputType.number,
              onChanged: (productPrice) => product_price = productPrice,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '*Required';
                } else if (!isValidInt(value)) {
                  return '*Please Enter an Integer';
                }
                return null;
              }),
          SizedBoxes.verticalLarge,
          UploadPicture(),
          SizedBoxes.verticalExtraGargangua,
          ui_button.FilledButton(
            buttonText: "Add New" +
                " " +
                context.watch<NewItemProvider>().selectedCategory,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<NewItemProvider>().setProductDetails(
                      product_name,
                      product_description,
                    );
                context.read<NewItemProvider>().setProductPrice(product_price);
                context.read<NewItemProvider>().createProduct(
                      Provider.of<NewItemProvider>(context, listen: false)
                          .selectedCategory
                          .toLowerCase(),
                      restaurant_id,
                    );
                context.read<ProductProvider>().addNewProduct(
                      Provider.of<NewItemProvider>(context, listen: false)
                          .newProduct,
                    );
                context.read<NewItemProvider>().clearProviders();

                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    margin: EdgeInsets.all(18.0),
                    content: Text(
                      'Sauce Added Successfully!',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
            },
          ),
          SizedBoxes.verticalExtraGargangua,
        ],
      ),
    );
  }
}

class DrinkForm extends StatefulWidget {
  DrinkForm({
    Key? key,
  }) : super(key: key);

  @override
  State<DrinkForm> createState() => _DrinkFormState();
}

class _DrinkFormState extends State<DrinkForm> {
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RestaurantProvider>().fetchVendorRestaurant();
  }

  final _formKey = GlobalKey<FormState>();

  var product_name = '';

  var product_description = '';

  var product_price = '';

  @override
  Widget build(BuildContext context) {
    final restaurant_id =
        context.watch<RestaurantProvider>().restaurant.restaurantID;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBoxes.verticalLarge,
          CustomTextField(
            labelText: "Name",
            hintText: 'e.g Pepsi',
            onChanged: (productName) => product_name = productName,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '*Required';
              }
              if (value.length > 35) {
                return 'Name must be 25 characters long';
              }
              return null;
            },
          ),
          SizedBoxes.verticalLarge,
          CustomTextField(
            labelText: "Description",
            hintText: 'e.g 1.5L',
            maxLines: 3,
            onChanged: (productDescription) =>
                product_description = productDescription,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '*Required';
              }
              if (value.length > 35) {
                return 'Description must be 25 characters long';
              }
              return null;
            },
          ),
          SizedBoxes.verticalBig,
          CustomTextField(
              labelText: "Price",
              hintText: 'e.g 150',
              keyboardType: TextInputType.number,
              onChanged: (productPrice) => product_price = productPrice,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '*Required';
                } else if (!isValidInt(value)) {
                  return '*Please Enter an Integer';
                }
                return null;
              }),
          SizedBoxes.verticalLarge,
          UploadPicture(),
          SizedBoxes.verticalExtraGargangua,
          ui_button.FilledButton(
            buttonText: "Add New" +
                " " +
                context.watch<NewItemProvider>().selectedCategory,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<NewItemProvider>().setProductDetails(
                      product_name,
                      product_description,
                    );
                context.read<NewItemProvider>().setProductPrice(product_price);
                context.read<NewItemProvider>().createProduct(
                      Provider.of<NewItemProvider>(context, listen: false)
                          .selectedCategory
                          .toLowerCase(),
                      restaurant_id,
                    );
                context.read<ProductProvider>().addNewProduct(
                      Provider.of<NewItemProvider>(context, listen: false)
                          .newProduct,
                    );
                context.read<NewItemProvider>().clearProviders();

                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    margin: EdgeInsets.all(18.0),
                    content: Text(
                      'Drink Added Successfully!',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
            },
          ),
          SizedBoxes.verticalExtraGargangua,
        ],
      ),
    );
  }
}

class MarkAsFeatured extends StatelessWidget {
  const MarkAsFeatured({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Mark as Featured',
          style: Styles.H3Regular,
        ),
        FeaturedSwitch(),
      ],
    );
  }
}
