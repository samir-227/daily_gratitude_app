# Design System — Flutter Implementation Guide

## 1. Tokens Architecture

See live source of truth at `lib/core/theme/tokens/`:

| File | Class | Content |
|---|---|---|
| `app_colors.dart` | `AppColors` | Deep Emerald palette (`#0A7E6B`), Gold secondary (`#D4A574`), WCAG AA text, surfaces, emotion palette, state opacities |
| `app_typography.dart` | `AppTypography` | 11 Cairo text styles (`display`..`labelSmall`), separated from `google_fonts` |
| `app_spacing.dart` | `AppSpacing` | 4-pt system (`xxs 2px`..`giant 64px`) + compat aliases (`tight`, `standard`, `generous`) via `flutter_screenutil` |
| `app_radius.dart` | `AppRadius` | `none 0`, `tight 4`, `cozy 8`, `standard 12`, `generous 16`, `pill 999` |
| `app_elevation.dart` | `AppElevation` | Dark (neutral) and light (brand-tinted) shadow levels |
| `app_opacity.dart` | `AppOpacity` | State layer opacities + `StateLayer` extension on `Color` |

### `AppColorTheme` InheritedWidget

File: `lib/core/theme/theme_extensions.dart`

```dart
// Access all tokens in widgets via:
final colors = AppColorTheme.of(context);
// colors.primary, colors.surface, colors.textPrimary, etc.
```

### Theme Builder

File: `lib/core/theme/app_theme.dart`

```dart
CupertinoThemeData buildDarkTheme() {
  return CupertinoThemeData(
    primaryColor: AppColors.primary,                // #0A7E6B
    scaffoldBackgroundColor: AppColors.surface0,    // #0F1419
    barBackgroundColor: AppColors.surface1,         // #1A1F26
    textTheme: CupertinoTextThemeData(
      textStyle: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary),
    ),
  );
}
```

### Backward Compatibility

Old `lib/core/constants/app_colors.dart` and `app_theme.dart` re-export from new locations.
Old `AppColors.surface1Dark` style still works → resolves to `AppColors.surface1`.

---

## 5. Animations

File: `lib/core/constants/app_animations.dart`

```dart
class AppAnimations {
  static const fast = Duration(milliseconds: 150);
  static const normal = Duration(milliseconds: 300);
  static const slow = Duration(milliseconds: 500);

  static const easeOut = Curves.easeOutCubic;
  static const easeIn = Curves.easeInCubic;
  static const easeInOut = Curves.easeInOutCubic;

  /// Resolve duration for reduced motion
  static Duration resolveDuration(BuildContext context, Duration duration) {
    final level = CupertinoUserInterfaceLevel.maybeOf(context);
    return (level != null && level.reduceMotion) ? Duration.zero : duration;
  }
}
```

---

## 6. Shared Widgets

All located in `lib/shared/widgets/`. These are the actual production widgets used in the app:

| Widget | File | Purpose |
|---|---|---|
| `PrimaryButton` | `primary_button.dart` | Filled CTA with `AppColors.primary` background |
| `SecondaryButton` | `secondary_button.dart` | Outlined action button |
| `TertiaryButton` | `tertiary_button.dart` | Text-only ghost button |
| `GratitudeCard` | `gratitude_card.dart` | Entry list item card |
| `EmotionSelector` | `emotion_selector.dart` | Horizontal mood/emotion chips |
| `JournalTextField` | `journal_text_field.dart` | Multi-line Cupertino text input |
| `AppSnackbar` | `app_snackbar.dart` | Toast/notification overlay |
| `AppDialog` | `app_dialog.dart` | Confirmation/destructive action dialog |
| `AppBottomSheet` | `app_bottom_sheet.dart` | Draggable modal bottom sheet |
| `AppBottomNavBar` | `app_bottom_nav_bar.dart` | 5-tab iOS-style navigation bar |

All widgets use `AppColorTheme.of(context)` for tokens, `AppTypography` for text, and `AppSpacing`/`AppRadius` for layout.

---

## 7. Emotion Label System

File: `lib/core/constants/app_strings.dart`

English mood values are mapped to Arabic display labels:
```dart
static String moodLabel(String? mood) => switch (mood) {
  'grateful'   => 'ممتن ومبسوط',
  'joyful'     => 'مبسوط ومسرور',
  'calm'       => 'هادي وراضي',
  'peaceful'   => 'هادي وراضي',
  'loved'      => 'محبوب ومتطمن',
  'hopeful'    => 'متفائل وفي بالي حاجة',
  'grounded'   => 'مستقر وثابت',
  'reflective' => 'متأمل',
  _            => mood ?? '',
};
```

---

## 8. UiState Pattern

File: `lib/shared/ui_state.dart`

```dart
sealed class UiState<T> {
  const UiState();
}

final class Initial<T> extends UiState<T> {
  const Initial();
}

final class Loading<T> extends UiState<T> {
  const Loading();
}

final class Success<T> extends UiState<T> {
  final T data;
  const Success(this.data);
}

final class Error<T> extends UiState<T> {
  final Failure failure;
  const Error(this.failure);
}
```

---

## 9. Testing

```bash
flutter analyze          # 0 errors, 0 warnings (current state)
flutter test             # 5/5 tests passing
flutter test test/<file> # Run single test
```

---

**Implementation Guide v2.0 — Deep Emerald — `flutter analyze` clean**
