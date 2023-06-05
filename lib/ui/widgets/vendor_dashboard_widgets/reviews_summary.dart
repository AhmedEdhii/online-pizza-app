import 'package:flutter/material.dart';
import 'package:online_pizza/controllers/review_provider.dart';
import 'package:online_pizza/data/models/restaurant_model.dart';
import 'package:provider/provider.dart';

import '../../../constant/colors.dart';
import '../../../constant/sizedbox.dart';
import '../../../constant/strings.dart';
import '../../../constant/styles.dart';

class ReviewsSummary extends StatefulWidget {
  String restaurant_id;
  
   ReviewsSummary({required this.restaurant_id, Key? key}) : super(key: key);

  @override
  State<ReviewsSummary> createState() => _ReviewsSummaryState();
}

class _ReviewsSummaryState extends State<ReviewsSummary> {
     void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ReviewProvider>().fetchReviewList(widget.restaurant_id);
  }

  @override
  Widget build(BuildContext context) {

     final reviews=context.watch<ReviewProvider>().reviews;

     double avgrating=0;
     for(var item in reviews ){avgrating=avgrating+int.parse(item.rating);};
    // reviews.map((e) => avgrating=avgrating+int.parse(e.rating),);
     avgrating=avgrating/reviews.length;
    

    return Container(
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: MyColors.lightGray)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    MyStrings.vendorPageReviewsHeading,
                    style: Styles.body14px,
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     // print('Text Clicked');
                  //   },
                  //   child: Text(
                  //     MyStrings.vendorPageReviewsDetails,
                  //     style: (Styles.clickableText),
                  //   ),
                  // ),
                ],
              ),
              SizedBoxes.verticalLarge,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.star,
                    color: MyColors.primaryColor,
                    size: 30,
                  ),
                  SizedBoxes.horizontalHigherMicro,
                  Text(
                    avgrating.toString(),
                    style: (Styles.ratingCount),
                  ),
                  SizedBoxes.horizontalBig,
                  Text(
                    "Total "+reviews.length.toString()+" reviews.",
                    style: (Styles.body14px),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
