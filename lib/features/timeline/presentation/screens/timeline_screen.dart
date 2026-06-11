import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/timeline_cubit.dart';
import '../bloc/timeline_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/services/audio_service.dart';
import '../../../../data/models/gratitude_entry.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  late final AudioService _audioService;

  @override
  void initState() {
    super.initState();
    _audioService = sl<AudioService>();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = CupertinoTheme.of(context).brightness ?? Brightness.dark;
    return BlocProvider(
      create: (_) {
        final cubit = sl<TimelineCubit>();
        cubit.loadEntries();
        return cubit;
      },
      child: CupertinoPageScaffold(
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
                      const SizedBox(height: kSpace16),
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
                  slivers: [
                    SliverToBoxAdapter(child: _buildSearchBar(context, brightness)),
                    SliverToBoxAdapter(child: _buildFilterBar(context, state)),
                    if (state.groupedEntries.isEmpty)
                      SliverFillRemaining(
                        child: Center(
                          child: Text(
                            state.searchQuery.isNotEmpty
                                ? AppStrings.noMatchSearch
                                : AppStrings.noEntriesYet,
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColors.onSurface(brightness, secondary: true)),
                          ),
                        ),
                      )
                    else
                      ...state.groupedEntries.entries.map((group) => [
                        SliverToBoxAdapter(child: _buildSectionHeader(group.key, brightness)),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => _TimelineEntryCard(
                              entry: group.value[index],
                              playingEntryId: state.playingEntryId,
                              audioService: _audioService,
                            ),
                            childCount: group.value.length,
                          ),
                        ),
                      ]).expand((e) => e),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, Brightness brightness) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(kSpace16, kSpace12, kSpace16, kSpace4),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface(2, brightness),
          borderRadius: BorderRadius.circular(AppRadius.standard),
        ),
        child: CupertinoSearchTextField(
          backgroundColor: const Color(0x00000000),
          onChanged: (value) => context.read<TimelineCubit>().setSearchQuery(value),
        ),
      ),
    );
  }

  Widget _buildFilterBar(BuildContext context, TimelineLoadedState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpace16, vertical: kSpace8),
      child: CupertinoSlidingSegmentedControl<TimelineFilter>(
        groupValue: state.filter,
        children: const {
          TimelineFilter.all: Text(AppStrings.all),
          TimelineFilter.thisWeek: Text(AppStrings.thisWeek),
          TimelineFilter.thisMonth: Text(AppStrings.thisMonth),
        },
        onValueChanged: (value) {
          context.read<TimelineCubit>().setFilter(value!);
        },
      ),
    );
  }

  Widget _buildSectionHeader(String header, Brightness brightness) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(kSpace16, kSpace20, kSpace16, kSpace8),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: kSpace8),
          Text(header,
            style: AppTextStyles.titleSmall.copyWith(
              color: AppColors.onSurface(brightness), fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _TimelineEntryCard extends StatefulWidget {
  final GratitudeEntry entry;
  final String? playingEntryId;
  final AudioService audioService;

  const _TimelineEntryCard({
    required this.entry,
    required this.playingEntryId,
    required this.audioService,
  });

  @override
  State<_TimelineEntryCard> createState() => _TimelineEntryCardState();
}

class _TimelineEntryCardState extends State<_TimelineEntryCard> {
  bool _isExpanded = false;

  Color _moodColor(String? mood) {
    switch (mood) {
      case 'grateful': return AppColors.emotionJoy;
      case 'happy': return AppColors.emotionHope;
      case 'calm': return AppColors.emotionPeace;
      case 'loved': return AppColors.emotionLoved;
      case 'reflective': return AppColors.emotionLoved;
      case 'grounded': return AppColors.emotionGrounded;
      default: return AppColors.textSecondary;
    }
  }

  void _confirmDelete(BuildContext context, GratitudeEntry entry) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(AppStrings.confirmDelete,
          style: AppTextStyles.titleMedium.copyWith(color: AppColors.textPrimary)),
        actions: [
          CupertinoDialogAction(
            child: Text(AppStrings.cancel,
              style: AppTextStyles.titleSmall.copyWith(color: AppColors.textSecondary)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: Text(AppStrings.delete,
              style: AppTextStyles.titleSmall.copyWith(color: AppColors.error)),
            onPressed: () {
              Navigator.of(context).pop();
              context.read<TimelineCubit>().deleteEntry(entry.id);
            },
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, GratitudeEntry entry) {
    showCupertinoDialog(
      context: context,
      builder: (_) => _EditEntryDialog(entry: entry),
    );
  }

  @override
  Widget build(BuildContext context) {
    final brightness = CupertinoTheme.of(context).brightness ?? Brightness.dark;
    final entry = widget.entry;
    final isPlaying = widget.playingEntryId == entry.id;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpace16, vertical: kSpace6),
      child: Container(
        padding: const EdgeInsets.all(kSpace16),
        decoration: BoxDecoration(
          color: AppColors.surface(1, brightness),
          borderRadius: BorderRadius.circular(AppRadius.generous),
          border: Border.all(color: AppColors.surface(2, brightness)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatTimeOfDay(entry.createdAt),
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.onSurface(brightness, secondary: true)),
                ),
                if (entry.moodTag != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kSpace8, vertical: kSpace4),
                    decoration: BoxDecoration(
                      color: _moodColor(entry.moodTag).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Text(
                      entry.moodTag!,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: _moodColor(entry.moodTag)),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: kSpace8),
            Text(
              entry.text,
              maxLines: _isExpanded ? null : 3,
              overflow: _isExpanded ? null : TextOverflow.ellipsis,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.onSurface(brightness), height: 1.6),
            ),
            if (entry.text.length > 100 && !_isExpanded)
              CupertinoButton(
                padding: EdgeInsets.zero,
                pressedOpacity: 0.6,
                child: Text(AppStrings.showMore,
                  style: AppTextStyles.labelLarge.copyWith(color: AppColors.primary)),
                onPressed: () => setState(() => _isExpanded = true),
              ),
            if (_isExpanded)
              CupertinoButton(
                padding: EdgeInsets.zero,
                pressedOpacity: 0.6,
                child: Text(AppStrings.showLess,
                  style: AppTextStyles.labelLarge.copyWith(color: AppColors.primary)),
                onPressed: () => setState(() => _isExpanded = false),
              ),
            if (entry.isVoiceEntry && entry.audioPath != null) ...[
              const SizedBox(height: kSpace8),
              Container(
                padding: const EdgeInsets.all(kSpace12),
                decoration: BoxDecoration(
                  color: AppColors.surface(2, brightness),
                  borderRadius: BorderRadius.circular(AppRadius.standard),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.read<TimelineCubit>().playEntry(entry),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isPlaying
                              ? CupertinoIcons.pause_fill
                              : CupertinoIcons.play_fill,
                          size: 16,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: kSpace8),
                    Expanded(
                      child: isPlaying
                          ? StreamBuilder<Duration>(
                              stream: widget.audioService.playbackPosition,
                              builder: (context, positionSnapshot) {
                                return StreamBuilder<Duration?>(
                                  stream: widget.audioService.totalDuration,
                                  builder: (context, durationSnapshot) {
                                    final position = positionSnapshot.data ?? Duration.zero;
                                    final total = durationSnapshot.data;
                                    if (total == null || total.inMilliseconds <= 0) {
                                      return const CupertinoActivityIndicator();
                                    }
                                    return CupertinoSlider(
                                      value: (position.inMilliseconds / total.inMilliseconds).clamp(0.0, 1.0),
                                      min: 0.0,
                                      max: 1.0,
                                      onChanged: (value) {
                                        final seekPos = Duration(
                                          milliseconds: (value * total.inMilliseconds).round(),
                                        );
                                        widget.audioService.seek(seekPos);
                                      },
                                    );
                                  },
                                );
                              },
                            )
                          : const SizedBox.shrink(),
                    ),
                    Text(
                      isPlaying ? AppStrings.pause : AppStrings.play,
                      style: AppTextStyles.labelSmall.copyWith(color: AppColors.primary),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: kSpace8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => _showEditDialog(context, entry),
                  child: Container(
                    padding: const EdgeInsets.all(kSpace8),
                    decoration: BoxDecoration(
                      color: AppColors.surface(2, brightness),
                      borderRadius: BorderRadius.circular(AppRadius.cozy),
                    ),
                    child: Icon(CupertinoIcons.pencil,
                      size: 16, color: AppColors.onSurface(brightness, secondary: true)),
                  ),
                ),
                GestureDetector(
                  onTap: () => _confirmDelete(context, entry),
                  child: Container(
                    padding: const EdgeInsets.all(kSpace8),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppRadius.cozy),
                    ),
                    child: const Icon(CupertinoIcons.delete,
                      size: 16, color: AppColors.error),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EditEntryDialog extends StatefulWidget {
  final GratitudeEntry entry;
  const _EditEntryDialog({required this.entry});

  @override
  State<_EditEntryDialog> createState() => _EditEntryDialogState();
}

class _EditEntryDialogState extends State<_EditEntryDialog> {
  late final TextEditingController _controller;
  bool _canSave = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.entry.text);
    _canSave = widget.entry.text.trim().isNotEmpty;
    _controller.addListener(() {
      setState(() => _canSave = _controller.text.trim().isNotEmpty);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = CupertinoTheme.of(context).brightness ?? Brightness.dark;
    return CupertinoAlertDialog(
      title: Text(AppStrings.editEntry,
        style: AppTextStyles.titleMedium.copyWith(color: AppColors.onSurface(brightness))),
      content: Padding(
        padding: const EdgeInsets.only(top: AppSpacing.tight),
        child: CupertinoTextField(
          controller: _controller,
          maxLines: 5,
          textDirection: TextDirection.rtl,
        ),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppStrings.cancel,
            style: AppTextStyles.titleSmall.copyWith(
              color: AppColors.onSurface(brightness, secondary: true))),
        ),
        CupertinoDialogAction(
          onPressed: _canSave
              ? () {
                  Navigator.of(context).pop();
                  context
                      .read<TimelineCubit>()
                      .updateEntry(widget.entry.id, _controller.text.trim());
                }
              : null,
          child: Text(
            AppStrings.save,
            style: AppTextStyles.titleSmall.copyWith(
              color: _canSave ? AppColors.primary : CupertinoColors.inactiveGray),
          ),
        ),
      ],
    );
  }
}
