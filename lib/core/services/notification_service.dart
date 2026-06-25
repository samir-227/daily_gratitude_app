import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
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

  Future<void> scheduleDaily(int hour, int minute) async {
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
    const iosDetails = DarwinNotificationDetails();
    final details = NotificationDetails(
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
      title: 'أثر',
      body: 'في حاجة حلوة حصلت النهارده؟ سجّلها قبل ما تنسى',
      repeatInterval: RepeatInterval.daily,
      notificationDetails: details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
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
    const iosDetails = DarwinNotificationDetails();
    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    await _plugin.show(
      id: 999,
      title: 'أثر',
      body: 'ده إشعار تجريبي',
      notificationDetails: details,
    );
  }
}
