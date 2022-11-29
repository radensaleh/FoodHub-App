import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_hub_app/routes/register_routes.dart';
import 'package:food_hub_app/utils/helper/background_service_helper.dart';
import 'package:food_hub_app/utils/helper/database_helper.dart';
import 'package:food_hub_app/utils/helper/notification_helper.dart';
import 'package:food_hub_app/utils/helper/preference_settings_helper.dart';
import 'package:food_hub_app/utils/navigation.dart';
import 'package:food_hub_app/utils/provider/notification_scheduling_provider.dart';
import 'package:food_hub_app/utils/provider/preference_settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/utils.dart';
import 'routes/routes.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundServiceHelper backgroundServiceHelper =
      BackgroundServiceHelper();

  backgroundServiceHelper.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotification(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final NotificationHelper notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    notificationHelper
        .configureSelectNotificationSubject(Routes.restaurantDetailScreen);
  }

  void checkAlarmNotification(
      PreferenceSettingsProvider preferenceSettingsProvider) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final notif = Provider.of<NotificationSchedulingProvider>(
          Navigation.getContext(),
          listen: false);

      if (preferenceSettingsProvider.isDailyNotificationActive) {
        // Check shared prefs alarm is true, then set notif schedule to be active
        notif.notifScheduleNews(
            preferenceSettingsProvider.isDailyNotificationActive);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantFavoriteProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferenceSettingsProvider(
            preferenceSettingsHelper: PreferenceSettingsHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationSchedulingProvider(),
        ),
      ],
      child: Consumer<PreferenceSettingsProvider>(
        builder: (context, preferenceSettingsProvider, _) {
          checkAlarmNotification(preferenceSettingsProvider);
          return MaterialApp(
            title: 'Food Hub App',
            theme: preferenceSettingsProvider.themeData,
            navigatorKey: navigatorKey,
            initialRoute: Routes.splashScreen,
            routes: routesApp,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }
}
