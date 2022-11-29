import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:food_hub_app/data/api/api_restaurant.dart';
import 'package:food_hub_app/utils/helper/notification_helper.dart';

import '../../main.dart';

final ReceivePort port = ReceivePort();

class BackgroundServiceHelper {
  static BackgroundServiceHelper? _instace;

  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundServiceHelper._internal() {
    _instace = this;
  }

  factory BackgroundServiceHelper() =>
      _instace ?? BackgroundServiceHelper._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  static Future<void> callback() async {
    print('Alarm fired!');
    final NotificationHelper notificationHelper = NotificationHelper();
    var result = await ApiRestaurant.getRestaurantList();
    var listRestaurant = result.restaurants.toList();

    var randomIndex = 1 + Random().nextInt(10 - 1);
    var randomRestaurant = listRestaurant[randomIndex];

    await notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, randomRestaurant);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
