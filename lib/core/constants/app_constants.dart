import 'package:flutter_screenutil/flutter_screenutil.dart';

const String kEntriesBox = 'gratitude_entries';
const String kStatsBox = 'user_stats';
const String kSettingsBox = 'app_settings';

const String kOnboardingComplete = 'onboarding_complete';
const String kReminderTime = 'reminder_time';
const String kNotificationsEnabled = 'notifications_enabled';
const String kLastMilestoneShown = 'last_milestone_shown';
const String kDarkModeEnabled = 'dark_mode_enabled';

const String kArabicLocaleEG = 'ar-EG';
const String kArabicLocaleSA = 'ar-SA';

double get kBorderRadius => 16.0.r;
double get kSpace4 => 4.0.w;
double get kSpace6 => 6.0.w;
double get kSpace8 => 8.0.w;
double get kSpace10 => 10.0.w;
double get kSpace12 => 12.0.w;
double get kSpace16 => 16.0.w;
double get kSpace20 => 20.0.w;
double get kSpace24 => 24.0.w;
double get kSpace32 => 32.0.w;
double get kSpace48 => 48.0.w;
double get kSpace64 => 64.0.w;

double get kButtonHeight => 52.0.h;
double get kIconSize => 24.0.w;
double get kRecordButtonSize => 80.0.w;
double get kFABSize => 56.0.w;

const Duration kMaxRecordingDuration = Duration(minutes: 3);
const Duration kPauseDuration = Duration(seconds: 20);

const List<int> kMilestones = [3, 7, 14, 30, 60, 100];

const String kAppName = 'Daily Gratitude';
