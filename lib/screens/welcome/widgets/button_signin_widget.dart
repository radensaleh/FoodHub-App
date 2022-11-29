import 'package:flutter/material.dart';
import 'package:food_hub_app/extensions/extension.dart';
import 'package:food_hub_app/utils/provider/preference_settings_provider.dart';
import 'package:provider/provider.dart';

import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class ButtonSigninWith extends StatelessWidget {
  final bool positionButtom;

  const ButtonSigninWith({
    Key? key,
    required this.positionButtom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferenceSettingsProvider>(
      builder: (context, preferenceSettingsProvider, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ButtonSigninWidget(
                onPress: () => context.showCustomFlashMessage(
                  status: 'info',
                  positionBottom: positionButtom,
                ),
                title: 'FACEBOOK',
                icon: 'assets/icons/facebook.png',
                buttonColor: preferenceSettingsProvider.isDarkTheme
                    ? blackColor80
                    : whiteColor,
                titleColor: preferenceSettingsProvider.isDarkTheme
                    ? whiteColor
                    : blackColor,
                shadowColor: preferenceSettingsProvider.isDarkTheme
                    ? blackColor50
                    : grayColor20,
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: ButtonSigninWidget(
                onPress: () => context.showCustomFlashMessage(
                  status: 'info',
                  positionBottom: positionButtom,
                ),
                title: 'GOOGLE',
                icon: 'assets/icons/google.png',
                buttonColor: preferenceSettingsProvider.isDarkTheme
                    ? blackColor80
                    : whiteColor,
                titleColor: preferenceSettingsProvider.isDarkTheme
                    ? whiteColor
                    : blackColor,
                shadowColor: preferenceSettingsProvider.isDarkTheme
                    ? blackColor50
                    : grayColor20,
              ),
            ),
          ],
        );
      },
    );
  }
}
