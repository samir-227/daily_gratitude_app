# Visual Design Reference — Quick Start Guide

## DESIGN SYSTEM AT A GLANCE

### Color Palette (Dark Mode Primary)

```
PRIMARY BRAND
  Gratitude Green:  #2DD4A4  ■■■■■■■■■■ Primary Action
  
NEUTRAL SURFACES
  Dark 0 (BG):      #0F1419  ■■■■■■■■■■ True Black Background
  Dark 1 (Surface): #1A1F26  ■■■■■■■■■■ Primary Surface
  Dark 2 (Cards):   #252D37  ■■■■■■■■■■ Elevated Cards
  Dark 3 (Float):   #2E3847  ■■■■■■■■■■ Floating Elements
  
TEXT HIERARCHY
  Primary:          #E5E7EB  ■■■■■■■■■■ Main Text (95%)
  Secondary:        #9CA3AF  ■■■■■■■■■■ Metadata (70%)
  Tertiary:         #6B7280  ■■■■■■■■■■ Disabled (50%)
  
EMOTION COLORS
  Joy/Grateful:     #FFD85C  ■■■■■■■■■■ Warm Yellow
  Peaceful:         #5B9BD5  ■■■■■■■■■■ Soft Blue
  Loved:            #E85A8F  ■■■■■■■■■■ Rose Pink
  Hopeful:          #A78BFA  ■■■■■■■■■■ Lavender
  Grounded:         #84A366  ■■■■■■■■■■ Sage Green
  
STATUS
  Success:          #10B981  ■■■■■■■■■■ Green
  Warning:          #F59E0B  ■■■■■■■■■■ Orange
  Error:            #EF4444  ■■■■■■■■■■ Red
```

---

## TYPOGRAPHY QUICK REFERENCE

```
Display       32px Bold       "امتنان يومي"
Headline      28px Bold       "شاشة العنوان"
Title Large   24px Semibold   "عنوان القسم"
Title Medium  20px Semibold   "عنوان ثانوي"
Title Small   16px Semibold   "تسميات الأزرار"
Body Large    16px Regular    "نص الشكر الرئيسي"
Body Medium   14px Regular    "نص بيانات"
Body Small    12px Regular    "توقيتات، تسميات"
Label Large   14px Semibold   "شرائط، شارات"
Label Medium  12px Semibold   "أزرار صغيرة"
Label Small   11px Semibold   "شارات صغيرة جداً"
```

**Font:** Cairo (Google Fonts)  
**All in Arabic-first RTL context**

---

## SPACING SYSTEM

```
Compact:    4px    ■ Internal padding
Tight:      8px    ■ Small gaps
Cozy:      12px    ■ Input fields
Standard:  16px    ■ Card padding (DEFAULT)
Generous:  24px    ■ Section breaks
Spacious:  32px    ■ Full-screen margins
Abundant:  48px    ■ Top/bottom breathing room

Grid Base:  4px (all measurements align to 4px grid)
```

---

## COMPONENT SIZES (Quick Reference)

| Component | Height | Width | Radius | Notes |
|-----------|--------|-------|--------|-------|
| Primary Button | 52px | Auto | 12px | Green gradient, white text |
| Secondary Button | 44px | Auto | 12px | Outlined, no fill |
| Icon Button | 44px | 44px | 8px | Compact action |
| Text Input | 48px | Full | 12px | 16px padding |
| Gratitude Card | 80px+ | Full | 12px | List item |
| Stat Card | 100px+ | Full | 12px | Analytics |
| FAB | 56px | 56px | 999px | Green gradient, fixed |
| Tab Bar | 56px | Full | 0px | Fixed bottom |

---

## SHADOW SYSTEM (Elevation)

```
Elevation 1 (Subtle):
  Blur:  8px
  Y-Offset: 2px
  Opacity: 20% black
  Usage: Hover states, slight lift

Elevation 2 (Medium):
  Blur: 16px
  Y-Offset: 4px
  Opacity: 25% black
  Usage: Cards, modals, buttons

Elevation 3 (High):
  Blur: 24px
  Y-Offset: 8px
  Opacity: 30% black
  Usage: FAB, floating elements, toasts
```

---

## ANIMATION TIMING

```
Fast:     150ms     Button press, chip selection
Normal:   300ms     Screen transitions, modal entry
Slow:     500ms     Complex sequences
Very Slow: 1000ms   Breathing pulses, intro animations

Curves:
  easeOut:      Fast start, smooth deceleration
  easeIn:       Slow start, fast deceleration
  easeInOut:    Smooth throughout
  elasticOut:   Spring, slight overshoot (60% elasticity)
  linear:       Audio playback, progress bars
```

---

## SCREEN LAYOUT CHECKLIST

### 🏠 HOME DASHBOARD

