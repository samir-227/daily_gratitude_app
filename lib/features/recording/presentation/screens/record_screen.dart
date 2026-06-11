import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../bloc/recording_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/di/injection.dart';
import '../../../../features/home/presentation/bloc/home_cubit.dart';
import '../../../../features/timeline/presentation/bloc/timeline_cubit.dart';
import '../../../../features/analytics/presentation/bloc/analytics_cubit.dart';
import '../../../../features/home/presentation/widgets/milestone_dialog.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = CupertinoTheme.of(context).brightness ?? Brightness.dark;
    return BlocProvider(
      create: (_) => sl<RecordingCubit>(),
      child: BlocConsumer<RecordingCubit, RecordingState>(
        listener: (context, state) {
          if (state is EntrySavedState) {
            context.read<RecordingCubit>().reset();
            context.read<HomeCubit>().refresh();
            context.read<TimelineCubit>().loadEntries();
            context.read<AnalyticsCubit>().loadAnalytics();
            if (state.milestoneStreak != null && context.mounted) {
              showMilestoneDialog(context, state.milestoneStreak!);
            }
            if (context.mounted) {
              _showSavedToast(context);
              context.pop();
            }
          }
          if (state is RecordingDoneState) {
            _textController.text = state.text;
          }
        },
        builder: (context, state) {
          return CupertinoPageScaffold(
            backgroundColor: AppColors.surface(0, brightness),
            navigationBar: CupertinoNavigationBar(
              backgroundColor: AppColors.surface(1, brightness),
              border: Border(bottom: BorderSide(color: AppColors.divider, width: 0.5)),
              middle: Text(AppStrings.recordGratitude,
                style: AppTextStyles.titleSmall.copyWith(color: AppColors.onSurface(brightness))),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: kSpace16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: kSpace20),
                          _buildStatusHeader(state, brightness),
                          SizedBox(height: kSpace24),
                          _buildRecordingButton(context, state, brightness),
                          SizedBox(height: kSpace24),
                          if (state is RecordingDoneState) ...[
                            _buildTextEnrichment(context, brightness),
                            SizedBox(height: kSpace16),
                            _buildMoodSection(context, state, brightness),
                            SizedBox(height: kSpace16),
                            _buildAudioIndicator(brightness),
                          ],
                          if (state is RecordingInProgressState) ...[
                            _buildLiveText(state, brightness),
                          ],
                          if (state is RecordingErrorState) ...[
                            SizedBox(height: kSpace16),
                            _buildErrorBanner(state),
                          ],
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(kSpace16, 0, kSpace16, kSpace16),
                    child: _buildFooter(context, state, brightness),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showSavedToast(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(AppStrings.entrySaved,
          style: AppTextStyles.titleMedium.copyWith(color: AppColors.primary)),
        actions: [
          CupertinoDialogAction(
            child: Text(AppStrings.ok,
              style: AppTextStyles.titleSmall.copyWith(color: AppColors.primary)),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusHeader(RecordingState state, Brightness brightness) {
    final isRecording = state is RecordingInProgressState;
    final isDone = state is RecordingDoneState;
    String title;
    String subtitle;
    Color accent;

    if (isRecording) {
      title = AppStrings.recordingInProgress;
      subtitle = AppStrings.recordingHint;
      accent = AppColors.error;
    } else if (isDone) {
      title = AppStrings.doneRecording;
      subtitle = 'يمكنك الآن إضافة مشاعرك أو نص إضافي قبل الحفظ.';
      accent = AppColors.primary;
    } else {
      title = AppStrings.startRecordingText;
      subtitle = AppStrings.tapToRecord;
      accent = AppColors.primary;
    }

    return Container(
      padding: EdgeInsets.all(kSpace16),
      decoration: BoxDecoration(
        color: AppColors.surface(1, brightness),
        borderRadius: BorderRadius.circular(AppRadius.generous),
        border: Border.all(color: accent.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: kSpace4,
            height: 40.w,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(width: kSpace12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                  style: AppTextStyles.titleSmall.copyWith(color: AppColors.onSurface(brightness))),
                SizedBox(height: kSpace4),
                Text(subtitle,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.onSurface(brightness, secondary: true))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordingButton(BuildContext context, RecordingState state, Brightness brightness) {
    final isRecording = state is RecordingInProgressState;
    final isDone = state is RecordingDoneState;

    return Container(
      padding: EdgeInsets.all(kSpace24),
      decoration: BoxDecoration(
        color: AppColors.surface(1, brightness),
        borderRadius: BorderRadius.circular(AppRadius.generous + 4),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (isRecording) {
                context.read<RecordingCubit>().stopRecording();
              } else if (!isDone) {
                context.read<RecordingCubit>().startRecording();
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: kRecordButtonSize + 20,
              height: kRecordButtonSize + 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: isRecording
                    ? const LinearGradient(
                        colors: [AppColors.error, Color(0xFFDC2626)])
                    : const LinearGradient(
                        colors: [AppColors.primary, AppColors.primaryDark]),
                boxShadow: [
                  BoxShadow(
                    color: (isRecording ? AppColors.error : AppColors.primary)
                        .withValues(alpha: 0.3),
                    blurRadius: 28,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  isRecording
                      ? CupertinoIcons.stop_fill
                      : CupertinoIcons.mic_fill,
                  color: CupertinoColors.white,
                  size: 36.w,
                ),
              ),
            ),
          ),
          SizedBox(height: kSpace16),
          Text(
            isRecording ? AppStrings.stopRecordingText : AppStrings.tapToRecordAction,
            style: AppTextStyles.titleSmall.copyWith(
              color: isRecording ? AppColors.error : AppColors.onSurface(brightness),
              fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveText(RecordingInProgressState state, Brightness brightness) {
    if (state.liveText.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: EdgeInsets.all(kSpace16),
      decoration: BoxDecoration(
        color: AppColors.surface(1, brightness),
        borderRadius: BorderRadius.circular(AppRadius.generous),
      ),
      child: Text(state.liveText,
        style: AppTextStyles.bodyLarge.copyWith(
          color: AppColors.onSurface(brightness), height: 1.6)),
    );
  }

  Widget _buildTextEnrichment(BuildContext context, Brightness brightness) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(AppStrings.addDescription,
          style: AppTextStyles.labelLarge.copyWith(color: AppColors.onSurface(brightness))),
        SizedBox(height: kSpace12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface(2, brightness),
            borderRadius: BorderRadius.circular(AppRadius.standard),
          ),
          child: CupertinoTextField(
            controller: _textController,
            padding: EdgeInsets.all(kSpace12),
            placeholder: AppStrings.textPlaceholder,
            placeholderStyle: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onSurface(brightness, tertiary: true)),
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.onSurface(brightness), height: 1.6),
            maxLines: 5,
            onChanged: (value) => context.read<RecordingCubit>().updateText(value),
            decoration: BoxDecoration(
              color: const Color(0x00000000),
              borderRadius: BorderRadius.circular(AppRadius.standard),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMoodSection(BuildContext context, RecordingDoneState state, Brightness brightness) {
    final moods = [
      _MoodOption('grateful', AppStrings.emotionJoy, AppColors.emotionJoy, CupertinoIcons.heart_fill),
      _MoodOption('happy', AppStrings.emotionPeace, AppColors.emotionPeace, CupertinoIcons.smiley_fill),
      _MoodOption('calm', AppStrings.emotionLoved, AppColors.emotionLoved, CupertinoIcons.moon_fill),
      _MoodOption('loved', AppStrings.emotionHope, AppColors.emotionHope, CupertinoIcons.sparkles),
      _MoodOption('grounded', AppStrings.emotionGrounded, AppColors.emotionGrounded, CupertinoIcons.leaf_arrow_circlepath),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(AppStrings.howDoYouFeel,
          style: AppTextStyles.labelLarge.copyWith(color: AppColors.onSurface(brightness))),
        SizedBox(height: kSpace12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final mood in moods) ...[
                if (moods.first != mood) SizedBox(width: kSpace8),
                GestureDetector(
                  onTap: () => context.read<RecordingCubit>().selectMood(mood.value),
                  child: _MoodCard(
                    mood: mood,
                    selected: state.selectedMood == mood.value,
                    brightness: brightness,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildErrorBanner(RecordingErrorState state) {
    return Container(
      padding: EdgeInsets.all(kSpace16),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.standard),
      ),
      child: Row(
        children: [
          const Icon(CupertinoIcons.exclamationmark_triangle_fill,
            color: AppColors.error, size: 18),
          SizedBox(width: kSpace12),
          Expanded(
            child: Text(state.message,
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  Widget _buildAudioIndicator(Brightness brightness) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(CupertinoIcons.mic_fill, size: 14.w,
          color: AppColors.onSurface(brightness, tertiary: true)),
        SizedBox(width: kSpace8),
        Text(AppStrings.audioSavedWithEntry,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.onSurface(brightness, tertiary: true))),
      ],
    );
  }

  Widget _buildFooter(BuildContext context, RecordingState state, Brightness brightness) {
    final isDone = state is RecordingDoneState;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (isDone)
          CupertinoButton.filled(
            borderRadius: BorderRadius.circular(AppRadius.standard),
            onPressed: state.text.trim().isEmpty
                ? null
                : () => context.read<RecordingCubit>().saveEntry(),
            child: Text(AppStrings.save,
              style: AppTextStyles.titleSmall.copyWith(
                color: CupertinoColors.white, fontWeight: FontWeight.w600)),
          )
        else if (state is RecordingIdleState || state is RecordingErrorState)
          CupertinoButton(
            color: AppColors.surface(2, brightness),
            borderRadius: BorderRadius.circular(AppRadius.standard),
            onPressed: () => context.read<RecordingCubit>().startRecording(),
            child: Text(AppStrings.startRecordingText,
              style: AppTextStyles.titleSmall.copyWith(
                color: AppColors.onSurface(brightness), fontWeight: FontWeight.w600)),
          ),
      ],
    );
  }
}

class _MoodCard extends StatelessWidget {
  final _MoodOption mood;
  final bool selected;
  final Brightness brightness;

  const _MoodCard({
    required this.mood,
    required this.selected,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.all(kSpace12),
      decoration: BoxDecoration(
        color: selected
            ? mood.color.withValues(alpha: 0.15)
            : const Color(0x00000000),
        borderRadius: BorderRadius.circular(AppRadius.standard),
        border: Border.all(
          color: selected ? mood.color : AppColors.surface(3, brightness),
          width: selected ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          Icon(mood.icon,
            size: kIconSize,
            color: selected ? mood.color : AppColors.onSurface(brightness, tertiary: true)),
          SizedBox(height: kSpace4),
          Text(mood.label,
            style: AppTextStyles.labelSmall.copyWith(
              color: selected ? mood.color : AppColors.onSurface(brightness, secondary: true))),
        ],
      ),
    );
  }
}

class _MoodOption {
  final String value;
  final String label;
  final Color color;
  final IconData icon;

  const _MoodOption(this.value, this.label, this.color, this.icon);
}
