import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import '../bloc/settings_cubit.dart';
import '../bloc/theme_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/di/injection.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final brightness = CupertinoTheme.of(context).brightness ?? Brightness.dark;
    return BlocProvider(
      create: (_) {
        final cubit = sl<SettingsCubit>();
        cubit.loadSettings();
        return cubit;
      },
      child: CupertinoPageScaffold(
        backgroundColor: AppColors.surface(0, brightness),
        navigationBar: CupertinoNavigationBar(
          backgroundColor: AppColors.surface(1, brightness),
          border: Border(bottom: BorderSide(color: AppColors.divider, width: 0.5)),
          middle: Text(AppStrings.settings,
            style: AppTextStyles.titleSmall.copyWith(color: AppColors.onSurface(brightness))),
        ),
        child: SafeArea(
          child: BlocConsumer<SettingsCubit, SettingsState>(
            listener: (context, state) {
              if (state is SettingsExportDoneState) {
                SharePlus.instance.share(ShareParams(
                  files: [XFile(state.filePath)],
                  text: AppStrings.myGratitudeEntries,
                ));
              }
              if (state is SettingsClearedState) {
                showCupertinoDialog(
                  context: context,
                  builder: (_) => CupertinoAlertDialog(
                    title: const Text(AppStrings.dataCleared),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text(AppStrings.ok),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                );
              }
              if (state is SettingsErrorState) {
                showCupertinoDialog(
                  context: context,
                  builder: (_) => CupertinoAlertDialog(
                    title: Text(state.message),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text(AppStrings.ok),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is SettingsLoadedState) {
                return _buildSettingsList(context, state, brightness);
              }
              if (state is SettingsExportingState || state is SettingsClearingState) {
                return const Center(child: CupertinoActivityIndicator());
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  static Widget _buildSettingsList(
      BuildContext context, SettingsLoadedState state, Brightness brightness) {
    return ListView(
      padding: EdgeInsets.all(AppSpacing.standard),
      children: [
        _sectionHeader(AppStrings.appearanceSection, brightness),
        SizedBox(height: AppSpacing.tight),
        BlocBuilder<ThemeCubit, Brightness>(
          builder: (context, themeBrightness) {
            final isDark = themeBrightness == Brightness.dark;
            return _buildCard(context,
              children: [
                _buildSwitchTile(
                  AppStrings.darkMode,
                  isDark,
                  (val) => context.read<ThemeCubit>().toggleDarkMode(val),
                  brightness,
                ),
              ],
            );
          },
        ),
        SizedBox(height: AppSpacing.standard),
        _sectionHeader(AppStrings.notificationsSection, brightness),
        SizedBox(height: AppSpacing.compact),
        _buildCard(context,
          children: [
            _buildSwitchTile(
              AppStrings.dailyReminder,
              state.notificationsEnabled,
              (val) => context.read<SettingsCubit>().toggleNotifications(val),
              brightness,
            ),
            _divider(brightness),
            _buildNavTile(
              AppStrings.reminderTime,
              () => _pickReminderTime(context),
              brightness,
              isLast: true,
            ),
          ],
        ),
        SizedBox(height: AppSpacing.standard),
        _sectionHeader(AppStrings.speechRecognitionSection, brightness),
        SizedBox(height: AppSpacing.compact),
        _buildCard(context,
          children: [
            _buildStatusTile(
              AppStrings.arabicDetection,
              state.hasArabicLocale ? 'ar-EG ✓' : AppStrings.notInstalled,
              state.hasArabicLocale ? AppColors.success : AppColors.error,
              brightness,
            ),
          ],
        ),
        SizedBox(height: AppSpacing.standard),
        _sectionHeader(AppStrings.dataSection, brightness),
        SizedBox(height: AppSpacing.compact),
        _buildCard(context,
          children: [
            _buildActionTile(
              AppStrings.exportEntries,
              CupertinoIcons.share,
              AppColors.primary,
              () => context.read<SettingsCubit>().exportEntries(),
              brightness,
            ),
            _divider(brightness),
            _buildActionTile(
              AppStrings.clearAllData,
              CupertinoIcons.delete,
              AppColors.error,
              () => _confirmClearAll(context),
              brightness,
              isLast: true,
              isDestructive: true,
            ),
          ],
        ),
        SizedBox(height: AppSpacing.standard),
        _sectionHeader(AppStrings.aboutSection, brightness),
        SizedBox(height: AppSpacing.compact),
        _buildCard(context,
          children: [
            _buildInfoTile(
              AppStrings.version,
              '1.0.0',
              brightness,
            ),
            _divider(brightness),
            _buildInfoTile(
              AppStrings.storageUsed,
              _formatBytes(state.storageUsedBytes),
              brightness,
              isLast: true,
            ),
          ],
        ),
        SizedBox(height: AppSpacing.spacious),
      ],
    );
  }

  static Widget _sectionHeader(String title, Brightness brightness) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.compact),
      child: Text(title,
        style: AppTextStyles.labelLarge.copyWith(
          color: AppColors.onSurface(brightness, secondary: true))),
    );
  }

  static Widget _buildCard(BuildContext context, {required List<Widget> children}) {
    final brightness = CupertinoTheme.of(context).brightness ?? Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface(1, brightness),
        borderRadius: BorderRadius.circular(AppRadius.standard),
        border: Border.all(color: AppColors.divider, width: 0.5),
      ),
      child: Column(children: children),
    );
  }

  static Widget _divider(Brightness brightness) {
    return Container(height: 0.5, color: AppColors.divider);
  }

  static Widget _buildSwitchTile(
      String label, bool value, Function(bool) onChanged, Brightness brightness) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.standard, vertical: AppSpacing.tight),
      child: Row(
        children: [
          Text(label,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurface(brightness))),
          const Spacer(),
          CupertinoSwitch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }

  static Widget _buildNavTile(
      String label, VoidCallback onTap, Brightness brightness, {bool isLast = false}) {
    return CupertinoButton(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.standard, vertical: AppSpacing.tight),
      borderRadius: isLast
          ? BorderRadius.only(
              bottomLeft: Radius.circular(AppRadius.standard),
              bottomRight: Radius.circular(AppRadius.standard))
          : BorderRadius.zero,
      onPressed: onTap,
      child: Row(
        children: [
          Text(label,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurface(brightness))),
          const Spacer(),
          Icon(CupertinoIcons.chevron_left, color: AppColors.onSurface(brightness, secondary: true), size: 16),
        ],
      ),
    );
  }

  static Widget _buildStatusTile(
      String label, String statusText, Color statusColor, Brightness brightness) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.standard, vertical: AppSpacing.tight),
      child: Row(
        children: [
          Text(label,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurface(brightness))),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.tight, vertical: AppSpacing.compact),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Text(statusText,
              style: AppTextStyles.labelSmall.copyWith(color: statusColor)),
          ),
        ],
      ),
    );
  }

  static Widget _buildActionTile(
      String label, IconData icon, Color iconColor, VoidCallback onTap,
      Brightness brightness, {bool isLast = false, bool isDestructive = false}) {
    return CupertinoButton(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.standard, vertical: AppSpacing.tight),
      borderRadius: isLast
          ? BorderRadius.only(
              bottomLeft: Radius.circular(AppRadius.standard),
              bottomRight: Radius.circular(AppRadius.standard))
          : BorderRadius.zero,
      onPressed: onTap,
      child: Row(
        children: [
          Icon(icon, size: 18, color: isDestructive ? AppColors.error : AppColors.primary),
          SizedBox(width: AppSpacing.tight),
          Text(label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: isDestructive ? AppColors.error : AppColors.onSurface(brightness))),
          const Spacer(),
          Icon(CupertinoIcons.chevron_left,
            color: AppColors.onSurface(brightness, secondary: true), size: 16),
        ],
      ),
    );
  }

  static Widget _buildInfoTile(
      String label, String value, Brightness brightness, {bool isLast = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.standard, vertical: AppSpacing.tight),
      child: Row(
        children: [
          Text(label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onSurface(brightness, secondary: true))),
          const Spacer(),
          Text(value,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurface(brightness))),
        ],
      ),
    );
  }

  static void _pickReminderTime(BuildContext context) {
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

  static String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  static void _confirmClearAll(BuildContext context) {
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
}
