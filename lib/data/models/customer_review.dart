import 'package:food_hub_app/data/models/restaurant_detail.dart';

class CustomerReviewResponse {
  CustomerReviewResponse({
    required this.error,
    required this.message,
    required this.customerReview,
  });

  final bool error;
  final String message;
  final List<CustomerReview> customerReview;

  factory CustomerReviewResponse.fromJson(Map<String, dynamic> json) =>
      CustomerReviewResponse(
        error: json['error'],
        message: json['message'],
        customerReview: List<CustomerReview>.from(json['customerReviews']
            .map((item) => CustomerReview.fromJson(item))),
      );
}
