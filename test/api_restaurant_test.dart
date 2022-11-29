import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:food_hub_app/data/api/api_restaurant.dart';
import 'package:food_hub_app/data/models/restaurant_detail.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'api_restaurant_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  final client = MockClient();
  test('=> Get Restaurant by Id', () async {
    String id = 'rqdv5juczeskfw1e867';

    when(client
            .get(Uri.parse('https://restaurant-api.dicoding.dev/detail/$id')))
        .thenAnswer(
      (_) async => http.Response(
        '{"error":false,"message":"success","restaurant":{"id":"rqdv5juczeskfw1e867","name":"Melting Pot","description":"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.","city":"Medan","address":"Jln. Pandeglang no 19","pictureId":"14","rating":4.2,"categories":[{"name":"Italia"},{"name":"Modern"}],"menus":{"foods":[{"name":"Paket rosemary"},{"name":"Toastie salmon"},{"name":"Bebek crepes"},{"name":"Salad lengkeng"}],"drinks":[{"name":"Es krim"},{"name":"Sirup"},{"name":"Jus apel"},{"name":"Jus jeruk"},{"name":"Coklat panas"},{"name":"Air"},{"name":"Es kopi"},{"name":"Jus alpukat"},{"name":"Jus mangga"},{"name":"Teh manis"},{"name":"Kopi espresso"},{"name":"Minuman soda"},{"name":"Jus tomat"}]},"customerReviews":[{"name":"Ahmad","review":"Tidak rekomendasi untuk pelajar!","date":"13 November 2019"},{"name":"E2E testing","review":"E2E Post Review Text","date":"30 Oktober 2022"},{"name":"E2E testing","review":"E2E Post Review Text","date":"30 Oktober 2022"},{"name":"LittleQyubee","review":"aaaa","date":"30 Oktober 2022"},{"name":"E2E testing","review":"E2E Post Review Text","date":"30 Oktober 2022"},{"name":"E2E testing","review":"E2E Post Review Text","date":"30 Oktober 2022"},{"name":"E2E testing","review":"E2E Post Review Text","date":"30 Oktober 2022"},{"name":"Alman","review":"Harga sangat terjangkau","date":"30 Oktober 2022"},{"name":"Yusril","review":"ทดสอบ","date":"30 Oktober 2022"},{"name":"hadi","review":"afawf","date":"30 Oktober 2022"},{"name":"sakhi","review":"Halo guys","date":"30 Oktober 2022"},{"name":"Dicky","review":"Halo mas","date":"30 Oktober 2022"},{"name":"Naufal","review":"Halo","date":"30 Oktober 2022"},{"name":"sholah","review":"waww enak","date":"30 Oktober 2022"},{"name":"Uddin","review":"waw mantap","date":"30 Oktober 2022"},{"name":"dede","review":"halo","date":"30 Oktober 2022"}]}}',
        200,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        },
      ),
    );
    RestaurantDetailResponse restaurant =
        await ApiRestaurant.testGetRestaurantDetail(id, client);
    expect(
      restaurant,
      isA<RestaurantDetailResponse>(),
    );
  });

  test('=> Failed to Get Restaurant by Id', () {
    String id = "rqdv5juczeskfw1e8671";

    when(client
            .get(Uri.parse('https://restaurant-api.dicoding.dev/detail/$id')))
        .thenAnswer(
      (_) async => http.Response(
        '{"error":true,"message":"restaurant not found"}',
        404,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        },
      ),
    );

    expect(ApiRestaurant.testGetRestaurantDetail(id, client), throwsException);
  });
}
