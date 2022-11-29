import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_hub_app/screens/home/widgets/food_search_widget.dart';
import 'package:food_hub_app/screens/home/widgets/list_food.dart';
import 'package:food_hub_app/screens/home/widgets/list_restaurant.dart';
import 'package:food_hub_app/screens/screens.dart';
import 'package:food_hub_app/utils/helper/preference_settings_helper.dart';
import 'package:food_hub_app/utils/provider/preference_settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget createHomeScreen() => MultiProvider(
      providers: [
        ChangeNotifierProvider<PreferenceSettingsProvider>(
          create: (_) => PreferenceSettingsProvider(
            preferenceSettingsHelper: PreferenceSettingsHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: Consumer<PreferenceSettingsProvider>(
        builder: (context, preferenceSettingsProvider, _) {
          return const MaterialApp(
            home: HomeScreen(),
          );
        },
      ),
    );

void main() {
  group('Home Screen Testing', () {
    testWidgets('=> List Restaurant Widget is Exsist',
        (WidgetTester tester) async {
      await tester.pumpWidget(createHomeScreen());
      expect(find.byType(ListRestaurant), findsOneWidget);
    });

    testWidgets('=> FoodSearch Widget is Exsist', (WidgetTester tester) async {
      await tester.pumpWidget(createHomeScreen());
      expect(find.byType(FoodSearchWidget), findsOneWidget);
    });

    testWidgets('=> List Food Widget is Exsist', (WidgetTester tester) async {
      await tester.pumpWidget(createHomeScreen());
      expect(find.byType(ListFood), findsOneWidget);
    });
  });
}
