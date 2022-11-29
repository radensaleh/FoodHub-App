import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:food_hub_app/utils/helper/background_service_helper.dart';
import 'package:food_hub_app/utils/helper/date_time_helper.dart';

class NotificationSchedulingProvider extends ChangeNotifier {
  bool _isNotifSchedule = false;

  bool get isNotifSchedule => _isNotifSchedule;

  Future<bool> notifScheduleNews(bool val) async {
    _isNotifSchedule = val;
    if (_isNotifSchedule) {
      print('Notification Schedule News is Active');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundServiceHelper.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Notification Schedule News Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
