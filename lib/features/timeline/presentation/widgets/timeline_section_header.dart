import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_theme.dart';

class TimelineSectionHeader extends StatelessWidget {
  final String header;
  final Brightness brightness;

  const TimelineSectionHeader({
    super.key,
    required this.header,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(kSpace16, kSpace16, kSpace16, kSpace8),
      child: Row(
        children: [
          Container(
            width: 3.w,
            height: 16.h,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          SizedBox(width: kSpace8),
          Text(header,
            style: AppTextStyles.titleSmall.copyWith(
              color: AppColors.onSurface(brightness), fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
