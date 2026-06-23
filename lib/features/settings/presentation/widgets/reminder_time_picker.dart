import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/settings_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_theme.dart';

void showReminderTimePicker(BuildContext context) {
  final brightness = CupertinoTheme.of(context).brightness ?? Brightness.dark;
  showCupertinoModalPopup(
    context: context,
    builder: (_) => Container(
      height: 300.h,
      color: AppColors.surface(1, brightness),
      child: Column(
        children: [
          CupertinoButton(
            child: Text(AppStrings.done,
              style: AppTextStyles.titleSmall.copyWith(color: AppColors.primary)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              backgroundColor: AppColors.surface(0, brightness),
              initialDateTime: DateTime(2000, 1, 1, 20, 0),
              onDateTimeChanged: (dt) {
                context.read<SettingsCubit>().scheduleReminder(dt.hour, dt.minute);
              },
            ),
          ),
        ],
      ),
    ),
  );
}
