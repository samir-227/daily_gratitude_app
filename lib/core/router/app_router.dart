import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/home/presentation/screens/entry_detail_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../data/models/gratitude_entry.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter appRouter(String initialRoute) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: initialRoute,
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/entry-detail',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final entry = state.extra as GratitudeEntry;
          return EntryDetailScreen(entry: entry);
        },
      ),
    ],
  );
}
