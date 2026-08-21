import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    tzdata.initializeTimeZones();
    final timezoneInfo = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timezoneInfo.identifier));
    const androidSettings = AndroidInitializationSettings('athar_logo');
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

  DarwinNotificationDetails _iosDetails() {
    return const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
  }

  Future<void> scheduleDaily(int hour, int minute) async {
    try {
      await cancelAll();
      final androidDetails = AndroidNotificationDetails(
        'gratitude_daily',
        'تذكير أثر',
        channelDescription: 'يذكّرك تسجّل لحظاتك اليومية',
        importance: Importance.high,
        priority: Priority.high,
        styleInformation: BigPictureStyleInformation(
          DrawableResourceAndroidBitmap('athar_logo'),
          largeIcon: DrawableResourceAndroidBitmap('athar_logo'),
        ),
      );
      final details = NotificationDetails(
        android: androidDetails,
        iOS: _iosDetails(),
      );
      final now = tz.TZDateTime.now(tz.local);
      var scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }
      await _plugin.zonedSchedule(
        id: 0,
        title: 'أثر',
        body: 'في حاجة حلوة حصلت النهارده؟ سجّلها قبل ما تنسى',
        scheduledDate: scheduledDate,
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } catch (_) {}
  }

  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }

  Future<void> showTestNotification() async {
    final androidDetails = AndroidNotificationDetails(
      'gratitude_daily',
      'تذكير أثر',
      channelDescription: 'إشعار اختبار',
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: BigPictureStyleInformation(
        DrawableResourceAndroidBitmap('athar_logo'),
        largeIcon: DrawableResourceAndroidBitmap('athar_logo'),
      ),
    );
    final details = NotificationDetails(
      android: androidDetails,
      iOS: _iosDetails(),
    );
    await _plugin.show(
      id: 999,
      title: 'أثر',
      body: 'ده إشعار تجريبي',
      notificationDetails: details,
    );
  }
}
