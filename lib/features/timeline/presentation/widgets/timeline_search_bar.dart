import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/timeline_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_theme.dart';

class TimelineSearchBar extends StatelessWidget {
  final Brightness brightness;

  const TimelineSearchBar({super.key, required this.brightness});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(kSpace16, kSpace8, kSpace16, kSpace4),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface(2, brightness),
          borderRadius: BorderRadius.circular(AppRadius.standard),
        ),
        child: CupertinoSearchTextField(
          backgroundColor: const Color(0x00000000),
          placeholder: AppStrings.searchPlaceholder,
          placeholderStyle: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.onSurface(brightness, tertiary: true)),
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.onSurface(brightness)),
          onChanged: (value) => context.read<TimelineCubit>().setSearchQuery(value),
        ),
      ),
    );
  }
}
