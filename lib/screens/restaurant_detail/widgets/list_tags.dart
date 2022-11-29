import 'package:flutter/material.dart';
import 'package:food_hub_app/data/models/restaurant_detail.dart';
import 'package:food_hub_app/extensions/extension.dart';
import 'package:food_hub_app/utils/provider/preference_settings_provider.dart';
import 'package:provider/provider.dart';

import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class ListTags extends StatelessWidget {
  final List<MenusItem> restaurantList;
  final String title;
  final Color color;

  const ListTags({
    super.key,
    required this.restaurantList,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;

    return Consumer<PreferenceSettingsProvider>(
      builder: (context, preferenceSettingsProvider, _) {
        return Container(
          margin: const EdgeInsets.only(
            left: 5,
            right: 5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.fastfood,
                    color: color,
                    size: 18,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    title,
                    style: theme.textTheme.headline4!.copyWith(
                      fontSize: 18,
                      color: preferenceSettingsProvider.isDarkTheme
                          ? whiteColor
                          : blackColor.withOpacity(0.85),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14.0),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: restaurantList.map((data) {
                  return TagWidget(tagName: data.name, tagColor: color);
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
