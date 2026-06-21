import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../bloc/home_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/widgets/staggered_fade_in.dart';
import '../../../../core/widgets/animated_tab_icon.dart';
import '../../../recording/presentation/screens/record_screen.dart';
import '../../../timeline/presentation/screens/timeline_screen.dart';
import '../../../analytics/presentation/screens/analytics_screen.dart';
import '../../../settings/presentation/screens/settings_screen.dart';
import '../../../../data/models/gratitude_entry.dart';
import '../../../../data/models/user_stats.dart';

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
            return const HomeDashboardTab();
          case 1:
            return const RecordScreen();
          case 2:
            return const TimelineScreen();
          case 3:
            return const AnalyticsScreen();
          case 4:
            return const SettingsScreen();
          default:
            return const HomeDashboardTab();
        }
      },
    );
  }
}

class HomeDashboardTab extends StatelessWidget {
  const HomeDashboardTab({super.key});

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
                        _buildWelcomeGreeting(brightness),
                        SizedBox(height: kSpace12),
                        _buildTodayStatus(
                          state.stats,
                          state.todayEntry,
                          brightness,
                        ),
                        SizedBox(height: kSpace12),
                        _buildRecordHero(context, brightness),
                        SizedBox(height: kSpace16),
                        _buildStatsRow(state, brightness),
                        SizedBox(height: kSpace16),
                        _buildRecentEntries(
                          context,
                          state.recentEntries,
                          brightness,
                        ),
                        SizedBox(height: kSpace16),
                        _buildReflectionCard(context, brightness),
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

