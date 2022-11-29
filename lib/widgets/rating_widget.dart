import 'package:flutter/material.dart';
import 'package:food_hub_app/utils/provider/preference_settings_provider.dart';
import 'package:food_hub_app/utils/utils.dart';
import 'package:food_hub_app/extensions/extension.dart';
import 'package:provider/provider.dart';

class RatingWidget extends StatelessWidget {
  final dynamic rating;
  final double fontSizeRating, fontSizeReview, iconSize, paddingRounded;

  const RatingWidget({
    super.key,
    required this.rating,
    this.fontSizeRating = 14,
    this.fontSizeReview = 10,
    this.iconSize = 14,
    this.paddingRounded = 12,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;

    return Consumer<PreferenceSettingsProvider>(
      builder: (context, preferenceSettingsProvider, _) {
        return Container(
          padding: EdgeInsets.all(paddingRounded),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                color: grayColor,
                spreadRadius: 0,
                blurRadius: 5,
                offset: const Offset(0, 1),
              )
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                rating.toString(),
                style: theme.textTheme.headline4!.copyWith(
                  fontSize: fontSizeRating,
                  color: preferenceSettingsProvider.isDarkTheme
                      ? blackColor50
                      : blackColor,
                ),
              ),
              const SizedBox(width: 4.0),
              Icon(
                Icons.star,
                color: yellowColor,
                size: iconSize,
              ),
              // const SizedBox(width: 2.0),
              // Text(
              //   '($totalReview+)',
              //   style: theme.textTheme.bodyText1!.copyWith(
              //     fontSize: fontSizeReview,
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