```
✓ Greeting card (time-aware)
✓ Gratitude counter (today's count)
✓ Primary CTA ("سجل شكرك" button)
✓ Daily reflection prompt
✓ Recent gratitudes carousel
✓ 7-day streak ring
```

**Key Emotion:** Warm, welcoming, motivating

### 🎤 RECORDING MODAL

```
✓ Drag handle (dismissible)
✓ Progress indicator (1/3, 2/3, 3/3)
✓ Record button (80px, green, waveform)
✓ Optional text input
✓ Emotion chip selector
✓ Category tags (optional)
✓ Photo attachment (optional)
✓ Review summary
✓ Save button (primary CTA)
```

**Key Emotion:** Focused, calm, encouraging

### 📅 TIMELINE

```
✓ Month calendar with heat-map dots
✓ Search bar + filter chips
✓ Chronological list view
✓ Gratitude cards (swipeable)
✓ Detail page (full metadata + audio)
✓ Edit/delete actions
```

**Key Emotion:** Exploratory, reflective

### 📊 ANALYTICS DASHBOARD

```
✓ Stat cards (count, streak, completion %)
✓ Emotion distribution pie chart
✓ Weekly trend line graph
✓ Category breakdown bar chart
✓ AI insights section
✓ Export data button
```

**Key Emotion:** Insightful, motivating

### ⚙️ SETTINGS

```
✓ Profile section
✓ Notification preferences
✓ Appearance (dark mode toggle)
✓ Backup & sync options
✓ Privacy controls
✓ About & help
✓ Danger zone (logout, delete account)
```

**Key Emotion:** Controlled, private

---

## INTERACTION PATTERNS

### Button Press
```
Idle:    Scale 1.00
Press:   Scale 0.98 (150ms spring)
Release: Scale 1.00
Haptic:  Medium impact
Color:   Slightly darker while pressed
```

### Chip Selection
```
Idle:        Scale 1.00, opacity 0.7
Tap:         Scale 1.15 (peak)
Settle:      Scale 1.08 (final)
Ring:        Appear with glow
Haptic:      Light feedback
Duration:    200ms elasticOut
```

### Screen Transition
```
Incoming:    Slide from right (RTL: left) + fade in
Outgoing:    Slide to right (RTL: right)
Dimmer:      Fade from 0% → 20% opacity
Duration:    300ms easeOutCubic
Haptic:      None
```

### List Item Swipe
```
Swipe Left:  Red "delete" zone revealed
Swipe Right: Archive/save action
Duration:    200ms reveal, 300ms action
Haptic:      Medium warning before delete
Confirm:     Dialog or haptic triple-tap
```

---

## ACCESSIBILITY SPECS

### Semantic Labels (Arabic Examples)

```
Button:    "احفظ الشكر" (Save gratitude)
Delete:    "حذف الشكر (لا يمكن التراجع)" (Delete - no undo)
Record:    "اضغط لتسجيل شكرك" (Tap to record gratitude)
Close:     "إغلاق الشاشة" (Close screen)
Home:      "الشاشة الرئيسية" (Home screen)
```

### High Contrast Mode

```
Dark:       Increase contrast (darker blacks, brighter greens)
Text:       Increase font weight (+100)
Borders:    Increase stroke width (1px → 2px)
Shadows:    Increase blur (8px → 12px)
```

### Reduced Motion

```
If iOS setting enabled:
  ✓ All animations disabled (instant)
  ✓ Transitions fade-only (no slide)
  ✓ Haptic feedback only
  ✓ No auto-play animations
```

---

## DARK MODE COLOR MAPPING

```
Component              Light Mode         Dark Mode (Primary)
────────────────────────────────────────────────────────────
Background             #FAFBFC           #0F1419
Primary Surface        #FFFFFF           #1A1F26
Secondary Surface      #F3F4F6           #252D37
Primary Text           #1F2937           #E5E7EB
Secondary Text         #6B7280           #9CA3AF
Primary Action         #10B981           #2DD4A4
Card Shadow            8% black opacity  25% black opacity
Dividers               #E5E7EB           #374151
```

---

## RESPONSIVE BREAKPOINTS

```
Compact (<400px):     iPhone SE — Reduce padding to 12px
Standard (400–430px): Most iPhones — 16px padding
Large (>430px):       Plus/Pro Max — 16px padding (same)

Safe Areas:
  Top:    Respect status bar + notch/Dynamic Island
  Bottom: Respect home indicator (56px min)
  Side:   16px minimum margin all screens
```

---

## TESTING CHECKLIST

- [ ] Colors validated with hex picker (exact matches)
- [ ] Typography line heights measured (no overlap)
- [ ] Shadows layered (no muddy depth)
- [ ] Spacing uses 4px grid (no arbitrary values)
- [ ] Animations smooth at 60fps (no janky frames)
- [ ] Haptics triggered (button, chip, confirmation)
- [ ] RTL rendering correct (text, icons, layout)
- [ ] VoiceOver labels complete (Arabic + English)
- [ ] Contrast ratios ≥ 4.5:1 (WCAG AA)
- [ ] Dark mode tested extensively
- [ ] Light mode tested (not primary, but supported)
- [ ] Responsive tested on SE, 14, 14 Pro, 14 Pro Max

