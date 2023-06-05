import 'package:flutter/material.dart';
import 'package:online_pizza/constant/colors.dart';
import 'package:online_pizza/constant/strings.dart';

import '../../../constant/styles.dart';

class NotificationDisplay extends StatefulWidget {
  const NotificationDisplay({Key? key}) : super(key: key);

  String getTabName() {
    return "${MyStrings.notificationsPageTab1}(${Notifications.length})";
  }

  @override
  State<NotificationDisplay> createState() => _NotificationDisplayState();
}

class _NotificationDisplayState extends State<NotificationDisplay> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: Notifications.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(foregroundColor: MyColors.lightGray),
          title: RichText(
            text: TextSpan(
              text: Notifications[index].name,
              style: Styles.body12pxdark,
              children: [
                TextSpan(
                  text: Notifications[index].notify,
                  style: Styles.body12px,
                ),
              ],
            ),
          ),
          subtitle: Text(
            Notifications[index].postTime,
            style: Styles.subbody9px,
          ),
          trailing: const Icon(Icons.keyboard_arrow_right,
              color: MyColors.primaryColor),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}

class MyNotifications {
  final int id;
  final String name;
  final String notify;
  final String postTime;

  MyNotifications(
      {required this.id,
      required this.name,
      required this.notify,
      required this.postTime});
}

List<MyNotifications> Notifications = [
  MyNotifications(
      id: 2,
      name: "Pawan Kumar",
      notify: MyStrings.notificationsPageSubtext,
      postTime: " 20 min ago"),
  MyNotifications(
      id: 3,
      name: "Pawan Kumar",
      notify: " Cancelled the order",
      postTime: " 1 Day ago"),
  MyNotifications(
      id: 4,
      name: "Pawan Kumar",
      notify: MyStrings.notificationsPageSubtext,
      postTime: " 1 Week ago"),
  MyNotifications(
      id: 5,
      name: "Pawan Kumar",
      notify: MyStrings.notificationsPageSubtext,
      postTime: " 20 min ago"),
  MyNotifications(
      id: 6,
      name: "Pawan Kumar",
      notify: " Cancelled the order",
      postTime: " 1 Day ago"),
  MyNotifications(
      id: 7,
      name: "Pawan Kumar",
      notify: MyStrings.notificationsPageSubtext,
      postTime: " 1 Week ago"),
  MyNotifications(
      id: 8,
      name: "Pawan Kumar",
      notify: MyStrings.notificationsPageSubtext,
      postTime: " 20 min ago"),
  MyNotifications(
      id: 9,
      name: "Pawan Kumar",
      notify: " Cancelled the order",
      postTime: " 1 Day ago"),
  MyNotifications(
      id: 10,
      name: "Pawan Kumar",
      notify: MyStrings.notificationsPageSubtext,
      postTime: " 1 Week ago"),
  MyNotifications(
      id: 11,
      name: "Pawan Kumar",
      notify: MyStrings.notificationsPageSubtext,
      postTime: " 20 min ago"),
  MyNotifications(
      id: 12,
      name: "Pawan Kumar",
      notify: " Cancelled the order",
      postTime: " 1 Day ago"),
  MyNotifications(
      id: 13,
      name: "Pawan Kumar",
      notify: MyStrings.notificationsPageSubtext,
      postTime: " 1 Week ago"),
  MyNotifications(
      id: 14,
      name: "Pawan Kumar",
      notify: MyStrings.notificationsPageSubtext,
      postTime: " 20 min ago"),
  MyNotifications(
      id: 15,
      name: "Pawan Kumar",
      notify: " Cancelled the order",
      postTime: " 1 Day ago"),
  MyNotifications(
      id: 16,
      name: "Pawan Kumar",
      notify: MyStrings.notificationsPageSubtext,
      postTime: " 1 Week ago"),
  MyNotifications(
      id: 17,
      name: "Pawan Kumar",
      notify: MyStrings.notificationsPageSubtext,
      postTime: " 20 min ago"),
  MyNotifications(
      id: 18,
      name: "Pawan Kumar",
      notify: " Cancelled the order",
      postTime: " 1 Day ago"),
  MyNotifications(
      id: 19,
      name: "Pawan Kumar",
      notify: MyStrings.notificationsPageSubtext,
      postTime: " 1 Week ago")
];
