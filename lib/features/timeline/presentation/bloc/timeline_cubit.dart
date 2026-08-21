import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/repositories/entry_repository.dart';
import '../../../../core/services/audio_service.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../data/models/gratitude_entry.dart';
import 'timeline_state.dart';

class TimelineCubit extends Cubit<TimelineState> {
  final EntryRepository _entryRepo;
  final AudioService _audioService;
  final _diacritics = [
    '\u{064B}', '\u{064C}', '\u{064D}', '\u{064E}', '\u{064F}',
    '\u{0650}', '\u{0651}', '\u{0652}',
  ];

  List<GratitudeEntry> _allEntries = [];
  String _searchQuery = '';
  TimelineFilter _currentFilter = TimelineFilter.all;
  Timer? _searchDebounce;
  int _currentPage = 0;
  bool _hasMore = true;
  static const int _pageSize = 20;

  TimelineCubit(this._entryRepo, this._audioService) : super(TimelineLoadingState());

  Future<void> loadEntries({TimelineFilter? filter}) async {
    emit(TimelineLoadingState());
    try {
      _currentPage = 0;
      _allEntries = await _entryRepo.getEntriesPage(page: 0, pageSize: _pageSize);
      _hasMore = _allEntries.length >= _pageSize;
      if (isClosed) return;
      if (filter != null) _currentFilter = filter;
      _applyFilters();
    } catch (e) {
      if (isClosed) return;
      emit(TimelineErrorState(AppStrings.errorFailedToLoadEntries));
    }
  }

  Future<void> loadMore() async {
    if (!_hasMore) return;
    final current = state;
    if (current is! TimelineLoadedState) return;
    if (current.isLoadingMore) return;
    emit(current.copyWith(isLoadingMore: true));
    try {
      _currentPage++;
      final more = await _entryRepo.getEntriesPage(page: _currentPage, pageSize: _pageSize);
      if (isClosed) return;
      if (more.isEmpty) {
        _hasMore = false;
      } else {
        _allEntries.addAll(more);
        _hasMore = more.length >= _pageSize;
      }
      _applyFilters();
    } catch (e) {
      if (isClosed) return;
      _applyFilters();
    }
  }

  void setFilter(TimelineFilter filter) {
    _currentFilter = filter;
    _searchDebounce?.cancel();
    _applyFilters();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 400), _applyFilters);
  }

  Future<void> playEntry(GratitudeEntry entry) async {
    if (entry.audioPath == null) return;
    final current = state;
    if (current is TimelineLoadedState) {
      if (current.playingEntryId == entry.id) {
        await _audioService.stopAudio();
        if (isClosed) return;
        emit(current.copyWith(playingEntryId: null));
      } else {
        await _audioService.stopAudio();
        final started = await _audioService.playAudio(entry.audioPath!);
        if (isClosed) return;
        if (!started) {
          emit(current.copyWith(
            playingEntryId: null,
            audioErrorMessage: AppStrings.audioFileNotFound,
          ));
          return;
        }
        emit(current.copyWith(playingEntryId: entry.id));
      }
    }
  }

  Future<void> deleteEntry(String id) async {
    try {
      await _entryRepo.deleteEntry(id);
      if (isClosed) return;
      await loadEntries(filter: _currentFilter);
    } catch (e) {
      if (isClosed) return;
      emit(TimelineErrorState(AppStrings.errorFailedToDeleteEntry));
    }
  }

  Future<void> updateEntry(String id, String newText) async {
    try {
      final entry = await _entryRepo.getEntryById(id);
      if (isClosed) return;
      if (entry == null) return;
      final updated = GratitudeEntry(
        id: entry.id,
        createdAt: entry.createdAt,
        text: newText,
        audioPath: entry.audioPath,
        audioDurationMs: entry.audioDurationMs,
        moodTag: entry.moodTag,
        topics: entry.topics,
        isVoiceEntry: entry.isVoiceEntry,
      );
      await _entryRepo.updateEntry(updated);
      if (isClosed) return;
      await loadEntries(filter: _currentFilter);
    } catch (e) {
      if (isClosed) return;
      emit(TimelineErrorState(AppStrings.errorFailedToUpdateEntry));
    }
  }

  Future<void> refresh() async {
    try {
      _currentPage = 0;
      _allEntries = await _entryRepo.getEntriesPage(page: 0, pageSize: _pageSize);
      _hasMore = _allEntries.length >= _pageSize;
      if (isClosed) return;
      _applyFilters();
    } catch (e) {
      if (isClosed) return;
    }
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }

  void _applyFilters() {
    if (isClosed) return;
    var entries = List<GratitudeEntry>.from(_allEntries);

    if (_currentFilter == TimelineFilter.thisWeek) {
      final weekAgo = DateTime.now().subtract(const Duration(days: 7));
      entries = entries.where((e) => e.createdAt.isAfter(weekAgo)).toList();
    } else if (_currentFilter == TimelineFilter.thisMonth) {
      final now = DateTime.now();
      entries = entries
          .where((e) => e.createdAt.month == now.month && e.createdAt.year == now.year)
          .toList();
    }

    if (_searchQuery.isNotEmpty) {
      final query = _normalizeText(_searchQuery);
      entries = entries.where((e) {
        final text = _normalizeText(e.text);
        return text.contains(query);
      }).toList();
    }

    final grouped = _groupEntries(entries);

    emit(TimelineLoadedState(
      groupedEntries: grouped,
      filter: _currentFilter,
      playingEntryId: _getPlayingId(),
      searchQuery: _searchQuery,
      audioErrorMessage: null,
      isLoadingMore: false,
      hasMore: _hasMore,
    ));
  }

  Map<String, List<GratitudeEntry>> _groupEntries(List<GratitudeEntry> entries) {
    final Map<String, List<GratitudeEntry>> grouped = {};
    for (final entry in entries) {
      final header = _formatDateHeader(entry.createdAt);
      grouped.putIfAbsent(header, () => []);
      grouped[header]!.add(entry);
    }
    return grouped;
  }

  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final entryDate = DateTime(date.year, date.month, date.day);
    final diff = today.difference(entryDate).inDays;

    if (diff == 0) return AppStrings.today;
    if (diff == 1) return AppStrings.yesterday;

    const weekdays = [
      'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت', 'الأحد',
    ];
    const months = [
      'يناير', 'فبراير', 'مارس', 'إبريل', 'مايو', 'يونيو',
      'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر',
    ];
    return '${weekdays[date.weekday - 1]}، ${date.day} ${months[date.month - 1]}';
  }

  String _normalizeText(String text) {
    for (final d in _diacritics) {
      text = text.replaceAll(d, '');
    }
    return text.toLowerCase();
  }

  String? _getPlayingId() {
    final s = state;
    if (s is TimelineLoadedState) return s.playingEntryId;
    return null;
  }
}
