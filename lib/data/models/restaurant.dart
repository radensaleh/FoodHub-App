import 'dart:convert';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final dynamic rating;
  final Menus menus;

  static const String jsonFile = 'assets/json/restaurant.json';

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory Restaurant.fromJson(Map<String, dynamic> restaurantList) =>
      Restaurant(
        id: restaurantList['id'],
        name: restaurantList['name'],
        description: restaurantList['description'],
        pictureId: restaurantList['pictureId'],
        city: restaurantList['city'],
        rating: restaurantList['rating'],
        menus: Menus.fromJson(restaurantList['menus']),
      );
}

class Menus {
  final List<dynamic> foods;
  final List<dynamic> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> menus) => Menus(
        foods: menus['foods'],
        drinks: menus['drinks'],
      );
}

List<Restaurant> parseRestaurant(String? json) {
  if (json == null) {
    return [];
  }

  final List parsed = jsonDecode(json)['restaurants'];
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}

class PopularItems {
  final String nameItem;
  final dynamic ratingRestaurant;
  final String itemType;
  final String nameRestaurant;

  PopularItems({
    required this.nameItem,
    required this.ratingRestaurant,
    required this.itemType,
    required this.nameRestaurant,
  });
}

void addPopularItem(nameItem, ratingRestaurant, itemType, nameRestaurant) {
  popularItemsList.add(
    PopularItems(
      nameItem: nameItem,
      ratingRestaurant: ratingRestaurant,
      itemType: itemType,
      nameRestaurant: nameRestaurant,
    ),
  );
}

List<PopularItems> popularItemsList = [];
