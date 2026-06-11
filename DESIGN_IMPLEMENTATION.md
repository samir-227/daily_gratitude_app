# Design System — Flutter Implementation Guide

## Setup Instructions

### 1. Add Design Token Dependencies

```yaml
# pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.6
  google_fonts: ^6.0.0
  flutter_bloc: ^8.1.3
  mocktail: ^1.0.0
  dartz: ^0.10.1
  
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_linter: ^3.0.0
```

---

## 2. Color System Implementation

### `lib/core/theme/app_colors.dart`

```dart
import 'package:flutter/cupertino.dart';

class AppColors {
  // Prevents instantiation
  AppColors._();

  // ━━━━━━━━━━━━━ BRAND PRIMARY ━━━━━━━━━━━━━
  
  /// Gratitude Green — Primary action color
  /// Used for: CTAs, success, active states, indicators
  static const Color primary = Color(0xFF2DD4A4);
  static const Color primaryLight = Color(0xFF3AE8B0);
  static const Color primaryDark = Color(0xFF10B981);
  
  // ━━━━━━━━━━━━━ DARK MODE SURFACES ━━━━━━━━━━━━━
  
  /// True black — Immersive background
  static const Color surface0Dark = Color(0xFF0F1419);
  
  /// Primary dark surface — Main content area
  static const Color surface1Dark = Color(0xFF1A1F26);
  
  /// Elevated cards & containers
  static const Color surface2Dark = Color(0xFF252D37);
  
  /// Floating action buttons & popovers
  static const Color surface3Dark = Color(0xFF2E3847);
  
  // ━━━━━━━━━━━━━ LIGHT MODE SURFACES ━━━━━━━━━━━━━
  
  static const Color surface0Light = Color(0xFFFAFBFC);
  static const Color surface1Light = Color(0xFFFFFFFF);
  static const Color surface2Light = Color(0xFFF3F4F6);
  static const Color surface3Light = Color(0xFFE5E7EB);
  
  // ━━━━━━━━━━━━━ TEXT — DARK MODE ━━━━━━━━━━━━━
  
  /// Primary text on dark — 95% opacity
  static const Color onSurfaceDarkPrimary = Color(0xFFE5E7EB);
  
  /// Secondary text — 70% opacity
  static const Color onSurfaceDarkSecondary = Color(0xFF9CA3AF);
  
  /// Tertiary text — 50% opacity
  static const Color onSurfaceDarkTertiary = Color(0xFF6B7280);
  
  // ━━━━━━━━━━━━━ TEXT — LIGHT MODE ━━━━━━━━━━━━━
  
  static const Color onSurfaceLightPrimary = Color(0xFF1F2937);
  static const Color onSurfaceLightSecondary = Color(0xFF6B7280);
  static const Color onSurfaceLightTertiary = Color(0xFF9CA3AF);
  
  // ━━━━━━━━━━━━━ DIVIDERS & BORDERS ━━━━━━━━━━━━━
  
  static const Color outlineDark = Color(0xFF374151);
  static const Color outlineLight = Color(0xFFE5E7EB);
  
  // ━━━━━━━━━━━━━ EMOTION PALETTE ━━━━━━━━━━━━━
  
  static const Color emotionJoy = Color(0xFFFFD85C);       // 🎯 Joy/Grateful (Warm Yellow)
  static const Color emotionPeace = Color(0xFF5B9BD5);    // 😌 Peaceful (Soft Blue)
  static const Color emotionLove = Color(0xFFE85A8F);     // 💗 Loved (Rose Pink)
  static const Color emotionHope = Color(0xFFA78BFA);     // 🌟 Hopeful (Lavender)
  static const Color emotionGround = Color(0xFF84A366);   // 🌿 Grounded (Sage Green)
  
  // ━━━━━━━━━━━━━ STATUS COLORS ━━━━━━━━━━━━━
  
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
  
  // ━━━━━━━━━━━━━ HELPER GETTERS ━━━━━━━━━━━━━
  
  /// Get surface color based on brightness
  static Color getSurface(Brightness brightness, int level) {
    return brightness == Brightness.dark
        ? _getSurfaceDark(level)
        : _getSurfaceLight(level);
  }
  
  static Color _getSurfaceDark(int level) => switch (level) {
    0 => surface0Dark,
    1 => surface1Dark,
    2 => surface2Dark,
    3 => surface3Dark,
    _ => surface1Dark,
  };
  
  static Color _getSurfaceLight(int level) => switch (level) {
    0 => surface0Light,
    1 => surface1Light,
    2 => surface2Light,
    3 => surface3Light,
    _ => surface1Light,
  };
  
  /// Get text color based on brightness
  static Color getOnSurface(Brightness brightness, {bool secondary = false}) {
    if (brightness == Brightness.dark) {
      return secondary ? onSurfaceDarkSecondary : onSurfaceDarkPrimary;
    }
    return secondary ? onSurfaceLightSecondary : onSurfaceLightPrimary;
  }
}
```

