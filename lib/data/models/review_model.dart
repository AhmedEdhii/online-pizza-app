class Review{
final String reviewID;
final String userid;
final String review_title;
final String restaurantID;
final String review_description;
final String rating;
final String review_date;

Review({
  this.reviewID="",
  required this.userid,
  required this.review_date ,
  required this.review_title,
  required this.restaurantID,
  required this.review_description,
  required this.rating
});

  static Review fromJson(Map<String, dynamic> json, String id) => Review(
        reviewID: id,
        restaurantID: json['restaurantID'] as String? ?? '',
        review_date: json['review_date'] as String? ?? ' ',
        review_title: json['review_title'] as String? ?? ' ',
        
        userid: json['userid'] as String? ?? '',
        review_description: json['review_description'] as String? ?? '',
        rating: json['rating'] as String? ?? '',
      );
  Map<String, dynamic> toJson() => {
      
        'reviewID': reviewID,
        'restaurantID': restaurantID,
        'review_date': review_date,
        'review_title': review_title,
        'userid': userid,
        'review_description': review_description,
        'rating': rating,
       
      };



}