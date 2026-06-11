import 'package:get_it/get_it.dart';
import '../services/speech_service.dart';
import '../services/audio_service.dart';
import '../services/notification_service.dart';
import '../../data/repositories/entry_repository.dart';
import '../../data/repositories/stats_repository.dart';
import '../../features/onboarding/presentation/bloc/onboarding_cubit.dart';
import '../../features/home/presentation/bloc/home_cubit.dart';
import '../../features/recording/presentation/bloc/recording_cubit.dart';
import '../../features/timeline/presentation/bloc/timeline_cubit.dart';
import '../../features/analytics/presentation/bloc/analytics_cubit.dart';
import '../../features/settings/presentation/bloc/settings_cubit.dart';
import '../../features/settings/presentation/bloc/theme_cubit.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {
  sl.registerLazySingleton<SpeechService>(() => SpeechService());
  sl.registerLazySingleton<AudioService>(() => AudioService());
  sl.registerLazySingleton<NotificationService>(() => NotificationService());
  sl.registerLazySingleton<EntryRepository>(() => EntryRepository());
  sl.registerLazySingleton<StatsRepository>(() => StatsRepository());

  sl.registerFactory<OnboardingCubit>(() => OnboardingCubit());
  sl.registerFactory<HomeCubit>(() => HomeCubit(
    sl<StatsRepository>(),
    sl<EntryRepository>(),
  ));
  sl.registerFactory<RecordingCubit>(() => RecordingCubit(
    sl<SpeechService>(),
    sl<AudioService>(),
    sl<EntryRepository>(),
    sl<StatsRepository>(),
  ));
  sl.registerLazySingleton<TimelineCubit>(() => TimelineCubit(
    sl<EntryRepository>(),
    sl<AudioService>(),
  ));
  sl.registerFactory<AnalyticsCubit>(() => AnalyticsCubit(
    sl<StatsRepository>(),
    sl<EntryRepository>(),
  ));
  sl.registerFactory<ThemeCubit>(() => ThemeCubit());
  sl.registerFactory<SettingsCubit>(() => SettingsCubit(
    sl<StatsRepository>(),
    sl<EntryRepository>(),
    sl<NotificationService>(),
    sl<SpeechService>(),
    sl<AudioService>(),
  ));
}
