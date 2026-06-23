import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_theme.dart';
import '../bloc/recording_cubit.dart';

class MoodSelectionSection extends StatelessWidget {
  final RecordingDoneState state;
  final Brightness brightness;

  const MoodSelectionSection({
    super.key,
    required this.state,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    final moods = [
      _MoodOption('grateful', AppStrings.emotionJoy, AppColors.emotionJoy, CupertinoIcons.heart_fill),
      _MoodOption('happy', AppStrings.emotionHope, AppColors.emotionHope, CupertinoIcons.smiley_fill),
      _MoodOption('calm', AppStrings.emotionPeace, AppColors.emotionPeace, CupertinoIcons.moon_fill),
      _MoodOption('loved', AppStrings.emotionLoved, AppColors.emotionLoved, CupertinoIcons.sparkles),
      _MoodOption('grounded', AppStrings.emotionGrounded, AppColors.emotionGrounded, CupertinoIcons.leaf_arrow_circlepath),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(AppStrings.howDoYouFeel,
          style: AppTextStyles.labelLarge.copyWith(color: AppColors.onSurface(brightness))),
        SizedBox(height: kSpace8),
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
      padding: EdgeInsets.all(kSpace10),
      decoration: BoxDecoration(
        color: selected
            ? mood.color.withValues(alpha: 0.15)
            : const Color(0x00000000),
        borderRadius: BorderRadius.circular(AppRadius.standard),
        border: Border.all(
          color: selected ? mood.color : AppColors.surface(3, brightness),
          width: selected ? 2.w : 1.w,
        ),
      ),
      child: Column(
        children: [
          Icon(mood.icon,
            size: 20.w,
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