---

## COMPONENT PATTERNS (Reusable)

### Button Pattern
```dart
PrimaryButton(
  label: "احفظ الشكر",
  icon: CupertinoIcons.checkmark,
  onPressed: () => saveGratitude(),
)
```

### Card Pattern
```dart
GratitudeCard(
  gratitudeText: "شكرت على دعم أسرتي",
  recordedAt: DateTime.now(),
  emotion: "😊 مسرور",
  categories: ["صحة", "أسرة"],
  onTap: () => showDetails(),
)
```

### Input Pattern
```dart
CupertinoTextField(
  placeholder: "ابحث عن شكر...",
  decoration: BoxDecoration(
    border: Border.all(color: AppColors.outlineDark),
    borderRadius: BorderRadius.circular(AppBorderRadius.standard),
  ),
)
```

---

## DESIGN TOKENS (Code-Ready)

### Colors
```dart
AppColors.primary              // #2DD4A4
AppColors.surface1Dark         // #1A1F26
AppColors.onSurfaceDarkPrimary // #E5E7EB
AppColors.emotionJoy           // #FFD85C
```

### Typography
```dart
AppTypography.display          // 32px Bold
AppTypography.bodyLarge        // 16px Regular
AppTypography.labelSmall       // 11px Semibold
```

### Spacing
```dart
AppSpacing.standard            // 16px
AppSpacing.generous            // 24px
AppSpacing.abundant            // 48px
```

### Border Radius
```dart
AppBorderRadius.standard       // 12px
AppBorderRadius.pill           // 999px (FAB)
```

### Animations
```dart
AppAnimations.normal           // 300ms
AppAnimations.easeOut          // Curves.easeOutCubic
AppAnimations.buttonPressTween // 1.0 → 0.98
```

---

## HANDOFF CHECKLIST FOR DEVELOPMENT

- [ ] **Assets:** Download all icon SVGs at 24px size
- [ ] **Fonts:** Add Cairo from Google Fonts
- [ ] **Colors:** Implement token system in `AppColors`
- [ ] **Typography:** Build style system in `AppTypography`
- [ ] **Components:** Create reusable widgets in `lib/shared/`
- [ ] **Theme:** Build dark theme in `AppTheme`
- [ ] **Animations:** Define curves/durations in `AppAnimations`
- [ ] **Testing:** Verify all specs on device
- [ ] **Accessibility:** Audit with VoiceOver

---

## PREMIUM DIFFERENTIATORS SUMMARY

| Aspect | Daily Gratitude | Competitors |
|--------|---|---|
| **Language** | Arabic-first RTL | English or untranslated |
| **Recording** | Voice + visual waveform | Text only or limited audio |
| **Analytics** | Emotion + category trends | Basic counting |
| **Dark Mode** | Premium true black (#0F1419) | Standard dark grey |
| **Haptics** | Extensive feedback | Minimal or none |
| **Wellness** | No gamification streaks | Streak-based |
| **Design** | Apple Journal + Headspace | Generic journaling UI |
| **Accessibility** | Full semantic labels | Limited |

---

## LAUNCH READINESS

**App Store Listing:**
- Premium positioning ($4.99 or subscription)
- Arabic + English description
- Screenshots showcasing recording flow
- Icon with green gradient (primary color)
- Testimonials: "الأفضل للامتنان اليومي"

**Beta Feedback Focus:**
- Recording experience smoothness
- Dark mode refinement
- Analytics insights relevance
- RTL text handling edge cases

**First Update Post-Launch:**
- AI-generated insights ("You're grateful for family 45% of the time")
- Cloud sync with iCloud backup
- Sharing gratitudes (privacy-controlled)
- Custom emotion colors option

---

## VISUAL HIERARCHY SUMMARY

### Mega Priority (User's Eye First)
- Primary CTA button (green, large, prominent)
- Large gratitude counter
- Recording button with waveform

### High Priority
- Section titles
- Gratitude cards
- Emotion chips (when available)

### Medium Priority
- Metadata (timestamps, categories)
- Secondary buttons
- Analytics labels

### Low Priority
- Tertiary text
- Disabled elements
- Helper text

---

**Design System Reference v1.0**  
**Print this page for quick reference during development**

For detailed specifications, see:
- `DESIGN_SYSTEM.md` (complete specs)
- `DESIGN_IMPLEMENTATION.md` (Flutter code)
- `COMPONENT_SPECS.md` (detailed dimensions)
- `RECORDING_EXPERIENCE.md` (core feature deep-dive)
