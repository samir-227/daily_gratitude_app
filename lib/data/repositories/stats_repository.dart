import 'package:hive_flutter/hive_flutter.dart';
import '../../core/constants/app_constants.dart';
import '../models/user_stats.dart';

class StatsRepository {
  Box<UserStats>? _box;

  Future<Box<UserStats>> get _statsBox async {
    _box ??= await Hive.openBox<UserStats>(kStatsBox);
    return _box!;
  }

  Future<UserStats> getStats() async {
    final box = await _statsBox;
    return box.get('stats') ?? UserStats();
  }

  Future<void> saveStats(UserStats stats) async {
    final box = await _statsBox;
    await box.put('stats', stats);
  }

  Future<void> updateStatsAfterEntry(DateTime entryDate) async {
    final stats = await getStats();
    final entryDay = DateTime(entryDate.year, entryDate.month, entryDate.day);

    if (stats.lastEntryDate == null) {
      stats.currentStreak = 1;
    } else {
      final lastDay = DateTime(
        stats.lastEntryDate!.year,
        stats.lastEntryDate!.month,
        stats.lastEntryDate!.day,
      );
      final diff = entryDay.difference(lastDay).inDays;

      if (diff == 0) {
        // same day, no streak change
      } else if (diff == 1) {
        stats.currentStreak += 1;
      } else {
        stats.currentStreak = 1;
      }
    }

    if (stats.currentStreak > stats.longestStreak) {
      stats.longestStreak = stats.currentStreak;
    }

    stats.totalEntries += 1;
    stats.lastEntryDate = entryDate;
    await saveStats(stats);
  }

  Future<void> updateTopTopics(List<String> newTopics) async {
    final stats = await getStats();
    for (final topic in newTopics) {
      stats.topTopics[topic] = (stats.topTopics[topic] ?? 0) + 1;
    }
    await saveStats(stats);
  }

  Future<void> resetStats() async {
    final box = await _statsBox;
    await box.clear();
  }
}
