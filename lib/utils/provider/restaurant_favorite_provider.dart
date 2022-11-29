import 'package:flutter/material.dart';
import 'package:food_hub_app/data/models/restaurant_detail.dart';
import 'package:food_hub_app/utils/helper/database_helper.dart';
import 'package:food_hub_app/utils/provider/response_state.dart';

class RestaurantFavoriteProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  RestaurantFavoriteProvider({required this.databaseHelper}) {
    _getRestaurantFavorite();
  }

  late ResponseState _state;
  ResponseState get state => _state;

  String _message = '';
  String get message => _message;

  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  List<RestaurantDetail> _favorite = [];
  List<RestaurantDetail> get favorite => _favorite;

  void _getRestaurantFavorite() async {
    _favorite = await databaseHelper.getFavorite();

    if (_favorite.isNotEmpty) {
      _state = ResponseState.hasData;
      _message = 'Data Founded';
    } else {
      _state = ResponseState.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addResturantFavorite(RestaurantDetail restaurantDetail) async {
    try {
      await databaseHelper.insertFavorite(restaurantDetail);
      _getRestaurantFavorite();
    } catch (e) {
      _state = ResponseState.error;
      _message = '$e';
      notifyListeners();
    }
  }

  Future<bool> isRestaurantFavorite(String id) async {
    final resFav = await databaseHelper.getFavoriteById(id);
    _isFavorite = resFav.isNotEmpty;
    return resFav.isNotEmpty;
  }

  void removeRestaurantFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getRestaurantFavorite();
    } catch (e) {
      _state = ResponseState.error;
      _message = '$e';
      notifyListeners();
    }
  }
}
