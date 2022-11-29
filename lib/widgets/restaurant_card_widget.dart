import 'package:flutter/material.dart';
import 'package:food_hub_app/data/api/api_restaurant.dart';
import 'package:food_hub_app/data/models/restaurant_detail.dart';
import 'package:food_hub_app/utils/provider/preference_settings_provider.dart';
import 'package:food_hub_app/utils/utils.dart';
import 'package:food_hub_app/extensions/extension.dart';
import 'package:food_hub_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RestaurantCardWidget extends StatefulWidget {
  final String id;
  final String name;
  final String city;
  final String pictureId;
  final dynamic rating;

  const RestaurantCardWidget({
    super.key,
    required this.id,
    required this.name,
    required this.city,
    required this.pictureId,
    required this.rating,
  });

  @override
  State<RestaurantCardWidget> createState() => _RestaurantCardWidgetState();
}

class _RestaurantCardWidgetState extends State<RestaurantCardWidget> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final fav =
          Provider.of<RestaurantFavoriteProvider>(context, listen: false);

      if (await fav.isRestaurantFavorite(widget.id)) {
        setState(() {
          isFavorite = true;
        });
      } else {
        setState(() {
          isFavorite = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;
    Size size = MediaQuery.of(context).size;

    return Consumer<PreferenceSettingsProvider>(
      builder: (context, preferenceSettingsProvider, _) {
        return SizedBox(
          width: size.width - 90,
          child: Card(
            color: preferenceSettingsProvider.isDarkTheme
                ? blackColor80
                : whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      SizedBox(
                        width: size.width,
                        height: 149,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18),
                          ),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/images/foodhub.png',
                            fit: BoxFit.cover,
                            image:
                                '${ApiRestaurant.baseUrl}${ApiRestaurant.getImageUrl}${widget.pictureId}',
                            imageErrorBuilder: (context, error, stackTrace) =>
                                Image.asset('assets/images/foodhub.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RatingWidget(
                              rating: widget.rating,
                            ),
                            Consumer<RestaurantFavoriteProvider>(
                              builder:
                                  (context, restaurantFavoriteProvider, _) {
                                return InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  splashColor: orangeColor,
                                  onTap: () async {
                                    final favoriteCheck =
                                        await restaurantFavoriteProvider
                                            .isRestaurantFavorite(widget.id);

                                    if (favoriteCheck) {
                                      restaurantFavoriteProvider
                                          .removeRestaurantFavorite(widget.id);

                                      context.showCustomFlashMessage(
                                        status: 'success',
                                        title: 'Success Add Favorite',
                                        positionBottom: false,
                                        message:
                                            'Add ${widget.name} to your Favorite',
                                      );
                                    } else {
                                      restaurantFavoriteProvider
                                          .addResturantFavorite(
                                        RestaurantDetail(
                                          id: widget.id,
                                          name: widget.name,
                                          city: widget.city,
                                          pictureId: widget.pictureId,
                                          rating: widget.rating,
                                        ),
                                      );

                                      context.showCustomFlashMessage(
                                        status: 'success',
                                        title: 'Success Add Favorite',
                                        positionBottom: false,
                                        message:
                                            'Add ${widget.name} to your Favorite',
                                      );
                                    }
                                    setState(() {
                                      isFavorite = !isFavorite;
                                    });
                                  },
                                  child: isFavorite
                                      ? Card(
                                          color: orangeColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(6),
                                            child: Icon(
                                              Icons.favorite,
                                              color: whiteColor,
                                              size: 20,
                                            ),
                                          ),
                                        )
                                      : Card(
                                          color: Colors.grey.withOpacity(0.5),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(6),
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                widget.name,
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
                        const SizedBox(height: 11.0),
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
                                  color: preferenceSettingsProvider.isDarkTheme
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
                                  color: preferenceSettingsProvider.isDarkTheme
                                      ? whiteColor
                                      : blackColor20,
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12.0),
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
                                  color: preferenceSettingsProvider.isDarkTheme
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
                                  color: preferenceSettingsProvider.isDarkTheme
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
