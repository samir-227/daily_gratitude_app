import 'package:hive_flutter/hive_flutter.dart';
import '../../core/constants/app_constants.dart';
import '../models/gratitude_entry.dart';

class EntryRepository {
  Box<GratitudeEntry>? _box;

  Future<Box<GratitudeEntry>> get _entriesBox async {
    _box ??= await Hive.openBox<GratitudeEntry>(kEntriesBox);
    return _box!;
  }

  Future<void> saveEntry(GratitudeEntry entry) async {
    final box = await _entriesBox;
    await box.put(entry.id, entry);
  }

  Future<List<GratitudeEntry>> getAllEntries() async {
    final box = await _entriesBox;
    final entries = box.values.toList();
    entries.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return entries;
  }

  Future<List<GratitudeEntry>> getEntriesPage({
    required int page,
    int pageSize = 20,
  }) async {
    final box = await _entriesBox;
    final all = box.values.toList();
    all.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    final start = page * pageSize;
    if (start >= all.length) return [];
    final end = (start + pageSize).clamp(0, all.length);
    return all.sublist(start, end);
  }

  Future<List<GratitudeEntry>> getEntriesByDate(DateTime date) async {
    final box = await _entriesBox;
    return box.values.where((e) {
      return e.createdAt.year == date.year &&
          e.createdAt.month == date.month &&
          e.createdAt.day == date.day;
    }).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<GratitudeEntry?> getEntryById(String id) async {
    final box = await _entriesBox;
    return box.get(id);
  }

  Future<void> updateEntry(GratitudeEntry entry) async {
    final box = await _entriesBox;
    await box.put(entry.id, entry);
  }

  Future<void> deleteEntry(String id) async {
    final box = await _entriesBox;
    await box.delete(id);
    final settingsBox = await Hive.openBox(kSettingsBox);
    final count = (settingsBox.get(kDeletionsSinceCompaction, defaultValue: 0) as int) + 1;
    await settingsBox.put(kDeletionsSinceCompaction, count);
  }

  Future<bool> hasEntryToday() async {
    final now = DateTime.now();
    final entries = await getEntriesByDate(now);
    return entries.isNotEmpty;
  }

  Future<void> clearAll() async {
    final box = await _entriesBox;
    await box.clear();
  }
}
