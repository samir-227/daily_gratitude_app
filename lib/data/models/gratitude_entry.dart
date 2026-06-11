import 'package:hive/hive.dart';

class GratitudeEntry extends HiveObject {
  String id;
  DateTime createdAt;
  String text;
  String? audioPath;
  int? audioDurationMs;
  String? moodTag;
  List<String> topics;
  bool isVoiceEntry;

  GratitudeEntry({
    required this.id,
    required this.createdAt,
    required this.text,
    this.audioPath,
    this.audioDurationMs,
    this.moodTag,
    required this.topics,
    required this.isVoiceEntry,
  });
}

class GratitudeEntryAdapter extends TypeAdapter<GratitudeEntry> {
  @override
  final int typeId = 0;

  @override
  GratitudeEntry read(BinaryReader reader) {
    return GratitudeEntry(
      id: reader.readString(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
      text: reader.readString(),
      audioPath: reader.readBool() ? reader.readString() : null,
      audioDurationMs: reader.readBool() ? reader.readInt() : null,
      moodTag: reader.readBool() ? reader.readString() : null,
      topics: reader.readStringList().cast<String>(),
      isVoiceEntry: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, GratitudeEntry obj) {
    writer.writeString(obj.id);
    writer.writeInt(obj.createdAt.millisecondsSinceEpoch);
    writer.writeString(obj.text);
    writer.writeBool(obj.audioPath != null);
    if (obj.audioPath != null) writer.writeString(obj.audioPath!);
    writer.writeBool(obj.audioDurationMs != null);
    if (obj.audioDurationMs != null) writer.writeInt(obj.audioDurationMs!);
    writer.writeBool(obj.moodTag != null);
    if (obj.moodTag != null) writer.writeString(obj.moodTag!);
    writer.writeStringList(obj.topics);
    writer.writeBool(obj.isVoiceEntry);
  }
}
