import 'package:flutter/widgets.dart';
import 'package:food_hub_app/data/api/api_restaurant.dart';
import 'package:food_hub_app/data/models/restaurant_list.dart';
import 'package:food_hub_app/utils/provider/response_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  RestaurantSearchProvider(id) {
    _searchRestaurant(id);
  }

  RestaurantListResponse? _restaurantList;
  ResponseState? _responseState;
  late String _message = '';

  set queryValue(query) {
    _searchRestaurant(query);
    notifyListeners();
  }

  RestaurantListResponse? get restaurantList => _restaurantList;
  ResponseState? get state => _responseState;
  String get message => _message;

  Future<dynamic> _searchRestaurant(id) async {
    try {
      _responseState = ResponseState.loading;
      notifyListeners();

      RestaurantListResponse restaurantList =
          await ApiRestaurant.getSearchRestaurant(id);
      if (restaurantList.restaurants.isEmpty) {
        _responseState = ResponseState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _responseState = ResponseState.hasData;
        notifyListeners();
        return _restaurantList = restaurantList;
      }
    } catch (e) {
      _responseState = ResponseState.error;
      notifyListeners();
      return _message = 'Data Not Found';
    }
  }
}
