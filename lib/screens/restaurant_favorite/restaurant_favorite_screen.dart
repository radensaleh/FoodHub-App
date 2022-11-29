import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_hub_app/screens/restaurant_favorite/widgets/list_restaurant_favorite.dart';
import 'package:food_hub_app/extensions/extension.dart';
import 'package:food_hub_app/utils/provider/preference_settings_provider.dart';
import 'package:provider/provider.dart';

import '../../../utils/utils.dart';

class RestaurantFavoriteScreen extends StatefulWidget {
  const RestaurantFavoriteScreen({super.key});

  @override
  State<RestaurantFavoriteScreen> createState() =>
      _RestaurantFavoriteScreenState();
}

class _RestaurantFavoriteScreenState extends State<RestaurantFavoriteScreen> {
  bool isConnect = false;

  @override
  void initState() {
    super.initState();
    internetConnectivity();
  }

  Future<bool> internetConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isConnect = true;
        });
        return true;
      }
    } on SocketException catch (_) {
      setState(() {
        isConnect = false;
      });
      return false;
    }
    setState(() {
      isConnect = false;
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;
    Size size = MediaQuery.of(context).size;

    return Consumer<RestaurantFavoriteProvider>(
      builder: (context, restaurantFavoriteProvider, _) {
        return Scaffold(
          body: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Consumer<PreferenceSettingsProvider>(
                      builder: (context, preferenceSettingsProvider, _) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 40, left: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () => Navigator.pop(context),
                                enableFeedback: false,
                                splashColor: grayColor,
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      color:
                                          preferenceSettingsProvider.isDarkTheme
                                              ? blackColor80
                                              : whiteColor,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: preferenceSettingsProvider
                                                  .isDarkTheme
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
                                      Icons.arrow_back_ios_new,
                                      size: 18,
                                      color:
                                          preferenceSettingsProvider.isDarkTheme
                                              ? whiteColor
                                              : blackColor80,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 35),
                              Text(
                                'Restaurant',
                                style: theme.textTheme.headline4!.copyWith(
                                  fontSize: 26,
                                  color: blackColor,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Favorite',
                                style: theme.textTheme.headline4!.copyWith(
                                  fontSize: 32,
                                  color: orangeColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Total ${restaurantFavoriteProvider.favorite.length} Favorite',
                                style: theme.textTheme.headline4!.copyWith(
                                  fontSize: 16,
                                  color: grayColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Image.asset(
                      'assets/images/pizza.png',
                      width: size.width - 180,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: size.height - 250,
                    child: ListRestaurantFavorite(
                      restaurantFavoriteProvider: restaurantFavoriteProvider,
                      internetConnectivity: isConnect,
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
