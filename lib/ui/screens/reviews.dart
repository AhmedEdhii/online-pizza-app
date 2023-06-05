import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:online_pizza/controllers/review_provider.dart';
import 'package:online_pizza/data/models/review_model.dart';
import 'package:online_pizza/ui/widgets/global_widgets/heading_bar.dart';
import 'package:online_pizza/ui/widgets/reviewPage_widgets/reviewUI.dart';
import 'package:provider/provider.dart';

class Reviews extends StatefulWidget {
  String restaurantID;
   Reviews({required this.restaurantID,super.key});

  @override
  
  State<Reviews> createState() => _ReviewsState();
  
}


class _ReviewsState extends State<Reviews> {
   void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ReviewProvider>().fetchReviewList(widget.restaurantID);
  }
  @override
  Widget build(BuildContext context) {
    final reviews=context.watch<ReviewProvider>().reviews;
    return Scaffold(appBar: PreferredSize(
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
                    backButton: true,
                    title: "Reviews",
                    notifications: false,
                    userAvatar: false),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left:8.0),
          child: ListView.builder(shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
                       scrollDirection: Axis.vertical,
                        itemCount: reviews.length,
                        itemBuilder: (BuildContext context, int index) =>
                            ReviewUI(review: reviews[index],)),
        ),
      ),

    );
  }
}