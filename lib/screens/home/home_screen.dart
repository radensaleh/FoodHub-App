import 'package:flutter/material.dart';
import 'package:food_hub_app/screens/home/widgets/list_food.dart';
import 'package:food_hub_app/screens/home/widgets/list_restaurant.dart';
import 'package:food_hub_app/utils/provider/preference_settings_provider.dart';
import 'package:food_hub_app/utils/utils.dart';
import 'package:food_hub_app/extensions/extension.dart';
import 'package:provider/provider.dart';

import 'widgets/food_search_widget.dart';
import 'widgets/header_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _searchRestaurant;

  @override
  void initState() {
    super.initState();
    _searchRestaurant = TextEditingController();
  }

  @override
  void dispose() {
    _searchRestaurant.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantListProvider>(
      create: (context) => RestaurantListProvider(),
      child: Consumer<RestaurantListProvider>(
        builder: (context, restaurantListProvider, _) {
          return _homeScreen(context, restaurantListProvider);
        },
      ),
    );
  }

  Widget _homeScreen(
      BuildContext context, RestaurantListProvider restaurantListProvider) {
    ThemeData theme = context.theme;
    Size size = MediaQuery.of(context).size;

    return RefreshIndicator(
      onRefresh: () => restaurantListProvider.refreshData,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderWidget(
                        restaurantListProvider: restaurantListProvider,
                      ),
                      const SizedBox(height: 32.0),
                      Consumer<PreferenceSettingsProvider>(
                        builder: (context, preferenceSettingsProvider, child) {
                          return Image.asset(
                            preferenceSettingsProvider.isDarkTheme
                                ? 'assets/images/home_title_dark.png'
                                : 'assets/images/home_title.png',
                            width: size.width - 120,
                          );
                        },
                      ),
                      const SizedBox(height: 16.0),
                      FoodSearchWidget(
                        searchRestaurant: _searchRestaurant,
                        restaurantListProvider: restaurantListProvider,
                      ),
                      const SizedBox(height: 18.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              'Featured Restaurants',
                              style: theme.textTheme.headline4!.copyWith(
                                fontSize: 18,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Text(
                                  'View All',
                                  style: theme.textTheme.bodyText1!.copyWith(
                                    fontSize: 16,
                                    color: orangeColor,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: orangeColor,
                                size: 18,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 18.0),
                      ListRestaurant(
                          restaurantListProvider: restaurantListProvider),
                      const SizedBox(height: 28.0),
                      Text(
                        'Popular Items',
                        style: theme.textTheme.headline4!.copyWith(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 18.0),
                      const ListFood(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
