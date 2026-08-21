import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../data/repositories/stats_repository.dart';
import '../../../../data/repositories/entry_repository.dart';
import '../../../../data/models/gratitude_entry.dart';
import '../../../../core/services/notification_service.dart';
import '../../../../core/services/speech_service.dart';
import '../../../../core/services/audio_service.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class SettingsState {}

class SettingsLoadedState extends SettingsState {
  final bool notificationsEnabled;
  final bool hasArabicLocale;
  final String? arabicLocaleName;
  final int storageUsedBytes;
  SettingsLoadedState({
    required this.notificationsEnabled,
    required this.hasArabicLocale,
    this.arabicLocaleName,
    this.storageUsedBytes = 0,
  });
}

class SettingsExportingState extends SettingsState {}

class SettingsExportDoneState extends SettingsState {
  final String filePath;
  SettingsExportDoneState(this.filePath);
}

class SettingsClearingState extends SettingsState {}

class SettingsClearedState extends SettingsState {}

class SettingsErrorState extends SettingsState {
  final String message;
  SettingsErrorState(this.message);
}

class SettingsCubit extends Cubit<SettingsState> {
  final StatsRepository _statsRepo;
  final EntryRepository _entryRepo;
  final NotificationService _notificationService;
  final SpeechService _speechService;
  final AudioService _audioService;
  SettingsLoadedState? _lastLoadedState;

  SettingsCubit(
    this._statsRepo,
    this._entryRepo,
    this._notificationService,
    this._speechService,
    this._audioService,
  ) : super(SettingsLoadedState(
          notificationsEnabled: true,
          hasArabicLocale: false,
        ));

  Future<void> loadSettings() async {
    final settingsBox = await Hive.openBox(kSettingsBox);
    final notifEnabled = settingsBox.get(kNotificationsEnabled, defaultValue: true) as bool;
    final hasArabic = await _speechService.initialize();
    String? localeName;
    if (hasArabic) {
      final locale = await _speechService.getBestArabicLocale();
      localeName = locale;
    }
    final storageBytes = await _getStorageUsedBytes();
    _lastLoadedState = SettingsLoadedState(
      notificationsEnabled: notifEnabled,
      hasArabicLocale: hasArabic && localeName != null,
      arabicLocaleName: localeName,
      storageUsedBytes: storageBytes,
    );
    emit(_lastLoadedState!);
  }

  Future<int> _getStorageUsedBytes() async {
    int total = 0;
    try {
      final audioBytes = await _audioService.getStorageUsedBytes();
      total += audioBytes;
    } catch (_) {}
    try {
      final hivePath = Hive.box<GratitudeEntry>(kEntriesBox).path;
      if (hivePath != null) {
        final hiveFile = File(hivePath);
        if (await hiveFile.exists()) {
          total += await hiveFile.length();
        }
      }
    } catch (_) {}
    return total;
  }

  Future<void> toggleNotifications(bool enabled) async {
    final settingsBox = await Hive.openBox(kSettingsBox);
    await settingsBox.put(kNotificationsEnabled, enabled);
    try {
      if (enabled) {
        final timeStr = settingsBox.get(kReminderTime, defaultValue: '20:0') as String;
        final parts = timeStr.split(':');
        await _notificationService.scheduleDaily(
          int.parse(parts[0]),
          int.parse(parts[1]),
        );
      } else {
        await _notificationService.cancelAll();
      }
    } catch (_) {}
    _lastLoadedState = SettingsLoadedState(
      notificationsEnabled: enabled,
      hasArabicLocale: _lastLoadedState?.hasArabicLocale ?? false,
      arabicLocaleName: _lastLoadedState?.arabicLocaleName,
    );
    emit(_lastLoadedState!);
  }

  Future<void> exportEntries() async {
    emit(SettingsExportingState());
    try {
      final entries = await _entryRepo.getAllEntries();
      final buffer = StringBuffer();
      for (final entry in entries) {
        buffer.writeln('--- ${entry.createdAt} ---');
        buffer.writeln(entry.text);
        if (entry.moodTag != null) buffer.writeln('${AppStrings.moodPrefix} ${entry.moodTag}');
        buffer.writeln();
      }
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/gratitude_export.txt');
      await file.writeAsString(buffer.toString());
      emit(SettingsExportDoneState(file.path));
      if (_lastLoadedState != null) emit(_lastLoadedState!);
    } catch (e) {
      emit(SettingsErrorState(AppStrings.errorFailedToExportEntries));
      if (_lastLoadedState != null) emit(_lastLoadedState!);
    }
  }

  Future<void> clearAllData() async {
    emit(SettingsClearingState());
    try {
      final entries = await _entryRepo.getAllEntries();
      for (final entry in entries) {
        if (entry.audioPath != null) {
          await _audioService.deleteRecording(entry.audioPath!);
        }
      }
      await _entryRepo.clearAll();
      await _statsRepo.resetStats();
      final settingsBox = await Hive.openBox(kSettingsBox);
      await settingsBox.clear();
      emit(SettingsClearedState());
      await loadSettings();
    } catch (e) {
      emit(SettingsErrorState(AppStrings.errorFailedToClearData));
      if (_lastLoadedState != null) emit(_lastLoadedState!);
    }
  }

  Future<void> scheduleReminder(int hour, int minute) async {
    final settingsBox = await Hive.openBox(kSettingsBox);
    await settingsBox.put(kReminderTime, '$hour:$minute');
    final notifEnabled = settingsBox.get(kNotificationsEnabled, defaultValue: true) as bool;
    if (notifEnabled) {
      try {
        await _notificationService.scheduleDaily(hour, minute);
      } catch (_) {}
    }
    _lastLoadedState = SettingsLoadedState(
      notificationsEnabled: notifEnabled,
      hasArabicLocale: _lastLoadedState?.hasArabicLocale ?? false,
      arabicLocaleName: _lastLoadedState?.arabicLocaleName,
    );
    emit(_lastLoadedState!);
  }
}
