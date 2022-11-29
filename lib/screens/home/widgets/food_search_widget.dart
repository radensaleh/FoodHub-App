import 'package:flutter/material.dart';
import 'package:food_hub_app/routes/routes.dart';
import 'package:food_hub_app/utils/provider/preference_settings_provider.dart';
import 'package:provider/provider.dart';

import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class FoodSearchWidget extends StatelessWidget {
  final TextEditingController searchRestaurant;
  final RestaurantListProvider restaurantListProvider;

  const FoodSearchWidget({
    Key? key,
    required this.searchRestaurant,
    required this.restaurantListProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferenceSettingsProvider>(
      builder: (context, preferenceSettingsProvider, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: FormFieldWidget(
                hintText: 'Find for Food or Restaurant...',
                controller: searchRestaurant,
                darkTheme: preferenceSettingsProvider.isDarkTheme,
                onSubmitted: (p0) {
                  Navigator.pushNamed(
                    context,
                    Routes.restaurantSearchScreen,
                    arguments: p0,
                  ).then((value) => restaurantListProvider.refreshData);
                  return null;
                },
              ),
            ),
            const SizedBox(width: 14.0),
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.restaurantSearchScreen,
                  arguments: searchRestaurant.text,
                ).then((value) => restaurantListProvider.refreshData);
              },
              splashColor: orangeColor,
              borderRadius: BorderRadius.circular(12),
              enableFeedback: false,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: preferenceSettingsProvider.isDarkTheme
                        ? blackColor80
                        : whiteColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: preferenceSettingsProvider.isDarkTheme
                            ? blackColor80
                            : Colors.grey.withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 2,
                    vertical: 2,
                  ),
                  child: Icon(
                    Icons.search,
                    color: orangeColor,
                    size: 22,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
