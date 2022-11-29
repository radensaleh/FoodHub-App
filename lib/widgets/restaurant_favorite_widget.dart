import 'package:flutter/material.dart';
import 'package:food_hub_app/data/api/api_restaurant.dart';
import 'package:food_hub_app/utils/provider/preference_settings_provider.dart';
import 'package:food_hub_app/utils/utils.dart';
import 'package:food_hub_app/extensions/extension.dart';
import 'package:food_hub_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RestaurantFavoriteCardWidget extends StatelessWidget {
  final String id;
  final String name;
  final String city;
  final String pictureId;
  final dynamic rating;
  final dynamic networkStatus;

  const RestaurantFavoriteCardWidget({
    super.key,
    required this.id,
    required this.name,
    required this.city,
    required this.pictureId,
    required this.rating,
    required this.networkStatus,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;
    Size size = MediaQuery.of(context).size;

    return Consumer<PreferenceSettingsProvider>(
      builder: (context, preferenceSettingsProvider, _) {
        return SizedBox(
          width: size.width - 200,
          child: Stack(
            children: [
              Card(
                color: preferenceSettingsProvider.isDarkTheme
                    ? blackColor80
                    : whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width,
                      height: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: networkStatus
                            ? FadeInImage.assetNetwork(
                                placeholder: 'assets/images/foodhub.png',
                                fit: BoxFit.cover,
                                image:
                                    '${ApiRestaurant.baseUrl}${ApiRestaurant.getImageUrl}$pictureId',
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/foodhub.png',
                                    fit: BoxFit.cover,
                                  );
                                },
                              )
                            : Image.asset(
                                'assets/images/foodhub.png',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        left: 14,
                        right: 14,
                        bottom: 15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  name,
                                  style: theme.textTheme.headline4!
                                      .copyWith(fontSize: 14),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Image.asset(
                                'assets/icons/verif.png',
                                width: 13,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/icons/delivery.png',
                                width: 14,
                              ),
                              const SizedBox(width: 4.0),
                              Flexible(
                                child: Text(
                                  'Free delivery',
                                  style: theme.textTheme.bodyText1!.copyWith(
                                    color:
                                        preferenceSettingsProvider.isDarkTheme
                                            ? whiteColor
                                            : blackColor20,
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Image.asset(
                                'assets/icons/timer.png',
                                width: 10,
                              ),
                              const SizedBox(width: 4.0),
                              Flexible(
                                child: Text(
                                  '10-15 mins',
                                  style: theme.textTheme.bodyText1!.copyWith(
                                    color:
                                        preferenceSettingsProvider.isDarkTheme
                                            ? whiteColor
                                            : blackColor20,
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.grey.withOpacity(0.15),
                                ),
                                child: Text(
                                  'Food',
                                  style: theme.textTheme.bodyText1!.copyWith(
                                    color:
                                        preferenceSettingsProvider.isDarkTheme
                                            ? whiteColor
                                            : blackColor50,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.grey.withOpacity(0.15),
                                ),
                                child: Text(
                                  'Drink',
                                  style: theme.textTheme.bodyText1!.copyWith(
                                    color:
                                        preferenceSettingsProvider.isDarkTheme
                                            ? whiteColor
                                            : blackColor50,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  width: 80,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: whiteColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            text: city,
                            style: theme.textTheme.headline4!.copyWith(
                              fontSize: 12,
                              color: orangeColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 12,
                top: 12,
                child: Consumer<RestaurantFavoriteProvider>(
                  builder: (context, restaurantFavoriteProvider, _) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(20),
                      splashColor: orangeColor,
                      onTap: () async {
                        restaurantFavoriteProvider.removeRestaurantFavorite(id);

                        context.showCustomFlashMessage(
                          status: 'success',
                          title: 'Remove Favorite',
                          positionBottom: false,
                          message: 'Remove $name from Favorite',
                        );
                      },
                      child: Card(
                        color: orangeColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.favorite,
                            color: whiteColor,
                            size: 20,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                left: 16,
                top: 135,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RatingWidget(
                      rating: rating,
                      fontSizeRating: 12,
                      iconSize: 12,
                      paddingRounded: 10,
                    ),
                    const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
