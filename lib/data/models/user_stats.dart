import 'package:hive/hive.dart';

class UserStats extends HiveObject {
  int currentStreak;
  int longestStreak;
  int totalEntries;
  DateTime? lastEntryDate;
  Map<String, int> topTopics;

  UserStats({
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.totalEntries = 0,
    this.lastEntryDate,
    Map<String, int>? topTopics,
  }) : topTopics = topTopics ?? {};
}

class UserStatsAdapter extends TypeAdapter<UserStats> {
  @override
  final int typeId = 1;

  @override
  UserStats read(BinaryReader reader) {
    return UserStats(
      currentStreak: reader.readInt(),
      longestStreak: reader.readInt(),
      totalEntries: reader.readInt(),
      lastEntryDate: reader.readBool() ? DateTime.fromMillisecondsSinceEpoch(reader.readInt()) : null,
      topTopics: reader.readMap().cast<String, int>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserStats obj) {
    writer.writeInt(obj.currentStreak);
    writer.writeInt(obj.longestStreak);
    writer.writeInt(obj.totalEntries);
    writer.writeBool(obj.lastEntryDate != null);
    if (obj.lastEntryDate != null) writer.writeInt(obj.lastEntryDate!.millisecondsSinceEpoch);
    writer.writeMap(obj.topTopics);
  }
}
