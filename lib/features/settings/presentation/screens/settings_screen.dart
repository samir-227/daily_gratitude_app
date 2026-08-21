import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../bloc/settings_cubit.dart';
import '../bloc/theme_cubit.dart';
import '../../../home/presentation/bloc/home_cubit.dart';
import '../../../timeline/presentation/bloc/timeline_cubit.dart';
import '../../../analytics/presentation/bloc/analytics_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/di/injection.dart';
import '../widgets/settings_section_header.dart';
import '../widgets/settings_card.dart';
import '../widgets/settings_tiles.dart';
import '../widgets/reminder_time_picker.dart';
import '../widgets/clear_all_confirm_dialog.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _appVersion = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    if (mounted) setState(() => _appVersion = info.version);
  }

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
                context.read<HomeCubit>().refresh();
                context.read<TimelineCubit>().loadEntries();
                context.read<AnalyticsCubit>().loadAnalytics();
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
                return _buildSettingsList(context, state, brightness, _appVersion);
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
      BuildContext context, SettingsLoadedState state, Brightness brightness, String appVersion) {
    return ListView(
      padding: EdgeInsets.all(AppSpacing.standard),
      children: [
        SettingsSectionHeader(title: AppStrings.appearanceSection, brightness: brightness),
        SizedBox(height: AppSpacing.tight),
        BlocBuilder<ThemeCubit, Brightness>(
          builder: (context, themeBrightness) {
            final isDark = themeBrightness == Brightness.dark;
            return SettingsCard(brightness: brightness,
              children: [
                SettingsSwitchTile(
                  label: AppStrings.darkMode,
                  value: isDark,
                  onChanged: (val) => context.read<ThemeCubit>().toggleDarkMode(val),
                  brightness: brightness,
                ),
              ],
            );
          },
        ),
        SizedBox(height: AppSpacing.standard),
        SettingsSectionHeader(title: AppStrings.notificationsSection, brightness: brightness),
        SizedBox(height: AppSpacing.compact),
        SettingsCard(brightness: brightness,
          children: [
            SettingsSwitchTile(
              label: AppStrings.dailyReminder,
              value: state.notificationsEnabled,
              onChanged: (val) => context.read<SettingsCubit>().toggleNotifications(val),
              brightness: brightness,
            ),
            const SettingsDivider(),
            SettingsNavTile(
              label: AppStrings.reminderTime,
              onTap: () => showReminderTimePicker(context),
              brightness: brightness,
              isLast: true,
            ),
          ],
        ),
        SizedBox(height: AppSpacing.standard),
        SettingsSectionHeader(title: AppStrings.speechRecognitionSection, brightness: brightness),
        SizedBox(height: AppSpacing.compact),
        SettingsCard(brightness: brightness,
          children: [
            SettingsStatusTile(
              label: AppStrings.arabicDetection,
              statusText: state.hasArabicLocale ? 'ar-EG ✓' : AppStrings.notInstalled,
              statusColor: state.hasArabicLocale ? AppColors.success : AppColors.error,
              brightness: brightness,
            ),
          ],
        ),
        SizedBox(height: AppSpacing.standard),
        SettingsSectionHeader(title: AppStrings.dataSection, brightness: brightness),
        SizedBox(height: AppSpacing.compact),
        SettingsCard(brightness: brightness,
          children: [
            SettingsActionTile(
              label: AppStrings.exportEntries,
              icon: CupertinoIcons.share,
              iconColor: AppColors.primary,
              onTap: () => context.read<SettingsCubit>().exportEntries(),
              brightness: brightness,
            ),
            const SettingsDivider(),
            SettingsActionTile(
              label: AppStrings.clearAllData,
              icon: CupertinoIcons.delete,
              iconColor: AppColors.error,
              onTap: () => showClearAllConfirmDialog(context),
              brightness: brightness,
              isLast: true,
              isDestructive: true,
            ),
          ],
        ),
        SizedBox(height: AppSpacing.standard),
        SettingsSectionHeader(title: AppStrings.aboutSection, brightness: brightness),
        SizedBox(height: AppSpacing.compact),
        SettingsCard(brightness: brightness,
          children: [
            SettingsInfoTile(
              label: AppStrings.version,
              value: appVersion.isNotEmpty ? appVersion : '—',
              brightness: brightness,
            ),
            const SettingsDivider(),
            SettingsInfoTile(
              label: AppStrings.storageUsed,
              value: _formatBytes(state.storageUsedBytes),
              brightness: brightness,
              isLast: true,
            ),
          ],
        ),
        SizedBox(height: AppSpacing.spacious),
      ],
    );
  }

  static String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
