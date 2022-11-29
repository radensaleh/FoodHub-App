class RestaurantDetailResponse {
  RestaurantDetailResponse({
    required this.error,
    required this.message,
    required this.restaurantDetail,
  });

  final bool error;
  final String message;
  final RestaurantDetail restaurantDetail;

  factory RestaurantDetailResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailResponse(
        error: json['error'],
        message: json['message'],
        restaurantDetail: RestaurantDetail.fromJson(json['restaurant']),
      );
}

class RestaurantDetail {
  RestaurantDetail({
    required this.id,
    required this.name,
    this.description,
    required this.city,
    this.address,
    required this.pictureId,
    required this.rating,
    this.categories,
    this.menus,
    this.customerReviews,
  });

  final String id;
  final String name;
  final String? description;
  final String city;
  final String? address;
  final String pictureId;
  final double rating;
  final List<Category>? categories;
  final Menus? menus;
  final List<CustomerReview>? customerReviews;

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      RestaurantDetail(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        city: json['city'],
        address: json['address'],
        pictureId: json['pictureId'],
        rating: json['rating'].toDouble(),
        categories: List<Category>.from(
            json['categories'].map((item) => Category.fromJson(item))),
        menus: Menus.fromJson(json['menus']),
        customerReviews: List<CustomerReview>.from(json['customerReviews']
            .map((item) => CustomerReview.fromJson(item))),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'city': city,
        'pictureId': pictureId,
        'rating': rating
      };

  factory RestaurantDetail.fromMap(Map<String, dynamic> map) =>
      RestaurantDetail(
        id: map['id'],
        name: map['name'],
        city: map['city'],
        pictureId: map['pictureId'],
        rating: map['rating'].toDouble(),
      );
}

class Category {
  Category({
    required this.name,
  });

  final String name;

  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(name: json['name']);
}

class Menus {
  Menus({
    required this.foods,
    required this.drinks,
  });

  final List<MenusItem> foods;
  final List<MenusItem> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<MenusItem>.from(
            json['foods'].map((item) => MenusItem.fromJson(item))),
        drinks: List<MenusItem>.from(
            json['drinks'].map((item) => MenusItem.fromJson(item))),
      );
}

class MenusItem {
  MenusItem({required this.name});

  final String name;

  factory MenusItem.fromJson(Map<String, dynamic> json) =>
      MenusItem(name: json['name']);
}

class CustomerReview {
  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  final String name;
  final String review;
  final String date;

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json['name'],
        review: json['review'],
        date: json['date'],
      );
}
