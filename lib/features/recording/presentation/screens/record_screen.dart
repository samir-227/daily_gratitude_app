import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import '../widgets/recording_status_header.dart';
import '../widgets/recording_button.dart';
import '../widgets/live_text_display.dart';
import '../widgets/text_enrichment_section.dart';
import '../widgets/mood_selection_section.dart';
import '../widgets/audio_saved_indicator.dart';
import '../widgets/error_banner.dart';
import '../widgets/recording_footer.dart';

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
                          SizedBox(height: kSpace12),
                          RecordingStatusHeader(state: state, brightness: brightness),
                          SizedBox(height: kSpace16),
                          RecordingButton(state: state, brightness: brightness),
                          SizedBox(height: kSpace16),
                          if (state is RecordingDoneState) ...[
                            TextEnrichmentSection(
                              controller: _textController,
                              brightness: brightness,
                            ),
                            SizedBox(height: kSpace16),
                            MoodSelectionSection(state: state, brightness: brightness),
                            SizedBox(height: kSpace16),
                            AudioSavedIndicator(brightness: brightness),
                          ],
                          if (state is RecordingInProgressState) ...[
                            LiveTextDisplay(state: state, brightness: brightness),
                          ],
                          if (state is RecordingErrorState) ...[
                            SizedBox(height: kSpace16),
                            ErrorBanner(state: state),
                          ],
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(kSpace16, 0, kSpace16, kSpace16),
                    child: RecordingFooter(state: state, brightness: brightness),
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
}
