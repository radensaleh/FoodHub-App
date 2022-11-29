import 'package:flutter_test/flutter_test.dart';
import 'package:food_hub_app/data/models/restaurant_list.dart';

void main() {
  group('Parsing JSON Testing', () {
    var json = {
      "error": false,
      "message": "success",
      "count": 20,
      "restaurants": [
        {
          "id": "rqdv5juczeskfw1e867",
          "name": "Melting Pot",
          "description":
              "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
          "pictureId": "14",
          "city": "Medan",
          "rating": 4.2
        },
        {
          "id": "s1knt6za9kkfw1e867",
          "name": "Kafe Kita",
          "description":
              "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
          "pictureId": "25",
          "city": "Gorontalo",
          "rating": 4
        }
      ]
    };

    var jsonParse = RestaurantListResponse.fromJson(json);

    test('=> JSON is RestaurantListResponse Model', () {
      var result = jsonParse is RestaurantListResponse;
      expect(result, true);
    });

    test('=> Restaurant List is Exist/not Empty', () {
      var result = jsonParse.restaurants is List<RestaurantList>;
      expect(result, true);
    });

    test('=> There is data on the name of the "Kafe Kita" Restaurant', () {
      var result =
          jsonParse.restaurants.map((e) => e.name).contains('Kafe Kita');
      expect(result, true);
    });
  });
}
