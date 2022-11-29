import 'package:flutter/material.dart';
import 'package:food_hub_app/widgets/widgets.dart';
import 'package:food_hub_app/extensions/extension.dart';

import '../../../data/models/restaurant.dart';

// List Food tidak mengambil data dari API karena di list restaurant tidak ada menus (adanya pada saat hit api detail),
// jadi ini hanya static dari file json saja:)
class ListFood extends StatelessWidget {
  const ListFood({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString(Restaurant.jsonFile),
      builder: (_, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasData) {
            final List<Restaurant> restaurants = parseRestaurant(snapshot.data);

            // Reset Popular Item List
            popularItemsList.clear();
            // Restaurant data loop to add to popular item data
            restaurants.asMap().forEach((key, value) {
              // Add Food Menu
              // For example, only index 0  is used as a Popular Item
              value.menus.foods.asMap().forEach((key, food) {
                if (key == 0) {
                  addPopularItem(
                    food['name'],
                    value.rating,
                    'Food',
                    value.name,
                  );
                }
              });
              // Add Drink Menu
              // For example, only index 0  is used as a Popular Item
              value.menus.drinks.asMap().forEach((key, drink) {
                if (key == 0) {
                  addPopularItem(
                    drink['name'],
                    value.rating,
                    'Drink',
                    value.name,
                  );
                }
              });
            });

            final List<PopularItems> popularItems = popularItemsList;

            return ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 210),
              child: ListView.builder(
                itemCount: popularItemsList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return InkWell(
                    onTap: () {
                      context.showCustomFlashMessage(
                        status: 'info',
                        positionBottom: false,
                      );
                    },
                    borderRadius: BorderRadius.circular(25),
                    child: MenuCardWidget(
                      name: popularItems[index].nameItem,
                      restaurantName: popularItems[index].nameRestaurant,
                      menuType: popularItems[index].itemType,
                      restaurantRating: popularItems[index].ratingRestaurant,
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
      },
    );
  }
}
