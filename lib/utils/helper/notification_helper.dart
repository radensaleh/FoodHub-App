import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_hub_app/data/api/api_restaurant.dart';
import 'package:food_hub_app/data/models/restaurant_list.dart';
import 'package:food_hub_app/extensions/extension.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/subjects.dart';
import 'package:http/http.dart' as http;

import '../navigation.dart';

final selectNotificationSubject = BehaviorSubject<String?>();

class NotificationHelper {
  static const _channelId = "1";
  static const _channelName = "channel_01";
  static const _channelDescription = "Restaurant App";
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) {
      var payload = details.payload;
      if (payload != null) {
        print('notification payload: $payload');
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    var response = await http.get(Uri.parse(url));
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantList restaurantList) async {
    var bigPicturePath = await _downloadAndSaveFile(
        '${ApiRestaurant.baseUrl}${ApiRestaurant.getImageUrl}${restaurantList.pictureId}',
        'bigPicture.jpg');

    var bigPictureAndroidStyle = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      largeIcon: FilePathAndroidBitmap(bigPicturePath),
      contentTitle: 'Restaurant Notification',
      htmlFormatContent: true,
      summaryText:
          'Check "${restaurantList.name}" Restaurant to get the latest promo!',
      htmlFormatTitle: true,
    );

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: bigPictureAndroidStyle,
    );

    var iOSPlatformChannelSpecifics = DarwinNotificationDetails(
        attachments: [DarwinNotificationAttachment(bigPicturePath)]);

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    var titleNotification = "<b>Restaurant Notification</b>";
    var titleNews = restaurantList.name;

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleNews, platformChannelSpecifics,
        payload: restaurantList.id);
  }

  Future<void> tryNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      String title,
      String content) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: DefaultStyleInformation(true, true),
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
        0, title, content, platformChannelSpecifics);
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen((String? payload) async {
      if (payload!.isEmpty || payload == '') {
        BuildContext ctx = Navigation.getContext();

        ctx.showCustomFlashMessage(
          status: 'info',
          positionBottom: false,
          title: 'Notification',
          message: 'No Found Payload, this only Test Try Notification',
        );
      } else {
        // var id = RestaurantListResponse.fromJson(json.decode(payload));
        // var article = data.restaurants[0].id;

        Navigation.intentWithData(route, payload);
      }
    });
  }
}
