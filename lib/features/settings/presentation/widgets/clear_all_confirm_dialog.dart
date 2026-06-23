import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/settings_cubit.dart';
import '../../../../core/constants/app_strings.dart';

void showClearAllConfirmDialog(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (_) => CupertinoAlertDialog(
      title: const Text(AppStrings.confirmClearAll),
      actions: [
        CupertinoDialogAction(
          child: const Text(AppStrings.cancel),
          onPressed: () => Navigator.of(context).pop(),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          child: const Text(AppStrings.delete),
          onPressed: () {
            Navigator.of(context).pop();
            context.read<SettingsCubit>().clearAllData();
          },
        ),
      ],
    ),
  );
}
