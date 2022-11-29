import 'package:flutter/material.dart';
import 'package:food_hub_app/utils/helper/preference_settings_helper.dart';
import 'package:food_hub_app/utils/theme.dart';

class PreferenceSettingsProvider extends ChangeNotifier {
  late PreferenceSettingsHelper preferenceSettingsHelper;

  PreferenceSettingsProvider({required this.preferenceSettingsHelper}) {
    _getDailyNotification();
    _getTheme();
  }

  bool _isDailyNotificationActive = false;
  bool get isDailyNotificationActive => _isDailyNotificationActive;

  void _getDailyNotification() async {
    _isDailyNotificationActive =
        await preferenceSettingsHelper.isDailyNotificationActive;
    notifyListeners();
  }

  void enableDailyNotification(bool value) {
    preferenceSettingsHelper.setDailyNotification(value);
    _getDailyNotification();
  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;
  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

  void _getTheme() async {
    _isDarkTheme = await preferenceSettingsHelper.isDarkTheme;
    notifyListeners();
  }

  void enableDarkTheme(bool value) {
    preferenceSettingsHelper.setDarkTheme(value);
    _getTheme();
  }
}
