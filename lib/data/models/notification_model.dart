class Notifications{
  final String notificationID;
  final String restaurantID;
  final String notification_description;
  final String? notification_image_url;

  Notifications({
    this.notificationID="",
    required this.restaurantID,
    required this.notification_description, 
    required this.notification_image_url
  });
  
  static Notifications fromJson(Map<String, dynamic> json, String id) => Notifications(
        notificationID: id,
        restaurantID: json['restaurantID'] as String? ?? '',
       
        notification_description: json['notification_description'] as String? ?? '',
        notification_image_url: json['notification_image_url'] as String? ?? '',
      );
    Map<String, dynamic> toJson() => {
      
        'notificationID': notificationID,
        'restaurantID': restaurantID,
        'notification_description': notification_description,
        'notification_image_url': notification_image_url,
       
      };

}