---

## 3. Typography System

### `lib/core/theme/app_typography.dart`

```dart
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  AppTypography._();

  // ━━━━━━━━━━━━━ TEXT STYLES ━━━━━━━━━━━━━
  
  static TextStyle display = GoogleFonts.cairo(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 40 / 32, // 1.25
    letterSpacing: -0.5,
  );

  static TextStyle headline = GoogleFonts.cairo(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 36 / 28, // 1.29
    letterSpacing: -0.3,
  );

  static TextStyle titleLarge = GoogleFonts.cairo(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 32 / 24, // 1.33
  );

  static TextStyle titleMedium = GoogleFonts.cairo(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 28 / 20, // 1.4
    letterSpacing: 0.1,
  );

  static TextStyle titleSmall = GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 24 / 16, // 1.5
    letterSpacing: 0.1,
  );

  static TextStyle bodyLarge = GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16, // 1.5
    letterSpacing: 0.5,
  );

  static TextStyle bodyMedium = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14, // 1.43
    letterSpacing: 0.25,
  );

  static TextStyle bodySmall = GoogleFonts.cairo(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 16 / 12, // 1.33
    letterSpacing: 0.4,
  );

  static TextStyle labelLarge = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 20 / 14, // 1.43
    letterSpacing: 0.1,
  );

  static TextStyle labelMedium = GoogleFonts.cairo(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 16 / 12, // 1.33
    letterSpacing: 0.5,
  );

  static TextStyle labelSmall = GoogleFonts.cairo(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 14 / 11, // 1.27
    letterSpacing: 0.5,
  );
  
  // ━━━━━━━━━━━━━ THEME DATA ━━━━━━━━━━━━━
  
  static CupertinoTextThemeData buildDarkTheme() {
    return CupertinoTextThemeData(
      primaryColor: AppColors.primary,
      textStyle: bodyLarge.copyWith(color: AppColors.onSurfaceDarkPrimary),
      actionTextStyle: titleSmall.copyWith(color: AppColors.primary),
      tabLabelTextStyle: labelSmall.copyWith(color: AppColors.onSurfaceDarkSecondary),
      navActionTextStyle: titleSmall.copyWith(color: AppColors.primary),
      navLargeTitleTextStyle: headline.copyWith(color: AppColors.onSurfaceDarkPrimary),
      navTitleTextStyle: titleLarge.copyWith(color: AppColors.onSurfaceDarkPrimary),
      pickerTextStyle: bodyLarge.copyWith(color: AppColors.onSurfaceDarkPrimary),
      dateTimePickerTextStyle: bodyLarge.copyWith(color: AppColors.onSurfaceDarkPrimary),
    );
  }
  
  static CupertinoTextThemeData buildLightTheme() {
    return CupertinoTextThemeData(
      primaryColor: AppColors.primary,
      textStyle: bodyLarge.copyWith(color: AppColors.onSurfaceLightPrimary),
      actionTextStyle: titleSmall.copyWith(color: AppColors.primary),
      tabLabelTextStyle: labelSmall.copyWith(color: AppColors.onSurfaceLightSecondary),
      navActionTextStyle: titleSmall.copyWith(color: AppColors.primary),
      navLargeTitleTextStyle: headline.copyWith(color: AppColors.onSurfaceLightPrimary),
      navTitleTextStyle: titleLarge.copyWith(color: AppColors.onSurfaceLightPrimary),
      pickerTextStyle: bodyLarge.copyWith(color: AppColors.onSurfaceLightPrimary),
      dateTimePickerTextStyle: bodyLarge.copyWith(color: AppColors.onSurfaceLightPrimary),
    );
  }
}
```

---

## 4. Spacing & Border Radius Tokens

### `lib/core/theme/app_tokens.dart`

```dart
class AppSpacing {
  AppSpacing._();
  
  static const double compact = 4;    // Internal padding
  static const double tight = 8;      // Small gaps
  static const double cozy = 12;      // Input field padding
  static const double standard = 16;  // Card padding
  static const double generous = 24;  // Section breaks
  static const double spacious = 32;  // Full-screen margins
  static const double abundant = 48;  // Top/bottom breathing room
}

class AppBorderRadius {
  AppBorderRadius._();
  
  static const double tight = 4;
  static const double cozy = 8;
  static const double standard = 12;
  static const double generous = 16;
  static const double pill = 999;
}

class AppElevation {
  AppElevation._();
  
  /// Subtle elevation for hover states
  static const BoxShadow elevation1 = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.20),
    blurRadius: 8,
    offset: Offset(0, 2),
  );
  
  /// Medium elevation for modals, elevated buttons
  static const BoxShadow elevation2 = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.25),
    blurRadius: 16,
    offset: Offset(0, 4),
  );
  
  /// High elevation for FAB, floating elements
  static const BoxShadow elevation3 = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.30),
    blurRadius: 24,
    offset: Offset(0, 8),
  );
}
```