  static Widget _buildWelcomeGreeting(Brightness brightness) {
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? AppStrings.morningGreeting
        : hour < 18
        ? AppStrings.afternoonGreeting
        : AppStrings.eveningGreeting;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(kSpace16, kSpace12, kSpace16, kSpace12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            AppColors.surface(1, brightness),
            AppColors.surface(2, brightness),
          ],
        ),
        borderRadius: BorderRadius.circular(AppRadius.generous),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            greeting,
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.onSurface(brightness),
            ),
          ),
          SizedBox(height: kSpace4),
          Text(
            AppStrings.greetingSubtext,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.onSurface(brightness, secondary: true),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildTodayStatus(
    UserStats stats,
    GratitudeEntry? todayEntry,
    Brightness brightness,
  ) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(
              kSpace12,
              kSpace10,
              kSpace12,
              kSpace10,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface(2, brightness),
              borderRadius: BorderRadius.circular(AppRadius.standard),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${stats.totalEntries}',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  AppStrings.entries,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.onSurface(brightness, secondary: true),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: kSpace10),
        Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(
              kSpace12,
              kSpace10,
              kSpace12,
              kSpace10,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface(2, brightness),
              borderRadius: BorderRadius.circular(AppRadius.standard),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${stats.currentStreak}',
                  style: AppTextStyles.titleSmall.copyWith(
                    color: AppColors.streakFire,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  AppStrings.dayStreak,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.onSurface(brightness, secondary: true),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildRecordHero(BuildContext context, Brightness brightness) {
    return Container(
      width: double.infinity,
      height: 120.h,
      padding: EdgeInsets.fromLTRB(kSpace16, kSpace12, kSpace16, kSpace12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.primaryDark.withValues(alpha: 0.85),
          ],
        ),
        borderRadius: BorderRadius.circular(AppRadius.generous),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.25),
            blurRadius: 20.r,
            offset: Offset(0, 10.h),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: 0,
            top: 0,
            left: 66.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.recordPrompt,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: AppColors.textOnPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: kSpace6),
                Text(
                  AppStrings.recordDescription,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textOnPrimary.withValues(alpha: 0.85),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            top: 8.h,
            width: 60.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _BreathingRecordButton(
                  onTap: () => _navigateToRecording(context),
                ),
                SizedBox(height: kSpace4),
                Text(
                  AppStrings.tapToRecordAction,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.textOnPrimary.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static void _navigateToRecording(BuildContext context) {
    final parentState = context.findAncestorStateOfType<_HomeScreenState>();
    parentState?._tabController.index = 1;
  }

  static Widget _buildStatsRow(HomeLoadedState state, Brightness brightness) {
    return Row(
      children: [
        _buildMiniCard(
          icon: CupertinoIcons.heart_fill,
          iconColor: AppColors.accent,
          title: 'حاسس بإيه النهاردة؟',
          subtitle: state.stats.currentStreak > 3 ? 'أقرب ليك' : 'سجل يومياتك',
          brightness: brightness,
        ),
        SizedBox(width: kSpace10),
        _buildMiniCard(
          icon: CupertinoIcons.checkmark_circle_fill,
          iconColor: state.todayEntry != null
              ? AppColors.success
              : AppColors.textTertiary,
          title: AppStrings.today,
          subtitle: state.todayEntry != null
              ? 'تمام، سجّلت النهاردة!'
              : AppStrings.noEntryToday,
          brightness: brightness,
        ),
      ],
    );
  }

  static Widget _buildMiniCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Brightness brightness,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.fromLTRB(kSpace12, kSpace10, kSpace12, kSpace10),
        decoration: BoxDecoration(
          color: AppColors.surface(2, brightness),
          borderRadius: BorderRadius.circular(AppRadius.standard),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 16.w, color: iconColor),
            SizedBox(height: kSpace6),
            Text(
              title,
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.onSurface(brightness, secondary: true),
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              subtitle,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.onSurface(brightness),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildRecentEntries(
    BuildContext context,
    List<GratitudeEntry> entries,
    Brightness brightness,
  ) {
    if (entries.isEmpty) {
      return _buildEmptyState(context, brightness);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: kSpace4, bottom: kSpace8),
          child: Text(
            AppStrings.recentEntries,
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.onSurface(brightness),
            ),
          ),
        ),
        SizedBox(
          height: 130.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: entries.length,
            separatorBuilder: (_, _) => SizedBox(width: kSpace10),
            itemBuilder: (context, index) {
              final entry = entries[index];
              return StaggeredFadeIn(
                index: index,
                child: _buildEntryCard(context, entry, brightness),
              );
            },
          ),
        ),
      ],
    );
  }

  static Widget _buildEntryCard(
    BuildContext context,
    GratitudeEntry entry,
    Brightness brightness,
  ) {
    final moodColors = {
      'grateful': AppColors.emotionJoy,
      'happy': AppColors.emotionHope,
      'calm': AppColors.emotionPeace,
      'loved': AppColors.emotionLoved,
      'reflective': AppColors.emotionLoved,
      'grounded': AppColors.emotionGrounded,
    };
    final moodColor = moodColors[entry.moodTag] ?? AppColors.primary;
    return GestureDetector(
      onTap: () => context.push('/entry-detail', extra: entry),
      child: Container(
        width: 180.w,
        padding: EdgeInsets.all(kSpace12),
        decoration: BoxDecoration(
          color: AppColors.surface(1, brightness),
          borderRadius: BorderRadius.circular(AppRadius.generous),
          border: Border.all(color: AppColors.surface(2, brightness)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: kSpace8,
                    vertical: kSpace4,
                  ),
                  decoration: BoxDecoration(
                    color: moodColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(
                    AppStrings.moodLabel(entry.moodTag),
                    style: AppTextStyles.labelSmall.copyWith(
                      color: moodColor,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: kSpace8),
            Expanded(
              child: Text(
                entry.text,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.onSurface(brightness),
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(height: kSpace6),
            Text(
              '${entry.createdAt.day}/${entry.createdAt.month}',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.onSurface(brightness, tertiary: true),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildReflectionCard(
    BuildContext context,
    Brightness brightness,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(kSpace16, kSpace12, kSpace16, kSpace12),
      decoration: BoxDecoration(
        color: AppColors.surface(2, brightness),
        borderRadius: BorderRadius.circular(AppRadius.generous),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.reflectionTitle,
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.onSurface(brightness),
            ),
          ),
          SizedBox(height: kSpace6),
          Text(
            AppStrings.reflectionText,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.onSurface(brightness, secondary: true),
              height: 1.5,
            ),
          ),
          SizedBox(height: kSpace12),
          SizedBox(
            width: double.infinity,
            height: 40.h,
            child: CupertinoButton(
              borderRadius: BorderRadius.circular(AppRadius.standard),
              color: AppColors.secondary,
              padding: EdgeInsets.zero,
              onPressed: () => _navigateToRecording(context),
              child: Text(
                AppStrings.startGratitude,
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.textOnPrimaryLight,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildEmptyState(BuildContext context, Brightness brightness) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(kSpace16, kSpace16, kSpace16, kSpace12),
        decoration: BoxDecoration(
          color: AppColors.surface(1, brightness),
          borderRadius: BorderRadius.circular(AppRadius.generous),
        ),
        child: Column(
          children: [
            Text(
              AppStrings.noEntriesYet,
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.onSurface(brightness),
              ),
            ),
            SizedBox(height: kSpace6),
            Text(
              AppStrings.noEntriesSubtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.onSurface(brightness, secondary: true),
                height: 1.5,
              ),
            ),
            SizedBox(height: kSpace12),
            SizedBox(
              width: double.infinity,
              height: 36.h,
              child: CupertinoButton(
                borderRadius: BorderRadius.circular(AppRadius.standard),
                padding: EdgeInsets.zero,
                onPressed: () => _navigateToRecording(context),
                child: Text(
                  AppStrings.recordNow,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BreathingRecordButton extends StatefulWidget {
  final VoidCallback onTap;
  const _BreathingRecordButton({required this.onTap});

  @override
  State<_BreathingRecordButton> createState() => _BreathingRecordButtonState();
}

class _BreathingRecordButtonState extends State<_BreathingRecordButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _scale = Tween<double>(begin: 1.0, end: 1.06).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
    _glow = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scale.value,
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.textOnPrimary.withValues(alpha: 0.95),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.textOnPrimary.withValues(
                      alpha: 0.15 * _glow.value,
                    ),
                    blurRadius: (12 + 8 * _glow.value).r,
                    offset: Offset(0, 4.h),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  CupertinoIcons.mic_fill,
                  size: 20.w,
                  color: AppColors.surface0,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
