import 'package:flutter/material.dart';
import 'package:online_pizza/constant/colors.dart';
import 'package:online_pizza/constant/styles.dart';

class subTabBarExample extends StatefulWidget {
  subTabBarExample(
      {required this.list,
      required this.tabViewList,

      super.key});

  List<Widget> tabViewList;
  List<String> list;


  @override
  State<subTabBarExample> createState() => _subTabBarExampleState();
}

class _subTabBarExampleState extends State<subTabBarExample>
    with SingleTickerProviderStateMixin {
  List<String> list = [];
  late TabController _controller;
  int _selectedIndex = 0;

  List<Widget> Tab_List = [];

  void CreateTabs() {
    for (var i = 0; i < list.length; i++) {
      Tab_List.add(Tab(
        text: list[i],
      ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    list = widget.list;
    CreateTabs();
    if (widget.tabViewList.length == list.length) {
      // in order to not allow code to crash whole application due to small mistake

      super.initState();
      _controller = TabController(length: Tab_List.length, vsync: this);

      _controller.addListener(() {
        setState(() {
          _selectedIndex = _controller.index;
        });
        print("Selected Index: " + _controller.index.toString());
      });
    } else {
      print("Tab view list and Tab list length does not match");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [TabBar(
        controller: _controller,
        tabs: Tab_List,
        labelColor: MyColors.primaryColor,
        indicatorColor: MyColors.primaryColor,
        unselectedLabelColor: MyColors.lightGray,
      ),
          SizedBox(
            height: MediaQuery.of(context).size.height * (9/23),
            child: TabBarView(
              controller: _controller,
              children: widget.tabViewList,
            ),
          ),
        ],

    );
  }
}
