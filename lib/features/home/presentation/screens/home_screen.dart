import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../bloc/home_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_theme.dart';
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
  }

  @override
  void dispose() {
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house, size: 24),
            label: AppStrings.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.mic_fill, size: 24),
            label: AppStrings.recordGratitude,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.calendar, size: 24),
            label: AppStrings.timeline,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chart_bar_fill, size: 24),
            label: AppStrings.analytics,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.gear, size: 24),
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
                    Text(state.message,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.onSurface(brightness, secondary: true))),
                    SizedBox(height: kSpace16),
                    CupertinoButton(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(AppRadius.standard),
                      onPressed: () => context.read<HomeCubit>().refresh(),
                      child: Text(AppStrings.retry,
                        style: AppTextStyles.titleSmall.copyWith(color: CupertinoColors.white)),
                    ),
                  ],
                ),
              );
            }
            if (state is HomeLoadedState) {
              return CustomScrollView(
                slivers: [
                  CupertinoSliverNavigationBar(
                    largeTitle: Text(AppStrings.appTitle,
                      style: AppTextStyles.headline.copyWith(color: AppColors.onSurface(brightness))),
                    backgroundColor: AppColors.surface(0, brightness),
                    border: null,
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: kSpace16),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        SizedBox(height: kSpace8),
                        _buildWelcomeGreeting(brightness),
                        SizedBox(height: kSpace20),
                        _buildTodayStatus(state.stats, state.todayEntry, brightness),
                        SizedBox(height: kSpace20),
                        _buildRecordHero(context, brightness),
                        SizedBox(height: kSpace24),
                        _buildStatsRow(state, brightness),
                        SizedBox(height: kSpace24),
                        _buildRecentEntries(context, state.recentEntries, brightness),
                        SizedBox(height: kSpace24),
                        _buildReflectionCard(context, brightness),
                        SizedBox(height: kSpace32),
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
      padding: EdgeInsets.all(kSpace20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [AppColors.surface(1, brightness), AppColors.surface(2, brightness)],
        ),
        borderRadius: BorderRadius.circular(AppRadius.generous),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(greeting,
            style: AppTextStyles.titleLarge.copyWith(color: AppColors.onSurface(brightness))),
          SizedBox(height: kSpace8),
          Text(AppStrings.greetingSubtext,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onSurface(brightness, secondary: true), height: 1.6)),
        ],
      ),
    );
  }

  static Widget _buildTodayStatus(UserStats stats, GratitudeEntry? todayEntry, Brightness brightness) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(kSpace16),
            decoration: BoxDecoration(
              color: AppColors.surface(2, brightness),
              borderRadius: BorderRadius.circular(AppRadius.standard),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${stats.totalEntries}',
                  style: AppTextStyles.titleLarge.copyWith(
                    color: AppColors.primary, fontWeight: FontWeight.bold)),
                SizedBox(height: kSpace4),
                Text(AppStrings.entries,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.onSurface(brightness, secondary: true))),
              ],
            ),
          ),
        ),
        SizedBox(width: kSpace12),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(kSpace16),
            decoration: BoxDecoration(
              color: AppColors.surface(2, brightness),
              borderRadius: BorderRadius.circular(AppRadius.standard),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(CupertinoIcons.flame_fill,
                      size: kSpace20, color: AppColors.streakFire),
                    SizedBox(width: kSpace8),
                    Text('${stats.currentStreak}',
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.streakFire, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: kSpace4),
                Text(AppStrings.dayStreak,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.onSurface(brightness, secondary: true))),
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
      padding: EdgeInsets.all(kSpace24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
        borderRadius: BorderRadius.circular(AppRadius.generous),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: const BoxDecoration(
                  color: Color(0x26FFFFFF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(CupertinoIcons.mic_fill,
                  color: CupertinoColors.white, size: 22),
              ),
              SizedBox(width: kSpace12),
              Expanded(
                child: Text(AppStrings.recordPrompt,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: CupertinoColors.white, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          SizedBox(height: kSpace16),
          Text(AppStrings.recordDescription,
            style: AppTextStyles.bodyMedium.copyWith(
              color: CupertinoColors.white.withValues(alpha: 0.85), height: 1.6),
          ),
          SizedBox(height: kSpace24),
          GestureDetector(
            onTap: () => _navigateToRecording(context),
            child: Container(
              width: kRecordButtonSize + 20,
              height: kRecordButtonSize + 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CupertinoColors.white.withValues(alpha: 0.95),
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.white.withValues(alpha: 0.25),
                    blurRadius: 28,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(CupertinoIcons.mic_fill,
                  size: 36, color: AppColors.surface0),
              ),
            ),
          ),
          SizedBox(height: kSpace12),
          Text(AppStrings.tapToRecordAction,
            style: AppTextStyles.titleSmall.copyWith(
              color: CupertinoColors.white, fontWeight: FontWeight.w600)),
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
          iconColor: AppColors.emotionLoved,
          title: 'حاسس بإيه النهاردة؟',
          subtitle: state.stats.currentStreak > 3
              ? 'أقرب إلى الامتنان'
              : 'سجل يومياتك',
          brightness: brightness,
        ),
        SizedBox(width: kSpace12),
        _buildMiniCard(
          icon: state.todayEntry != null
              ? CupertinoIcons.checkmark_circle_fill
              : CupertinoIcons.sun_max_fill,
          iconColor: state.todayEntry != null
              ? AppColors.success
              : AppColors.warning,
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
        padding: EdgeInsets.all(kSpace16),
        decoration: BoxDecoration(
          color: AppColors.surface(2, brightness),
          borderRadius: BorderRadius.circular(AppRadius.standard),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: kSpace20, color: iconColor),
            SizedBox(height: kSpace8),
            Text(title,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.onSurface(brightness, secondary: true))),
            SizedBox(height: kSpace4),
            Text(subtitle,
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.onSurface(brightness)),
              maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }

  static Widget _buildRecentEntries(
      BuildContext context, List<GratitudeEntry> entries, Brightness brightness) {
    if (entries.isEmpty) {
      return _buildEmptyState(context, brightness);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: kSpace4, bottom: kSpace12),
          child: Text(AppStrings.recentEntries,
            style: AppTextStyles.titleSmall.copyWith(
              color: AppColors.onSurface(brightness))),
        ),
        SizedBox(
          height: 150.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: entries.length,
            separatorBuilder: (_, _) => SizedBox(width: kSpace12),
            itemBuilder: (context, index) {
              final entry = entries[index];
              return _buildEntryCard(context, entry, brightness);
            },
          ),
        ),
      ],
    );
  }

  static Widget _buildEntryCard(BuildContext context, GratitudeEntry entry, Brightness brightness) {
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
        width: 220.w,
        padding: EdgeInsets.all(kSpace16),
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
                    horizontal: kSpace10, vertical: kSpace6),
                  decoration: BoxDecoration(
                    color: moodColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(
                    entry.moodTag ?? AppStrings.audio,
                    style: AppTextStyles.labelSmall.copyWith(color: moodColor),
                  ),
                ),
                const Spacer(),
                Icon(
                  entry.isVoiceEntry
                      ? CupertinoIcons.mic_fill
                      : CupertinoIcons.doc_text_fill,
                  size: 14.w, color: AppColors.onSurface(brightness, tertiary: true)),
              ],
            ),
            SizedBox(height: kSpace12),
            Expanded(
              child: Text(
                entry.text,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.onSurface(brightness), height: 1.5),
              ),
            ),
            SizedBox(height: kSpace8),
            Text(
              '${entry.createdAt.day}/${entry.createdAt.month}',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.onSurface(brightness, tertiary: true)),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildReflectionCard(BuildContext context, Brightness brightness) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(kSpace20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.surface(1, brightness),
            AppColors.primaryContainer.withValues(alpha: 0.5),
          ],
        ),
        borderRadius: BorderRadius.circular(AppRadius.generous),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.reflectionTitle,
            style: AppTextStyles.titleSmall.copyWith(color: AppColors.onSurface(brightness))),
          SizedBox(height: kSpace8),
          Text(AppStrings.reflectionText,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onSurface(brightness, secondary: true), height: 1.7)),
          SizedBox(height: kSpace16),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton.filled(
              borderRadius: BorderRadius.circular(AppRadius.standard),
              onPressed: () => _navigateToRecording(context),
              child: Text(AppStrings.startGratitude,
                style: AppTextStyles.titleSmall.copyWith(
                  color: CupertinoColors.white, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildEmptyState(BuildContext context, Brightness brightness) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(kSpace24),
      decoration: BoxDecoration(
        color: AppColors.surface(1, brightness),
        borderRadius: BorderRadius.circular(AppRadius.generous),
      ),
      child: Column(
        children: [
          Text(AppStrings.noEntriesYet,
            style: AppTextStyles.titleSmall.copyWith(color: AppColors.onSurface(brightness))),
          SizedBox(height: kSpace8),
          Text(AppStrings.noEntriesSubtitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onSurface(brightness, secondary: true), height: 1.6)),
          SizedBox(height: kSpace16),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton.filled(
              borderRadius: BorderRadius.circular(AppRadius.standard),
              onPressed: () => _navigateToRecording(context),
              child: Text(AppStrings.recordNow,
                style: AppTextStyles.titleSmall.copyWith(
                  color: CupertinoColors.white, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}
