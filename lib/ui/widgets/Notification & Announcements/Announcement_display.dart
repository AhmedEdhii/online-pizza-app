import 'package:flutter/material.dart';
import 'package:online_pizza/constant/colors.dart';

import '../../../constant/strings.dart';
import '../../../constant/styles.dart';


class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({Key? key}) : super(key: key);

  String getTabName(){
    return "${MyStrings.notificationsPageTab2}(${Announcements.length})";
  }

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}


class _AnnouncementScreenState extends State<AnnouncementScreen> {

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: Announcements.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(foregroundColor: MyColors.lightGray) ,
          title: RichText(
            text: TextSpan(
              text: Announcements[index].name,
              style: Styles.body12pxdark,
              children: [
                TextSpan(
                  text: Announcements[index].notify,
                  style: Styles.body12px,
                ),
              ],
            ),
          ),
          subtitle: Text(Announcements[index].postTime, style: Styles.subbody9px,),
          trailing: const Icon(Icons.keyboard_arrow_right,color: MyColors.primaryColor),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );

  }
}

class MyAnnouncements {
  final int id;
  final String name;
  final String notify;
  final String postTime;

  MyAnnouncements({required this.id,required this.name,required this.notify,required this.postTime});

}

List<MyAnnouncements> Announcements = [
  MyAnnouncements(id: 2, name: "Pawan Kumar",notify: " Placed a new order",postTime: " 20 min ago"),
  MyAnnouncements(id: 3, name: "Pawan Kumar",notify: " Cancelled the order",postTime: " 1 Day ago"),
  MyAnnouncements(id: 4, name: "Pawan Kumar",notify: " Posted new rating",postTime: " 1 Week ago"),
  MyAnnouncements(id: 2, name: "Pawan Kumar",notify: " Placed a new order",postTime: " 20 min ago"),
  MyAnnouncements(id: 3, name: "Pawan Kumar",notify: " Cancelled the order",postTime: " 1 Day ago"),
  MyAnnouncements(id: 4, name: "Pawan Kumar",notify: " Posted new rating",postTime: " 1 Week ago"),
  MyAnnouncements(id: 2, name: "Pawan Kumar",notify: " Placed a new order",postTime: " 20 min ago"),
  MyAnnouncements(id: 3, name: "Pawan Kumar",notify: " Cancelled the order",postTime: " 1 Day ago"),
  MyAnnouncements(id: 4, name: "Pawan Kumar",notify: " Posted new rating",postTime: " 1 Week ago"),
  MyAnnouncements(id: 2, name: "Pawan Kumar",notify: " Placed a new order",postTime: " 20 min ago"),
  MyAnnouncements(id: 3, name: "Pawan Kumar",notify: " Cancelled the order",postTime: " 1 Day ago"),
  MyAnnouncements(id: 4, name: "Pawan Kumar",notify: " Posted new rating",postTime: " 1 Week ago"),
  MyAnnouncements(id: 2, name: "Pawan Kumar",notify: " Placed a new order",postTime: " 20 min ago"),
  MyAnnouncements(id: 3, name: "Pawan Kumar",notify: " Cancelled the order",postTime: " 1 Day ago"),
  MyAnnouncements(id: 4, name: "Pawan Kumar",notify: " Posted new rating",postTime: " 1 Week ago")

];