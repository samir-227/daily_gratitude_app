import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../bloc/onboarding_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/di/injection.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<OnboardingCubit>(),
      child: BlocListener<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingCompleteState) {
            context.go('/home');
          }
        },
        child: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            if (state is OnboardingPageState) {
              return CupertinoPageScaffold(
                backgroundColor: AppColors.surface0,
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.generous),
                    child: Column(
                      children: [
                        _buildPageIndicator(state.page),
                        const Spacer(),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          child: _buildPage(state.page, context),
                        ),
                        const Spacer(),
                        _buildBottomButton(context, state),
                        SizedBox(height: AppSpacing.standard),
                      ],
                    ),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  static Widget _buildPageIndicator(int page) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: kSpace4),
          width: index == page ? kSpace32 : kSpace8,
          height: kSpace8,
          decoration: BoxDecoration(
            color: index == page ? AppColors.primary : AppColors.surface3,
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
        );
      }),
    );
  }

  static Widget _buildPage(int page, BuildContext context) {
    switch (page) {
      case 0:
        return _buildWelcomePage();
      case 1:
        return _buildHowItWorksPage();
      case 2:
        return _buildReminderPage(context);
      default:
        return _buildWelcomePage();
    }
  }

  static Widget _buildWelcomePage() {
    return Column(
      key: const ValueKey('welcome'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 120.w,
          height: 120.w,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary, AppColors.primaryDark],
            ),
            borderRadius: BorderRadius.circular(AppRadius.generous * 2),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 32,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: const Center(
            child: Icon(CupertinoIcons.heart_fill, size: 52, color: CupertinoColors.white),
          ),
        ),
        SizedBox(height: AppSpacing.spacious),
        Text(AppStrings.startJourney,
          style: AppTextStyles.display.copyWith(color: AppColors.textPrimary),
          textAlign: TextAlign.center),
        SizedBox(height: AppSpacing.standard),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.generous),
          child: Text(AppStrings.appSubtitle,
            style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center),
        ),
      ],
    );
  }

  static Widget _buildHowItWorksPage() {
    return Column(
      key: const ValueKey('howitworks'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppStrings.howItWorks,
          style: AppTextStyles.headline.copyWith(color: AppColors.textPrimary)),
        SizedBox(height: AppSpacing.spacious),
        _buildStep(
          icon: CupertinoIcons.mic_fill,
          color: AppColors.emotionPeace,
          title: AppStrings.record,
          subtitle: AppStrings.speakFreely,
        ),
        SizedBox(height: AppSpacing.generous),
        _buildStep(
          icon: CupertinoIcons.text_bubble_fill,
          color: AppColors.emotionJoy,
          title: AppStrings.reflect,
          subtitle: AppStrings.readReview,
        ),
        SizedBox(height: AppSpacing.generous),
        _buildStep(
          icon: CupertinoIcons.chart_pie_fill,
          color: AppColors.emotionLoved,
          title: AppStrings.grow,
          subtitle: AppStrings.watchGrow,
        ),
      ],
    );
  }

  static Widget _buildStep({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          width: 56.w,
          height: 56.w,
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(AppRadius.generous),
          ),
          child: Icon(icon, color: color, size: 26.w),
        ),
        SizedBox(width: AppSpacing.standard),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                style: AppTextStyles.titleSmall.copyWith(color: AppColors.textPrimary)),
              SizedBox(height: AppSpacing.compact),
              Text(subtitle,
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _buildReminderPage(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final s = state as OnboardingPageState;
        return Column(
          key: const ValueKey('reminder'),
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(CupertinoIcons.bell_fill,
                size: 44, color: AppColors.primary),
            ),
            SizedBox(height: AppSpacing.generous),
            Text(AppStrings.setReminder,
              style: AppTextStyles.headline.copyWith(color: AppColors.textPrimary),
              textAlign: TextAlign.center),
            SizedBox(height: AppSpacing.spacious),
            CupertinoButton(
              onPressed: () => _showTimePicker(context, s.reminderHour, s.reminderMinute),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacious, vertical: AppSpacing.standard),
                decoration: BoxDecoration(
                  color: AppColors.surface2,
                  borderRadius: BorderRadius.circular(AppRadius.standard),
                ),
                child: Text(
                  '${s.reminderHour.toString().padLeft(2, '0')}:${s.reminderMinute.toString().padLeft(2, '0')}',
                  style: AppTextStyles.display.copyWith(color: AppColors.primary)),
              ),
            ),
          ],
        );
      },
    );
  }

  static void _showTimePicker(BuildContext context, int hour, int minute) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 300.h,
        color: AppColors.surface1,
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
                initialDateTime: DateTime(2000, 1, 1, hour, minute),
                onDateTimeChanged: (dt) {
                  context.read<OnboardingCubit>().setReminderTime(dt.hour, dt.minute);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildBottomButton(BuildContext context, OnboardingPageState state) {
    String label;
    if (state.page == 0) {
      label = AppStrings.getStarted;
    } else if (state.page == 1) {
      label = AppStrings.soundsGood;
    } else {
      label = AppStrings.imReady;
    }

    return SizedBox(
      width: double.infinity,
      child: CupertinoButton.filled(
        borderRadius: BorderRadius.circular(AppRadius.standard),
        onPressed: () {
          if (state.page < 2) {
            context.read<OnboardingCubit>().nextPage();
          } else {
            context.read<OnboardingCubit>().completeOnboarding();
          }
        },
        child: Text(label,
          style: AppTextStyles.titleSmall.copyWith(
            color: CupertinoColors.white, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
