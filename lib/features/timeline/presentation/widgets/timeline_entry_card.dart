import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/timeline_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/services/audio_service.dart';
import '../../../../data/models/gratitude_entry.dart';

class TimelineEntryCard extends StatefulWidget {
  final GratitudeEntry entry;
  final String? playingEntryId;
  final AudioService audioService;

  const TimelineEntryCard({
    super.key,
    required this.entry,
    required this.playingEntryId,
    required this.audioService,
  });

  @override
  State<TimelineEntryCard> createState() => _TimelineEntryCardState();
}

class _TimelineEntryCardState extends State<TimelineEntryCard> {
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
    final brightness = CupertinoTheme.of(context).brightness ?? Brightness.dark;
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(AppStrings.confirmDelete,
          style: AppTextStyles.titleMedium.copyWith(color: AppColors.onSurface(brightness))),
        actions: [
          CupertinoDialogAction(
            child: Text(AppStrings.cancel,
              style: AppTextStyles.titleSmall.copyWith(color: AppColors.onSurface(brightness, secondary: true))),
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
      padding: EdgeInsets.symmetric(horizontal: kSpace16, vertical: kSpace4),
      child: Container(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatTimeOfDay(entry.createdAt),
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.onSurface(brightness, secondary: true)),
                ),
                if (entry.moodTag != null)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: kSpace8, vertical: kSpace4),
                    decoration: BoxDecoration(
                      color: _moodColor(entry.moodTag).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Text(
                      AppStrings.moodLabel(entry.moodTag),
                      style: AppTextStyles.labelSmall.copyWith(
                        color: _moodColor(entry.moodTag)),
                    ),
                  ),
              ],
            ),
            SizedBox(height: kSpace8),
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
              SizedBox(height: kSpace8),
              Container(
                padding: EdgeInsets.all(kSpace8),
                decoration: BoxDecoration(
                  color: AppColors.surface(2, brightness),
                  borderRadius: BorderRadius.circular(AppRadius.standard),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.read<TimelineCubit>().playEntry(entry),
                      child: Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isPlaying
                              ? CupertinoIcons.pause_fill
                              : CupertinoIcons.play_fill,
                          size: kSpace16,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    SizedBox(width: kSpace8),
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
            SizedBox(height: kSpace8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => _showEditDialog(context, entry),
                  child: Container(
                    padding: EdgeInsets.all(kSpace8),
                    decoration: BoxDecoration(
                      color: AppColors.surface(2, brightness),
                      borderRadius: BorderRadius.circular(AppRadius.cozy),
                    ),
                    child: Icon(CupertinoIcons.pencil,
                      size: kSpace16, color: AppColors.onSurface(brightness, secondary: true)),
                  ),
                ),
                GestureDetector(
                  onTap: () => _confirmDelete(context, entry),
                  child: Container(
                    padding: EdgeInsets.all(kSpace8),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppRadius.cozy),
                    ),
                    child: Icon(CupertinoIcons.delete,
                      size: 16.w, color: AppColors.error),
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
        padding: EdgeInsets.only(top: AppSpacing.tight),
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
              color: _canSave ? AppColors.primary : AppColors.onSurface(brightness, tertiary: true)),
          ),
        ),
      ],
    );
  }
}
