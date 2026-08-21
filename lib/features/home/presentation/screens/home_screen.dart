import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/home_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/widgets/animated_tab_icon.dart';
import '../../../recording/presentation/screens/record_screen.dart';
import '../../../timeline/presentation/screens/timeline_screen.dart';
import '../../../analytics/presentation/screens/analytics_screen.dart';
import '../../../settings/presentation/screens/settings_screen.dart';
import '../widgets/welcome_greeting_card.dart';
import '../widgets/today_status_card.dart';
import '../widgets/record_hero_card.dart';
import '../widgets/stats_row_card.dart';
import '../widgets/recent_entries_carousel.dart';
import '../widgets/reflection_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final CupertinoTabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = CupertinoTabController(initialIndex: 0);
    _tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = CupertinoTheme.of(context).brightness ?? Brightness.dark;
    return CupertinoTabScaffold(
      controller: _tabController,
      tabBar: CupertinoTabBar(
        backgroundColor: AppColors.surface(1, brightness),
        activeColor: AppColors.primary,
        inactiveColor: AppColors.onSurface(brightness, secondary: true),
        border: Border(top: BorderSide(color: AppColors.divider, width: 0.5)),
        height: 56.h,
        items: [
          BottomNavigationBarItem(
            icon: AnimatedTabIcon(
              tabIndex: 0,
              currentIndex: _tabController.index,
              icon: CupertinoIcons.house,
            ),
            label: AppStrings.home,
          ),
          BottomNavigationBarItem(
            icon: AnimatedTabIcon(
              tabIndex: 1,
              currentIndex: _tabController.index,
              icon: CupertinoIcons.mic_fill,
            ),
            label: AppStrings.recordGratitude,
          ),
          BottomNavigationBarItem(
            icon: AnimatedTabIcon(
              tabIndex: 2,
              currentIndex: _tabController.index,
              icon: CupertinoIcons.calendar,
            ),
            label: AppStrings.timeline,
          ),
          BottomNavigationBarItem(
            icon: AnimatedTabIcon(
              tabIndex: 3,
              currentIndex: _tabController.index,
              icon: CupertinoIcons.chart_bar_fill,
            ),
            label: AppStrings.analytics,
          ),
          BottomNavigationBarItem(
            icon: AnimatedTabIcon(
              tabIndex: 4,
              currentIndex: _tabController.index,
              icon: CupertinoIcons.gear,
            ),
            label: AppStrings.settings,
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return HomeDashboardTab(tabController: _tabController);
          case 1:
            return const RecordScreen();
          case 2:
            return const TimelineScreen();
          case 3:
            return const AnalyticsScreen();
          case 4:
            return const SettingsScreen();
          default:
            return HomeDashboardTab(tabController: _tabController);
        }
      },
    );
  }
}

class HomeDashboardTab extends StatelessWidget {
  final CupertinoTabController tabController;

  const HomeDashboardTab({super.key, required this.tabController});

  void _navigateToRecording(BuildContext context) {
    tabController.index = 1;
  }

  @override
  Widget build(BuildContext context) {
    final brightness = CupertinoTheme.of(context).brightness ?? Brightness.dark;
    return CupertinoPageScaffold(
      backgroundColor: AppColors.surface(0, brightness),
      child: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const Center(child: CupertinoActivityIndicator());
            }
            if (state is HomeErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.onSurface(brightness, secondary: true),
                      ),
                    ),
                    SizedBox(height: kSpace16),
                    CupertinoButton(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(AppRadius.standard),
                      onPressed: () => context.read<HomeCubit>().refresh(),
                      child: Text(
                        AppStrings.retry,
                        style: AppTextStyles.titleSmall.copyWith(
                          color: AppColors.textOnPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is HomeLoadedState) {
              void onRecordTap() => _navigateToRecording(context);
              return CustomScrollView(
                slivers: [
                  CupertinoSliverNavigationBar(
                    largeTitle: Text(
                      AppStrings.appTitle,
                      style: AppTextStyles.headline.copyWith(
                        color: AppColors.onSurface(brightness),
                      ),
                    ),
                    backgroundColor: AppColors.surface(0, brightness),
                    border: null,
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: kSpace16),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        SizedBox(height: kSpace4),
                        WelcomeGreetingCard(brightness: brightness),
                        SizedBox(height: kSpace12),
                        TodayStatusCard(
                          stats: state.stats,
                          todayEntry: state.todayEntry,
                          brightness: brightness,
                        ),
                        SizedBox(height: kSpace12),
                        RecordHeroCard(
                          onRecordTap: onRecordTap,
                          brightness: brightness,
                        ),
                        SizedBox(height: kSpace16),
                        StatsRowCard(
                          stats: state.stats,
                          todayEntry: state.todayEntry,
                          brightness: brightness,
                        ),
                        SizedBox(height: kSpace16),
                        RecentEntriesCarousel(
                          entries: state.recentEntries,
                          onRecordTap: onRecordTap,
                          brightness: brightness,
                        ),
                        SizedBox(height: kSpace16),
                        ReflectionCard(
                          onRecordTap: onRecordTap,
                          brightness: brightness,
                          allEntries: state.allEntries,
                        ),
                        SizedBox(height: kSpace20),
                      ]),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
