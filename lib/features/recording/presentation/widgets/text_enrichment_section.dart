import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_theme.dart';
import '../bloc/recording_cubit.dart';

class TextEnrichmentSection extends StatelessWidget {
  final TextEditingController controller;
  final Brightness brightness;

  const TextEnrichmentSection({
    super.key,
    required this.controller,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(AppStrings.addDescription,
          style: AppTextStyles.labelLarge.copyWith(color: AppColors.onSurface(brightness))),
        SizedBox(height: kSpace8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface(2, brightness),
            borderRadius: BorderRadius.circular(AppRadius.standard),
          ),
          child: CupertinoTextField(
            controller: controller,
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
}
