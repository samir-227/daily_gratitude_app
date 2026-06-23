import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/services/speech_service.dart';
import '../../../../core/services/audio_service.dart';
import '../../../../data/repositories/entry_repository.dart';
import '../../../../data/repositories/stats_repository.dart';
import '../../../../data/models/gratitude_entry.dart';
import '../../../../core/utils/arabic_text_utils.dart';
import '../../../../core/constants/app_constants.dart';

abstract class RecordingState {
  final String? selectedMood;
  RecordingState({this.selectedMood});
}

class RecordingIdleState extends RecordingState {
  RecordingIdleState({String? selectedMood})
    : super(selectedMood: selectedMood);
}

class RecordingInProgressState extends RecordingState {
  final String liveText;
  RecordingInProgressState(this.liveText, {String? selectedMood})
    : super(selectedMood: selectedMood);
}

class RecordingDoneState extends RecordingState {
  final String text;
  final String audioPath;
  final int durationMs;
  RecordingDoneState(
    this.text,
    this.audioPath,
    this.durationMs, {
    String? selectedMood,
  }) : super(selectedMood: selectedMood);
}

class SavingEntryState extends RecordingState {
  SavingEntryState({String? selectedMood}) : super(selectedMood: selectedMood);
}

class EntrySavedState extends RecordingState {
  final int? milestoneStreak;
  EntrySavedState({this.milestoneStreak});
}

class RecordingErrorState extends RecordingState {
  final String message;
  RecordingErrorState(this.message, {String? selectedMood})
    : super(selectedMood: selectedMood);
}

class RecordingCubit extends Cubit<RecordingState> {
  final SpeechService _speechService;
  final AudioService _audioService;
  final EntryRepository _entryRepo;
  final StatsRepository _statsRepo;
  final _uuid = const Uuid();

  RecordingCubit(
    this._speechService,
    this._audioService,
    this._entryRepo,
    this._statsRepo,
  ) : super(RecordingIdleState()) {
    _checkMilestoneOnInit();
  }

  String _currentText = '';
  String _audioPath = '';
  int _durationMs = 0;
  String? _selectedMood;
  int? _lastCheckedMilestone;
  Timer? _sttThrottle;
  String _lastEmittedText = '';
  static const _throttleDuration = Duration(milliseconds: 200);

  void selectMood(String? mood) {
    _selectedMood = mood;
    final current = state;
    if (current is RecordingInProgressState) {
      emit(
        RecordingInProgressState(current.liveText, selectedMood: _selectedMood),
      );
    } else if (current is RecordingDoneState) {
      emit(
        RecordingDoneState(
          current.text,
          current.audioPath,
          current.durationMs,
          selectedMood: _selectedMood,
        ),
      );
    } else if (current is SavingEntryState) {
      emit(SavingEntryState(selectedMood: _selectedMood));
    } else if (current is RecordingErrorState) {
      emit(RecordingErrorState(current.message, selectedMood: _selectedMood));
    } else {
      emit(RecordingIdleState(selectedMood: _selectedMood));
    }
  }

  Future<void> startRecording() async {
    try {
      final initialized = await _speechService.initialize();
      if (!initialized) {
        emit(
          RecordingErrorState(
            'Speech recognition failed to initialize',
            selectedMood: _selectedMood,
          ),
        );
        return;
      }
      await _audioService.startRecording();
      await _speechService.startListening(
        onResult: (text) {
          _currentText = text;
          _throttleSttResult(text);
        },
        onError: (error) {
          emit(RecordingErrorState(error, selectedMood: _selectedMood));
        },
      );
      emit(RecordingInProgressState('', selectedMood: _selectedMood));
    } catch (e) {
      emit(
        RecordingErrorState(
          'Failed to start recording',
          selectedMood: _selectedMood,
        ),
      );
    }
  }

  Future<void> stopRecording() async {
    try {
      _audioPath = await _audioService.stopRecording();
      await _speechService.stopListening();
      emit(
        RecordingDoneState(
          _currentText,
          _audioPath,
          _durationMs,
          selectedMood: _selectedMood,
        ),
      );
    } catch (e) {
      emit(
        RecordingErrorState(
          'Failed to stop recording',
          selectedMood: _selectedMood,
        ),
      );
    }
  }

  void updateText(String text) {
    _currentText = text;
    final current = state;
    if (current is RecordingDoneState) {
      emit(
        RecordingDoneState(
          text,
          current.audioPath,
          current.durationMs,
          selectedMood: _selectedMood,
        ),
      );
    }
  }

  Future<void> saveEntry() async {
    emit(SavingEntryState(selectedMood: _selectedMood));
    try {
      final id = _uuid.v4();
      final permPath = _audioPath.isNotEmpty
          ? await _audioService.moveToPermStorage(_audioPath, id)
          : '';
      final topics = extractTopics(_currentText);
      final entry = GratitudeEntry(
        id: id,
        createdAt: DateTime.now(),
        text: _currentText,
        audioPath: permPath.isNotEmpty ? permPath : null,
        audioDurationMs: _durationMs > 0 ? _durationMs : null,
        moodTag: _selectedMood,
        topics: topics,
        isVoiceEntry: permPath.isNotEmpty,
      );
      await _entryRepo.saveEntry(entry);
      await _statsRepo.updateStatsAfterEntry(DateTime.now());
      if (topics.isNotEmpty) {
        await _statsRepo.updateTopTopics(topics);
      }
      final stats = await _statsRepo.getStats();
      final milestone = await _checkMilestone(stats.currentStreak);
      emit(EntrySavedState(milestoneStreak: milestone));
    } catch (e) {
      emit(
        RecordingErrorState(
          'Failed to save entry',
          selectedMood: _selectedMood,
        ),
      );
    }
  }

  Future<int?> _checkMilestone(int streak) async {
    if (!kMilestones.contains(streak)) return null;
    if (_lastCheckedMilestone == streak) return null;
    final settingsBox = await Hive.openBox(kSettingsBox);
    final lastShown =
        settingsBox.get(kLastMilestoneShown, defaultValue: 0) as int;
    if (lastShown >= streak) return null;
    await settingsBox.put(kLastMilestoneShown, streak);
    _lastCheckedMilestone = streak;
    return streak;
  }

  Future<void> _checkMilestoneOnInit() async {
    try {
      final stats = await _statsRepo.getStats();
      await _checkMilestone(stats.currentStreak);
    } catch (_) {}
  }

  void _throttleSttResult(String text) {
    _sttThrottle?.cancel();
    if (_lastEmittedText == text) return;
    _sttThrottle = Timer(_throttleDuration, () {
      _lastEmittedText = text;
      emit(RecordingInProgressState(text, selectedMood: _selectedMood));
    });
  }

  @override
  Future<void> close() {
    _sttThrottle?.cancel();
    _speechService.stopListening();
    _audioService.cancelRecording();
    return super.close();
  }

  void reset() {
    _currentText = '';
    _audioPath = '';
    _durationMs = 0;
    _selectedMood = null;
    emit(RecordingIdleState());
  }
}
