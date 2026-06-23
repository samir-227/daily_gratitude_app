import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/repositories/stats_repository.dart';
import '../../../../data/repositories/entry_repository.dart';
import '../../../../data/models/user_stats.dart';
import '../../../../data/models/gratitude_entry.dart';

abstract class AnalyticsState {}

class AnalyticsLoadingState extends AnalyticsState {}

class AnalyticsLoadedState extends AnalyticsState {
  final UserStats stats;
  final Map<DateTime, int> weekActivity;
  final Map<String, int> topTopics;
  final Map<String, int> moodDistribution;
  AnalyticsLoadedState({
    required this.stats,
    required this.weekActivity,
    required this.topTopics,
    required this.moodDistribution,
  });
}

class AnalyticsErrorState extends AnalyticsState {
  final String message;
  AnalyticsErrorState(this.message);
}

class AnalyticsCubit extends Cubit<AnalyticsState> {
  final StatsRepository _statsRepo;
  final EntryRepository _entryRepo;

  int _lastEntryCount = -1;
  AnalyticsLoadedState? _cachedState;

  AnalyticsCubit(this._statsRepo, this._entryRepo) : super(AnalyticsLoadingState());

  Future<void> loadAnalytics() async {
    try {
      final entries = await _entryRepo.getAllEntries();
      if (_cachedState != null && entries.length == _lastEntryCount) {
        emit(_cachedState!);
        return;
      }
      emit(AnalyticsLoadingState());
      final stats = await _statsRepo.getStats();
      final weekActivity = _calculateWeekActivity(entries);
      final topTopics = _getTopTopics(stats);
      final moodDistribution = _calculateMoodDistribution(entries);
      _lastEntryCount = entries.length;
      _cachedState = AnalyticsLoadedState(
        stats: stats,
        weekActivity: weekActivity,
        moodDistribution: moodDistribution,
        topTopics: topTopics,
      );
      emit(_cachedState!);
    } catch (e) {
      emit(AnalyticsErrorState('Failed to load analytics'));
    }
  }

  Map<DateTime, int> _calculateWeekActivity(List<GratitudeEntry> entries) {
    final now = DateTime.now();
    final result = <DateTime, int>{};
    for (int i = 6; i >= 0; i--) {
      final day = DateTime(now.year, now.month, now.day - i);
      result[day] = 0;
    }
    for (final entry in entries) {
      final day = DateTime(entry.createdAt.year, entry.createdAt.month, entry.createdAt.day);
      if (result.containsKey(day)) {
        result[day] = (result[day] ?? 0) + 1;
      }
    }
    return result;
  }

  Map<String, int> _getTopTopics(UserStats stats) {
    final sorted = stats.topTopics.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return Map.fromEntries(sorted.take(5));
  }

  Map<String, int> _calculateMoodDistribution(List<GratitudeEntry> entries) {
    final distribution = <String, int>{};
    for (final entry in entries) {
      if (entry.moodTag != null) {
        distribution[entry.moodTag!] = (distribution[entry.moodTag!] ?? 0) + 1;
      }
    }
    return distribution;
  }
}
