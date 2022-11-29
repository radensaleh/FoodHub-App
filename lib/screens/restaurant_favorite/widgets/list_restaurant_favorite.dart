import 'package:flutter/material.dart';
import 'package:food_hub_app/routes/routes.dart';
import 'package:food_hub_app/utils/utils.dart';

import '../../../widgets/widgets.dart';

class ListRestaurantFavorite extends StatelessWidget {
  final RestaurantFavoriteProvider restaurantFavoriteProvider;
  final bool internetConnectivity;

  const ListRestaurantFavorite({
    super.key,
    required this.restaurantFavoriteProvider,
    required this.internetConnectivity,
  });

  @override
  Widget build(BuildContext context) {
    if (restaurantFavoriteProvider.favorite.isNotEmpty) {
      return ListView.builder(
        padding: const EdgeInsets.only(top: 15),
        shrinkWrap: true,
        itemCount: restaurantFavoriteProvider.favorite.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                _,
                Routes.restaurantDetailScreen,
                arguments: restaurantFavoriteProvider.favorite[index].id,
              );
            },
            borderRadius: BorderRadius.circular(25),
            child: RestaurantFavoriteCardWidget(
              id: restaurantFavoriteProvider.favorite[index].id,
              name: restaurantFavoriteProvider.favorite[index].name,
              city: restaurantFavoriteProvider.favorite[index].city,
              pictureId: restaurantFavoriteProvider.favorite[index].pictureId,
              rating: restaurantFavoriteProvider.favorite[index].rating,
              networkStatus: internetConnectivity,
            ),
          );
        },
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/notfound.png',
                width: 200,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Empty Data',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
      );
    }
  }
}
