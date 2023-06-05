import 'package:flutter/material.dart';
import 'package:online_pizza/constant/colors.dart';
import 'package:online_pizza/constant/styles.dart';

class TabBarExample extends StatefulWidget {
  TabBarExample(
      {required this.list,
      required this.tabViewList,
      required this.title,
      super.key});

  List<Widget> tabViewList;
  List<String> list;
  String title;

  @override
  State<TabBarExample> createState() => _TabBarExampleState();
}

class _TabBarExampleState extends State<TabBarExample>
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.splashScreen,
        title: Text(
          widget.title,
          style: Styles.H2,
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _controller,
          tabs: Tab_List,
          labelColor: MyColors.primaryColor,
          indicatorColor: MyColors.primaryColor,
          unselectedLabelColor: MyColors.lightGray,
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: widget.tabViewList,
      ),
    );
  }
}

/*class FilledButton extends StatefulWidget {
  FilledButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.borderRadius = 12.0,
    this.buttonColor = MyColors.primaryColor,
    this.buttonSize = const Size(300, 56),
  }) : super(key: key);
  String buttonText;
  final Function onPressed;
  double borderRadius;
  Color buttonColor;
  Size buttonSize;

  @override
  State<FilledButton> createState() => _FilledButtonState();
}

class _FilledButtonState extends State<FilledButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        widget.onPressed();
      },
      style: ElevatedButton.styleFrom(
        primary: widget.buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(widget.borderRadius),
          ),
        ),
        minimumSize: widget.buttonSize,
      ),
      child: Text(
        widget.buttonText,
        style: Styles.buttonText,
      ),
    );
  }
}

class IconButton extends StatefulWidget {
  const IconButton({Key? key}) : super(key: key);

  @override
  State<IconButton> createState() => _IconButtonState();
}

class _IconButtonState extends State<IconButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(""),
    );
  }
}*/
