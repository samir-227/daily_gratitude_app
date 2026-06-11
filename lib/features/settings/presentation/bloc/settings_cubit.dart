import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../data/repositories/stats_repository.dart';
import '../../../../data/repositories/entry_repository.dart';
import '../../../../core/services/notification_service.dart';
import '../../../../core/services/speech_service.dart';
import '../../../../core/services/audio_service.dart';
import '../../../../core/constants/app_constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class SettingsState {}

class SettingsLoadedState extends SettingsState {
  final bool notificationsEnabled;
  final bool hasArabicLocale;
  final String? arabicLocaleName;
  SettingsLoadedState({
    required this.notificationsEnabled,
    required this.hasArabicLocale,
    this.arabicLocaleName,
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
    _lastLoadedState = SettingsLoadedState(
      notificationsEnabled: notifEnabled,
      hasArabicLocale: hasArabic && localeName != null,
      arabicLocaleName: localeName,
    );
    emit(_lastLoadedState!);
  }

  Future<void> toggleNotifications(bool enabled) async {
    final settingsBox = await Hive.openBox(kSettingsBox);
    await settingsBox.put(kNotificationsEnabled, enabled);
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
        if (entry.moodTag != null) buffer.writeln('Mood: ${entry.moodTag}');
        buffer.writeln();
      }
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/gratitude_export.txt');
      await file.writeAsString(buffer.toString());
      emit(SettingsExportDoneState(file.path));
      if (_lastLoadedState != null) emit(_lastLoadedState!);
    } catch (e) {
      emit(SettingsErrorState('Failed to export entries'));
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
      emit(SettingsErrorState('Failed to clear data'));
      if (_lastLoadedState != null) emit(_lastLoadedState!);
    }
  }

  Future<void> scheduleReminder(int hour, int minute) async {
    final settingsBox = await Hive.openBox(kSettingsBox);
    await settingsBox.put(kReminderTime, '$hour:$minute');
    final notifEnabled = settingsBox.get(kNotificationsEnabled, defaultValue: true) as bool;
    if (notifEnabled) {
      await _notificationService.scheduleDaily(hour, minute);
    }
    _lastLoadedState = SettingsLoadedState(
      notificationsEnabled: notifEnabled,
      hasArabicLocale: _lastLoadedState?.hasArabicLocale ?? false,
      arabicLocaleName: _lastLoadedState?.arabicLocaleName,
    );
    emit(_lastLoadedState!);
  }
}
