import 'dart:convert';

import 'package:food_hub_app/data/models/restaurant_detail.dart';
import 'package:food_hub_app/data/models/restaurant_list.dart';
import 'package:http/http.dart' as http;

class ApiRestaurant {
  static const baseUrl = 'https://restaurant-api.dicoding.dev';
  static const getListUrl = '/list';
  static const getImageUrl = '/images/small/';
  static const getDetailUrl = '/detail/';
  static const getSearchUrl = '/search?q=';
  static const addReviewUrl = '/review';

  static Future<RestaurantListResponse> getRestaurantList() async {
    final response = await http.get(Uri.parse('$baseUrl$getListUrl'));
    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get list Restaurant');
    }
  }

  static Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse('$baseUrl$getDetailUrl$id'));
    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get detail Restaurant');
    }
  }

  static Future<RestaurantListResponse> getSearchRestaurant(
      String query) async {
    final response = await http.get(Uri.parse('$baseUrl$getSearchUrl$query'));
    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Restaurant not Found');
    }
  }

  static Future<RestaurantDetailResponse> testGetRestaurantDetail(
      String id, http.Client client) async {
    final response = await client.get(Uri.parse('$baseUrl$getDetailUrl$id'));
    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get detail Restaurant');
    }
  }

  static Future<void> addReview({
    required String name,
    required String review,
    required String id,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl$addReviewUrl'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(
        <String, String>{
          'name': name,
          'review': review,
          'id': id,
        },
      ),
    );
    if (response.statusCode == 201) {
      return;
    } else if (response == null) {
      throw Exception('No Internet Connection');
    } else {
      throw Exception('Failed to Add Review');
    }
  }
}
