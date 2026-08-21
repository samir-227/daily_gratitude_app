import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../bloc/timeline_cubit.dart';
import '../bloc/timeline_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/widgets/staggered_fade_in.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/services/audio_service.dart';
import '../../../../data/models/gratitude_entry.dart';
import '../widgets/timeline_search_bar.dart';
import '../widgets/timeline_filter_bar.dart';
import '../widgets/timeline_section_header.dart';
import '../widgets/timeline_entry_card.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  late final AudioService _audioService;
  final _scrollController = ScrollController();
  StreamSubscription? _entriesSubscription;

  @override
  void initState() {
    super.initState();
    _audioService = sl<AudioService>();
    _scrollController.addListener(_onScroll);
    _entriesSubscription = Hive.box<GratitudeEntry>(kEntriesBox).watch().listen((_) {
      if (mounted) context.read<TimelineCubit>().refresh();
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      context.read<TimelineCubit>().loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _entriesSubscription?.cancel();
    super.dispose();
  }

  Widget _buildSearchEmptyState(Brightness brightness) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.standard),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                CupertinoIcons.search,
                size: 28.w,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: AppSpacing.standard),
            Text(
              AppStrings.noMatchSearch,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.onSurface(brightness, secondary: true),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineEmptyState(Brightness brightness) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.standard),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary.withValues(alpha: 0.15),
                    AppColors.primary.withValues(alpha: 0.05),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                CupertinoIcons.book,
                size: 32.w,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: AppSpacing.standard),
            Text(
              AppStrings.timelineEmptyTitle,
              style: AppTextStyles.titleSmall.copyWith(
                color: AppColors.onSurface(brightness),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: AppSpacing.compact),
            Text(
              AppStrings.timelineEmptySubtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.onSurface(brightness, secondary: true),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final brightness = CupertinoTheme.of(context).brightness ?? Brightness.dark;
    return CupertinoPageScaffold(
      backgroundColor: AppColors.surface(0, brightness),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppColors.surface(1, brightness),
        border: Border(bottom: BorderSide(color: AppColors.divider, width: 0.5)),
        middle: Text(AppStrings.timeline,
          style: AppTextStyles.titleSmall.copyWith(color: AppColors.onSurface(brightness))),
      ),
      child: SafeArea(
        child: BlocConsumer<TimelineCubit, TimelineState>(
            listener: (context, state) {
              if (state is TimelineLoadedState && state.audioErrorMessage != null) {
                showCupertinoDialog(
                  context: context,
                  builder: (ctx) => CupertinoAlertDialog(
                    content: Text(state.audioErrorMessage!),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text(AppStrings.ok),
                        onPressed: () => Navigator.of(ctx).pop(),
                      ),
                    ],
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is TimelineLoadingState) {
                return const Center(child: CupertinoActivityIndicator());
              }
              if (state is TimelineErrorState) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.message,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.onSurface(brightness, secondary: true))),
                      SizedBox(height: kSpace16),
                      CupertinoButton(
                        onPressed: () => context.read<TimelineCubit>().loadEntries(),
                        child: Text(AppStrings.retry,
                          style: AppTextStyles.titleSmall.copyWith(color: AppColors.primary)),
                      ),
                    ],
                  ),
                );
              }
              if (state is TimelineLoadedState) {
                return CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverToBoxAdapter(child: TimelineSearchBar(brightness: brightness)),
                    SliverToBoxAdapter(child: TimelineFilterBar(state: state)),
                    if (state.groupedEntries.isEmpty)
                      SliverFillRemaining(
                        child: state.searchQuery.isNotEmpty
                            ? _buildSearchEmptyState(brightness)
                            : _buildTimelineEmptyState(brightness),
                      )
                    else ...[
                      ...state.groupedEntries.entries.map((group) => [
                        SliverToBoxAdapter(child: TimelineSectionHeader(
                          header: group.key,
                          brightness: brightness,
                        )),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => StaggeredFadeIn(
                              index: index,
                              child: TimelineEntryCard(
                                entry: group.value[index],
                                playingEntryId: state.playingEntryId,
                                audioService: _audioService,
                              ),
                            ),
                            childCount: group.value.length,
                          ),
                        ),
                      ]).expand((e) => e),
                      if (state.isLoadingMore)
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.all(kSpace16),
                            child: const Center(child: CupertinoActivityIndicator()),
                          ),
                        ),
                    ],
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
