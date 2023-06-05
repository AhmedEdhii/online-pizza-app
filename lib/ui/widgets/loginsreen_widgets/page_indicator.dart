import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:online_pizza/constant/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageIndicator extends StatefulWidget {
  List<Widget> imglist;
  PageIndicator({Key? key, required this.imglist}) : super(key: key);

  @override
  State<PageIndicator> createState() => _PageIndicatorState();
}

int current = 0;

class _PageIndicatorState extends State<PageIndicator> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 1.0,
              aspectRatio: 16 / 9,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 1200),
              height: 330,
              onPageChanged: (i, r) {
                setState(() {
                  current = i;
                });
              }),
          items: widget.imglist
              .map((e) => Container(child: Container(child: e)))
              .toList(),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          child: AnimatedSmoothIndicator(
            activeIndex: current,
            count: widget.imglist.length,
            effect: const ScrollingDotsEffect(
                activeDotColor: MyColors.primaryColor,
                dotWidth: 8,
                dotHeight: 8),
          ),
        )
      ],
    );
  }
}
