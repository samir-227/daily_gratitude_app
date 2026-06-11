import '../../../../data/models/gratitude_entry.dart';

enum TimelineFilter { all, thisWeek, thisMonth }

abstract class TimelineState {}

class TimelineLoadingState extends TimelineState {}

class TimelineLoadedState extends TimelineState {
  final Map<String, List<GratitudeEntry>> groupedEntries;
  final TimelineFilter filter;
  final String? playingEntryId;
  final String searchQuery;
  final String? audioErrorMessage;

  TimelineLoadedState({
    required this.groupedEntries,
    this.filter = TimelineFilter.all,
    this.playingEntryId,
    this.searchQuery = '',
    this.audioErrorMessage,
  });
}

class TimelineErrorState extends TimelineState {
  final String message;
  TimelineErrorState(this.message);
}
