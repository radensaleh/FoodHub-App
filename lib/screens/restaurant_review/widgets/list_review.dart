import 'package:flutter/material.dart';
import 'package:food_hub_app/extensions/extension.dart';
import 'package:food_hub_app/utils/provider/preference_settings_provider.dart';
import 'package:food_hub_app/utils/utils.dart';
import 'package:provider/provider.dart';

class ReviewCardWidget extends StatelessWidget {
  final String name;
  final String review;
  final String date;

  const ReviewCardWidget({
    super.key,
    required this.name,
    required this.review,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;

    return Consumer<PreferenceSettingsProvider>(
      builder: (context, preferenceSettingsProvider, _) {
        return Card(
          color: preferenceSettingsProvider.isDarkTheme
              ? blackColor80
              : whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.textTheme.headline4!.copyWith(
                    fontSize: 15,
                    color: orangeColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  review,
                  style: theme.textTheme.headline4!.copyWith(
                    fontSize: 13,
                    color: preferenceSettingsProvider.isDarkTheme
                        ? grayColor50
                        : blackColor50,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  date,
                  style: theme.textTheme.headline4!.copyWith(
                    fontSize: 12,
                    color: preferenceSettingsProvider.isDarkTheme
                        ? grayColor
                        : blackColor20,
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
