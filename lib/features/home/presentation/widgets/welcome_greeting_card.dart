import 'package:flutter/cupertino.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_theme.dart';

class WelcomeGreetingCard extends StatelessWidget {
  final Brightness brightness;

  const WelcomeGreetingCard({super.key, required this.brightness});

  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? AppStrings.morningGreeting
        : hour < 18
        ? AppStrings.afternoonGreeting
        : AppStrings.eveningGreeting;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(kSpace16, kSpace12, kSpace16, kSpace12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            AppColors.surface(1, brightness),
            AppColors.surface(2, brightness),
          ],
        ),
        borderRadius: BorderRadius.circular(AppRadius.generous),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            greeting,
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.onSurface(brightness),
            ),
          ),
          SizedBox(height: kSpace4),
          Text(
            AppStrings.greetingSubtext,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.onSurface(brightness, secondary: true),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
