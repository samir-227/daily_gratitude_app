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
  final bool isLoadingMore;
  final bool hasMore;

  TimelineLoadedState({
    required this.groupedEntries,
    this.filter = TimelineFilter.all,
    this.playingEntryId,
    this.searchQuery = '',
    this.audioErrorMessage,
    this.isLoadingMore = false,
    this.hasMore = true,
  });

  TimelineLoadedState copyWith({
    Map<String, List<GratitudeEntry>>? groupedEntries,
    TimelineFilter? filter,
    String? playingEntryId,
    String? searchQuery,
    String? audioErrorMessage,
    bool? isLoadingMore,
    bool? hasMore,
  }) {
    return TimelineLoadedState(
      groupedEntries: groupedEntries ?? this.groupedEntries,
      filter: filter ?? this.filter,
      playingEntryId: playingEntryId ?? this.playingEntryId,
      searchQuery: searchQuery ?? this.searchQuery,
      audioErrorMessage: audioErrorMessage ?? this.audioErrorMessage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class TimelineErrorState extends TimelineState {
  final String message;
  TimelineErrorState(this.message);
}
