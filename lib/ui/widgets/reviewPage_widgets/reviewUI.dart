import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:online_pizza/constant/colors.dart';
import 'package:online_pizza/constant/sizedbox.dart';
import 'package:online_pizza/data/models/review_model.dart';

class ReviewUI extends StatefulWidget {
  Review review;
  ReviewUI({required this.review,super.key});
  

  @override
  State<ReviewUI> createState() => _ReviewUIState();
}

class _ReviewUIState extends State<ReviewUI> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:12.0),
      child: Container(
        child: Row(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(radius: 20,backgroundColor: Colors.grey,),
            SizedBoxes.horizontalTiny,
            Container(
            width: MediaQuery.of(context).size.width/1.33,
              
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: MyColors.uiBlock),
              
           
            
             
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(widget.review.review_date.toString(),style: TextStyle(color: MyColors.darkGray),),
                    SizedBoxes.verticalMedium,
                    Text(widget.review.review_title,style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBoxes.verticalTiny,
                  Container(height: 30,
                    child: ListView.builder(//shrinkWrap: true,
         // physics: const NeverScrollableScrollPhysics(),
                         scrollDirection: Axis.horizontal,
                          itemCount: int.parse(widget.review.rating),
                          itemBuilder: (BuildContext context, int index) =>
                                       Icon(Icons.star_rate,color: MyColors.primaryColor,size: 20,)),
                  ),
                    // Row(children: [Icon(Icons.star_rate,color: MyColors.primaryColor,),
                    // Icon(Icons.star_rate,color: MyColors.primaryColor,),
                    // Icon(Icons.star_rate,color: MyColors.primaryColor,),
                    // Icon(Icons.star_rate,color: MyColors.primaryColor,)],),
                   SizedBoxes.verticalMedium,
                   Text(widget.review.review_description)
              //This Food so tasty & delicious. Breakfast so fast Delivered in my place. Chef is very friendly. I’m really like chef for Home Food Order. Thanks. "
                    ],
              
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}