---

## 5. Build Cupertino Theme

### `lib/core/theme/app_theme.dart`

```dart
import 'package:flutter/cupertino.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'app_tokens.dart';

class AppTheme {
  AppTheme._();

  static CupertinoThemeData buildDarkTheme() {
    return CupertinoThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      primaryContrastingColor: CupertinoColors.white,
      scaffoldBackgroundColor: AppColors.surface0Dark,
      barBackgroundColor: AppColors.surface1Dark,
      textTheme: AppTypography.buildDarkTheme(),
    );
  }

  static CupertinoThemeData buildLightTheme() {
    return CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      primaryContrastingColor: CupertinoColors.white,
      scaffoldBackgroundColor: AppColors.surface0Light,
      barBackgroundColor: AppColors.surface1Light,
      textTheme: AppTypography.buildLightTheme(),
    );
  }
}
```

---

## 6. Animation Curves & Durations

### `lib/core/animations/app_animations.dart`

```dart
import 'package:flutter/animation.dart';

class AppAnimations {
  AppAnimations._();

  // ━━━━━━━━━━━━━ DURATIONS ━━━━━━━━━━━━━
  
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration verySlow = Duration(milliseconds: 1000);

  // ━━━━━━━━━━━━━ CURVES ━━━━━━━━━━━━━
  
  static const Curve easeOut = Curves.easeOutCubic;
  static const Curve easeIn = Curves.easeInCubic;
  static const Curve easeInOut = Curves.easeInOutCubic;
  static const Curve elasticOut = Curves.elasticOut;
  static const Curve springOut = Curves.elasticOut;
  
  // ━━━━━━━━━━━━━ BUTTON PRESS ANIMATION ━━━━━━━━━━━━━
  
  /// Button scales from 1.0 → 0.98 on press
  static Tween<double> buttonPressTween = Tween(begin: 1.0, end: 0.98);
  
  // ━━━━━━━━━━━━━ EMOTION CHIP SELECTION ━━━━━━━━━━━━━
  
  /// Chip scales from 1.0 → 1.15 (peak) → 1.08 (settle)
  static Tween<double> emotionChipTween = Tween(begin: 1.0, end: 1.15);
  
  // ━━━━━━━━━━━━━ TRANSITION ANIMATIONS ━━━━━━━━━━━━━
  
  static Tween<Offset> slideFromRight = Tween(
    begin: Offset(1.0, 0.0),
    end: Offset.zero,
  );
  
  static Tween<Offset> slideFromLeft = Tween(
    begin: Offset(-1.0, 0.0),
    end: Offset.zero,
  );
  
  static Tween<double> fadeIn = Tween(begin: 0.0, end: 1.0);
}
```

---

## 7. Reusable Button Components

### `lib/shared/widgets/buttons/primary_button.dart`

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/animations/app_animations.dart';

class PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool isDisabled;

  const PrimaryButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isDisabled = false,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppAnimations.fast,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    
    return GestureDetector(
      onTapDown: widget.isDisabled || widget.isLoading
          ? null
          : (_) {
              _controller.forward();
              HapticFeedback.mediumImpact();
            },
      onTapUp: widget.isDisabled || widget.isLoading
          ? null
          : (_) {
              _controller.reverse();
              widget.onPressed();
            },
      onTapCancel: widget.isDisabled || widget.isLoading
          ? null
          : () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            gradient: widget.isDisabled
                ? LinearGradient(
                    colors: [
                      AppColors.primary.withOpacity(0.5),
                      AppColors.primaryDark.withOpacity(0.5),
                    ],
                  )
                : LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            borderRadius: BorderRadius.circular(AppBorderRadius.standard),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.isLoading)
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CupertinoActivityIndicator(
                    color: CupertinoColors.white,
                  ),
                )
              else if (widget.icon != null) ...[
                Icon(widget.icon, color: CupertinoColors.white, size: 20),
                SizedBox(width: AppSpacing.tight),
              ],
              Text(
                widget.label,
                style: AppTypography.titleSmall.copyWith(
                  color: CupertinoColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

### `lib/shared/widgets/buttons/secondary_button.dart`

```dart
import 'package:flutter/cupertino.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_tokens.dart';

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  const SecondaryButton({
    required this.label,
    this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          border: Border.all(
            color: onPressed == null
                ? AppColors.outlineDark.withOpacity(0.3)
                : AppColors.primary,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(AppBorderRadius.standard),
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: AppColors.primary, size: 18),
              SizedBox(width: AppSpacing.tight),
            ],
            Text(
              label,
              style: AppTypography.titleSmall.copyWith(
                color: onPressed == null
                    ? AppColors.outlineDark.withOpacity(0.5)
                    : AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 8. Reusable Card Component

### `lib/shared/widgets/cards/gratitude_card.dart`

```dart
import 'package:flutter/cupertino.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_tokens.dart';

class GratitudeCard extends StatefulWidget {
  final String gratitudeText;
  final DateTime recordedAt;
  final String emotion;
  final List<String> categories;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const GratitudeCard({
    required this.gratitudeText,
    required this.recordedAt,
    required this.emotion,
    required this.categories,
    required this.onTap,
    this.onDelete,
  });

  @override
  State<GratitudeCard> createState() => _GratitudeCardState();
}

class _GratitudeCardState extends State<GratitudeCard> {
  late AnimationController _hoverController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.all(AppSpacing.standard),
        margin: EdgeInsets.only(bottom: AppSpacing.cozy),
        decoration: BoxDecoration(
          color: AppColors.surface2Dark,
          borderRadius: BorderRadius.circular(AppBorderRadius.standard),
          boxShadow: [AppElevation.elevation2],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatTime(widget.recordedAt),
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.onSurfaceDarkSecondary,
                  ),
                ),
                Text(widget.emotion, style: TextStyle(fontSize: 18)),
              ],
            ),
            SizedBox(height: AppSpacing.tight),
            Text(
              widget.gratitudeText,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.onSurfaceDarkPrimary,
              ),
            ),
            SizedBox(height: AppSpacing.tight),
            Wrap(
              spacing: AppSpacing.tight,
              runSpacing: AppSpacing.tight,
              children: widget.categories
                  .map((cat) => Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.tight,
                          vertical: AppSpacing.compact,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.15),
                          borderRadius:
                              BorderRadius.circular(AppBorderRadius.tight),
                        ),
                        child: Text(
                          cat,
                          style: AppTypography.labelMedium.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'للتو';
    } else if (difference.inMinutes < 60) {
      return 'منذ ${difference.inMinutes} دقيقة';
    } else if (difference.inHours < 24) {
      return 'منذ ${difference.inHours} ساعة';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }
}
```

---

## 9. Building the Main App with Theme

### `lib/main.dart`

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

void main() async {
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: CupertinoApp(
        title: 'امتنان يومي | Daily Gratitude',
        locale: const Locale('ar'),
        supportedLocales: const [
          Locale('ar'),
          Locale('en'),
        ],
        theme: AppTheme.buildDarkTheme(), // Dark mode by default
        home: MultiBlocProvider(
          providers: [
            // Add all cubits here
            BlocProvider(create: (_) => sl<TimelineCubit>()),
            BlocProvider(create: (_) => sl<RecordingCubit>()),
            BlocProvider(create: (_) => sl<AnalyticsCubit>()),
            // ... other cubits
          ],
          child: MainNavigationScreen(),
        ),
      ),
    );
  }
}
```

---

## 10. Component Testing Checklist

- [ ] **Buttons:** Test press animation, haptic feedback, disabled state
- [ ] **Cards:** Verify shadow depth, typography hierarchy, spacing
- [ ] **Colors:** Validate contrast ratios in both light & dark modes
- [ ] **Typography:** Check line heights, letter spacing on all text sizes
- [ ] **RTL:** Confirm all text/icons flow right-to-left correctly
- [ ] **Accessibility:** Test with VoiceOver, semantic labels
- [ ] **Animations:** Verify smooth transitions, no janky frames
- [ ] **Haptics:** Confirm feedback on button press, chip selection
- [ ] **Dark Mode:** Test all screens in both modes

---

## Next Steps for Development Team

1. **Create color palette in Figma** using hex codes from `AppColors`
2. **Build component library** in `lib/shared/widgets/` with all patterns
3. **Implement theme switching** (dark/light mode toggle in settings)
4. **Test on device** with iPhone 14/15 Pro simulators
5. **Gather UX feedback** on recording flow and timeline navigation
6. **Iterate on micro-interactions** based on testing
7. **Prepare for App Store submission** with premium screenshots

---

**Implementation Guide v1.0 — Ready for Flutter Development**
