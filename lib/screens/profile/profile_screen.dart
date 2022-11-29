import 'package:flutter/material.dart';
import 'package:food_hub_app/extensions/extension.dart';
import 'package:food_hub_app/utils/provider/preference_settings_provider.dart';
import 'package:food_hub_app/utils/utils.dart';
import 'package:food_hub_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'widgets/card_profile_widget.dart';
import 'widgets/card_setting_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;
    Size size = MediaQuery.of(context).size;

    return Consumer<PreferenceSettingsProvider>(
      builder: (context, preferenceSettingsProvider, _) {
        return Scaffold(
          body: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: size.width / 7),
                      child: Image.asset(
                        'assets/images/profile_header.png',
                      ),
                    ),
                    Positioned(
                      top: 30,
                      left: 15,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          enableFeedback: false,
                          child: Container(
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                size: 18,
                                color: blackColor80,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height / 7.2,
                      left: size.width / 2.8,
                      child: Container(
                        width: 110,
                        height: 110,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: preferenceSettingsProvider.isDarkTheme
                              ? blackColor80
                              : whiteColor,
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: preferenceSettingsProvider.isDarkTheme
                                  ? blackColor80
                                  : whiteColor,
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            'assets/images/profile_user.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height / 4.4,
                      left: size.width / 1.9,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ]),
                        child: Icon(
                          Icons.photo_camera,
                          size: 14,
                          color: grayColor80,
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Text(
                    'User FoodHub',
                    style: theme.textTheme.headline4!.copyWith(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    'Edit Profile',
                    style: theme.textTheme.headline4!.copyWith(
                      fontSize: 14,
                      color: grayColor80,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Column(
                    children: [
                      CardProfileWidget(
                        preferenceSettingsProvider: preferenceSettingsProvider,
                      ),
                      const SizedBox(height: 30),
                      CardSettingWidget(
                          preferenceSettingsProvider:
                              preferenceSettingsProvider),
                      const SizedBox(height: 30),
                      ButtonWidget(
                        onPress: () => context.showCustomFlashMessage(
                          status: 'info',
                          title: 'Logout',
                          positionBottom: false,
                        ),
                        title: 'Logout',
                        buttonColor: orangeColor,
                        titleColor: whiteColor,
                        borderColor: orangeColor,
                        paddingHorizontal: 0.0,
                        paddingVertical: 18.0,
                      )
                    ],
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
