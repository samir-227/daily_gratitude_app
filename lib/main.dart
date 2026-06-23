import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/constants/app_constants.dart';
import 'core/constants/app_theme.dart';
import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'data/models/gratitude_entry.dart';
import 'data/models/user_stats.dart';
import 'features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'features/home/presentation/bloc/home_cubit.dart';
import 'features/recording/presentation/bloc/recording_cubit.dart';
import 'features/timeline/presentation/bloc/timeline_cubit.dart';
import 'features/analytics/presentation/bloc/analytics_cubit.dart';
import 'features/settings/presentation/bloc/settings_cubit.dart';
import 'features/settings/presentation/bloc/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(GratitudeEntryAdapter());
  Hive.registerAdapter(UserStatsAdapter());
  await Hive.openBox<GratitudeEntry>(kEntriesBox);
  await Hive.openBox<UserStats>(kStatsBox);
  await Hive.openBox(kSettingsBox);
  await setupDependencies();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = appRouter();

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<ThemeCubit>()..loadTheme()),
            BlocProvider(create: (_) => sl<OnboardingCubit>()),
            BlocProvider(create: (_) {
              final cubit = sl<HomeCubit>();
              cubit.loadHome();
              return cubit;
            }),
            BlocProvider(create: (_) => sl<RecordingCubit>()),
            BlocProvider(create: (_) {
              final cubit = sl<TimelineCubit>();
              cubit.loadEntries();
              return cubit;
            }),
            BlocProvider(create: (_) {
              final cubit = sl<AnalyticsCubit>();
              cubit.loadAnalytics();
              return cubit;
            }),
            BlocProvider(create: (_) {
              final cubit = sl<SettingsCubit>();
              cubit.loadSettings();
              return cubit;
            }),
          ],
          child: BlocBuilder<ThemeCubit, Brightness>(
            builder: (context, brightness) {
              return CupertinoApp.router(
                debugShowCheckedModeBanner: false,
                locale: const Locale('ar'),
                supportedLocales: const [Locale('ar')],
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                routerConfig: router,
                title: kAppName,
                theme: brightness == Brightness.dark ? AppTheme.dark : AppTheme.light,
                builder: (context, child) =>
                    Directionality(textDirection: TextDirection.rtl, child: child!),
              );
            },
          ),
        );
      },
    );
  }
}
