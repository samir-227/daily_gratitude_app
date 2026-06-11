import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/repositories/stats_repository.dart';
import '../../../../data/repositories/entry_repository.dart';
import '../../../../data/models/user_stats.dart';
import '../../../../data/models/gratitude_entry.dart';

abstract class HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final UserStats stats;
  final GratitudeEntry? todayEntry;
  final List<GratitudeEntry> recentEntries;

  HomeLoadedState({
    required this.stats,
    this.todayEntry,
    required this.recentEntries,
  });
}

class HomeErrorState extends HomeState {
  final String message;
  HomeErrorState(this.message);
}

class HomeCubit extends Cubit<HomeState> {
  final StatsRepository _statsRepo;
  final EntryRepository _entryRepo;

  HomeCubit(this._statsRepo, this._entryRepo) : super(HomeLoadingState());

  Future<void> loadHome() async {
    emit(HomeLoadingState());
    try {
      final stats = await _statsRepo.getStats();
      final todayEntry = await _getTodayEntry();
      final recentEntries = await _entryRepo.getAllEntries();
      emit(
        HomeLoadedState(
          stats: stats,
          todayEntry: todayEntry,
          recentEntries: recentEntries.take(3).toList(),
        ),
      );
    } catch (e) {
      emit(HomeErrorState('Failed to load home data'));
    }
  }

  Future<void> refresh() async {
    await loadHome();
  }

  Future<GratitudeEntry?> _getTodayEntry() async {
    final entries = await _entryRepo.getEntriesByDate(DateTime.now());
    return entries.isNotEmpty ? entries.first : null;
  }
}
