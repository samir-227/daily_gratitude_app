import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted || status.isLimited;
  }

  Future<bool> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    return status.isGranted || status.isLimited;
  }

  Future<bool> hasMicrophonePermission() async {
    final status = await Permission.microphone.status;
    return status.isGranted || status.isLimited;
  }

  Future<bool> hasNotificationPermission() async {
    final status = await Permission.notification.status;
    return status.isGranted || status.isLimited;
  }

  Future<bool> openSettings() async {
    return await openAppSettings();
  }
}
