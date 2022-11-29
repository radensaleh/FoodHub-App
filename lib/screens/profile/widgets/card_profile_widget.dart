import 'package:flutter/material.dart';
import 'package:food_hub_app/extensions/extension.dart';
import 'package:food_hub_app/utils/utils.dart';

import '../../../utils/provider/preference_settings_provider.dart';

class CardProfileWidget extends StatelessWidget {
  final PreferenceSettingsProvider preferenceSettingsProvider;

  const CardProfileWidget({
    Key? key,
    required this.preferenceSettingsProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.person_pin_rounded,
              color: preferenceSettingsProvider.isDarkTheme
                  ? grayColor20
                  : grayColor80,
              size: 18,
            ),
            const SizedBox(width: 5),
            Text(
              'Data Profile',
              style: theme.textTheme.headline4!.copyWith(
                fontSize: 18,
                color: preferenceSettingsProvider.isDarkTheme
                    ? grayColor20
                    : grayColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: preferenceSettingsProvider.isDarkTheme
                ? blackColor80
                : whiteColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                spreadRadius: 0,
                color: preferenceSettingsProvider.isDarkTheme
                    ? blackColor80
                    : grayColor50,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              DataProfile(
                preferenceSettingsProvider: preferenceSettingsProvider,
                icon: const Icon(
                  Icons.credit_card,
                  size: 15,
                  color: whiteColor,
                ),
                title: 'User FoodHub',
              ),
              const SizedBox(height: 12),
              DataProfile(
                preferenceSettingsProvider: preferenceSettingsProvider,
                icon: const Icon(
                  Icons.email,
                  size: 15,
                  color: whiteColor,
                ),
                title: 'user@foodhub.id',
              ),
              const SizedBox(height: 12),
              DataProfile(
                preferenceSettingsProvider: preferenceSettingsProvider,
                icon: const Icon(
                  Icons.phone,
                  size: 15,
                  color: whiteColor,
                ),
                title: '(+62) 221-232-329',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DataProfile extends StatelessWidget {
  final PreferenceSettingsProvider preferenceSettingsProvider;

  const DataProfile({
    Key? key,
    required this.preferenceSettingsProvider,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final Icon icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: yellowColor,
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                spreadRadius: 0,
                color: preferenceSettingsProvider.isDarkTheme
                    ? blackColor50
                    : orangeColor20,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: icon,
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            title,
            style: theme.textTheme.headline4!.copyWith(
              fontSize: 14,
              color: preferenceSettingsProvider.isDarkTheme
                  ? grayColor20
                  : grayColor,
            ),
          ),
        )
      ],
    );
  }
}
