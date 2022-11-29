import 'package:flutter/material.dart';
import 'package:food_hub_app/data/api/api_restaurant.dart';
import 'package:food_hub_app/data/models/restaurant_detail.dart';
import 'package:food_hub_app/utils/provider/response_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  RestaurantDetailProvider({required this.id}) {
    _getDetailRestaurant();
  }

  String id;
  RestaurantDetailResponse? _restaurantDetail;
  ResponseState? _responseState;
  late String _message = '';

  RestaurantDetailResponse? get restaurantDetail => _restaurantDetail;
  ResponseState? get state => _responseState;
  String get message => _message;
  dynamic get refreshData {
    _getDetailRestaurant();
    notifyListeners();
    return;
  }

  Future<dynamic> _getDetailRestaurant() async {
    try {
      _responseState = ResponseState.loading;
      notifyListeners();
      RestaurantDetailResponse restaurantDetail =
          await ApiRestaurant.getRestaurantDetail(id);

      if (restaurantDetail.restaurantDetail == null) {
        _responseState = ResponseState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _responseState = ResponseState.hasData;
        notifyListeners();
        return _restaurantDetail = restaurantDetail;
      }
    } catch (e) {
      _responseState = ResponseState.error;
      notifyListeners();
      return _message = 'Failed to get Data, Please check your connectivity';
    }
  }
}
