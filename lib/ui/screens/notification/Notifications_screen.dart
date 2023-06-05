import 'package:flutter/material.dart';
import 'package:online_pizza/constant/strings.dart';
import 'package:online_pizza/ui/widgets/global_Widgets/TabBar.dart' as tabBar;
import 'package:online_pizza/ui/widgets/Notification & Announcements/Announcement_display.dart'
as announcements_display;
import 'package:online_pizza/ui/widgets/Notification & Announcements/Notification_display.dart'
as notification_display;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  announcements_display.AnnouncementScreen announcements = const announcements_display.AnnouncementScreen();
  notification_display.NotificationDisplay notifications = const notification_display.NotificationDisplay();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabBar.TabBarExample(
        list:  [notifications.getTabName() ,announcements.getTabName()],
        tabViewList:  [ notifications,announcements],
        title: MyStrings.notificationsPageHeading,
      ),
    );
  }
}