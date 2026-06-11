import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await _plugin.initialize(settings: initSettings);
    _initialized = true;
  }

  Future<void> scheduleDaily(int hour, int minute) async {
    await cancelAll();
    const androidDetails = AndroidNotificationDetails(
      'gratitude_daily',
      'Daily Gratitude Reminder',
      channelDescription: 'Reminds you to record your daily gratitude',
      importance: Importance.high,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails();
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    final now = DateTime.now();
    var scheduledDate = DateTime(now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    await _plugin.periodicallyShow(
      id: 0,
      title: 'Time for your daily gratitude \u{1F64F}',
      body: 'Take 30 seconds to appreciate something today',
      repeatInterval: RepeatInterval.daily,
      notificationDetails: details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }

  Future<void> showTestNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'gratitude_daily',
      'Daily Gratitude Reminder',
      channelDescription: 'Test notification',
      importance: Importance.high,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails();
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    await _plugin.show(
      id: 999,
      title: 'Daily Gratitude \u{1F64F}',
      body: 'This is a test notification',
      notificationDetails: details,
    );
  }
}
