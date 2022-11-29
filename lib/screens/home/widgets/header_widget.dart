import 'package:flutter/material.dart';
import 'package:food_hub_app/routes/routes.dart';
import 'package:food_hub_app/utils/provider/preference_settings_provider.dart';
import 'package:provider/provider.dart';

import '../../../utils/utils.dart';
import 'package:food_hub_app/extensions/extension.dart';

class HeaderWidget extends StatelessWidget {
  final RestaurantListProvider restaurantListProvider;

  const HeaderWidget({
    super.key,
    required this.restaurantListProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferenceSettingsProvider>(
      builder: (context, preferenceSettingsProvider, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => Navigator.pushNamed(context, Routes.profileScreen),
              enableFeedback: false,
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                'assets/icons/user.png',
                width: 40,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      'Deliver to',
                      style: context.theme.textTheme.caption!.copyWith(
                        color: preferenceSettingsProvider.isDarkTheme
                            ? whiteColor
                            : grayColor,
                        fontSize: 14,
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 22,
                      color: preferenceSettingsProvider.isDarkTheme
                          ? whiteColor
                          : grayColor,
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Rukan CBD Greenlake City',
                  style: context.theme.textTheme.caption!.copyWith(
                    color: orangeColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () =>
                  Navigator.pushNamed(context, Routes.restaurantFavoriteScreen)
                      .then((value) => restaurantListProvider.refreshData),
              enableFeedback: false,
              splashColor: grayColor,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: preferenceSettingsProvider.isDarkTheme
                        ? blackColor80
                        : whiteColor,
                    borderRadius: BorderRadius.circular(16),
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
                    Icons.favorite,
                    size: 20,
                    color: orangeColor,
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
