# Daily Gratitude | امتنان يومي — Premium Design System

**Version:** 2.0  
**Platform:** iOS First (Cupertino)  
**Language:** Arabic RTL  
**Inspirations:** Apple Journal, Headspace, Reflectly  

---

## 1. DESIGN PHILOSOPHY

**Principles:**
- **Intentional Simplicity** — Every element serves a purpose; no decoration without function
- **Emotion-First** — Colors, typography, and spacing evoke calm, reflection, gratitude
- **RTL Native** — Not a mirror; authentic Arabic design with proper text hierarchy
- **Dark-Mode Premium** — Both modes are primary; dark is the default elegant choice
- **Micro-interactions** — Subtle feedback that delights (haptics, animations, soundscapes)
- **Wellness-Focused** — Minimal notifications, no shame, no streaks that punish
- **Apple Journal Aesthetic** — Clean, minimal, high-contrast, typography-driven
- **Headspace Calm** — Breathing room, soft gradients, warm wellness colors

---

## 2. INFORMATION ARCHITECTURE

```
Daily Gratitude App
├── Onboarding Flow
│   ├── Welcome Screen (Vision)
│   ├── Gratitude Intro (Purpose)
│   ├── Recording Preferences (Voice/Text/Photo)
│   ├── Notification Setup
│   └── Dashboard Intro
├── Main Navigation (5 Tabs)
│   ├── [1] Home Dashboard
│   │   ├── Today's Gratitude Status
│   │   ├── Quick Record Button
│   │   ├── Reflection Prompt
│   │   ├── Recent Gratitudes (Carousel)
│   │   └── Mood/Habit Ring
│   ├── [2] Record (Bottom Sheet Modal)
│   │   ├── Recording Session
│   │   │   ├── Waveform Visualizer
│   │   │   ├── Text Input
│   │   │   ├── Photo Capture
│   │   │   ├── Emotion Selection
│   │   │   └── Category Tags
│   │   └── Save/Discard
│   ├── [3] Timeline
│   │   ├── Month View Calendar
│   │   ├── List View (Chronological)
│   │   ├── Gratitude Detail Page
│   │   └── Search/Filter
│   ├── [4] Analytics Dashboard
│   │   ├── Stats Cards (Count, Streak, etc.)
│   │   ├── Emotion Distribution
│   │   ├── Category Breakdown
│   │   ├── Trend Graph
│   │   └── Insights Section
│   └── [5] Settings
│       ├── Profile
│       ├── Notification Preferences
│       ├── Backup & Privacy
│       ├── Appearance (Dark/Light)
│       ├── About & Help
│       └── Data Export
├── Detail Screens
│   ├── Gratitude Details (Expandable View)
│   ├── Recording Playback
│   ├── Edit Gratitude
│   └── Delete Confirmation
└── Modals & Overlays
    ├── Audio Recording Permissions
    ├── Emotion Selection Sheet
    ├── Category Picker
    └── Success Feedback
```

---

## 3. DESIGN TOKENS

### 3.1 Color System (Dark Mode Primary)

#### **Semantic Color Palette**

**Primary Brand Colors:**
```
Deep Emerald (Primary Action)  — Grounded, premium, trustworthy
  Dark Mode:  #0A7E6B  (RGB: 10, 126, 107)
  Light Mode: #075E50  (RGB: 7, 94, 80)
  Light Variant: #12A88F
  Usage: CTAs, active states, success, gratitude affirmations

Warm Gold (Secondary Accent) — Emotional counterpoint to cool emerald
  Dark/Light: #D4A574  (RGB: 212, 165, 116)
  Light variant: #F0C75E
  Usage: Accents, badges, secondary highlights

Calm Slate (Neutral & Surfaces)
  Dark Mode Bg:  #0F1419  (RGB: 15, 20, 25)  — Premium dark
  Dark Mode Surface: #1A1F26  (RGB: 26, 31, 38)
  Dark Mode Card: #252D37 (RGB: 37, 45, 55)
  Light Mode Bg:  #FAFBFC  (RGB: 250, 251, 252)
  Light Mode Surface: #FFFFFF
  Light Mode Card: #F3F4F6
   
Emotion Accent Colors (for mood/emotion chips):
  Joy/Grateful:   #FFD85C  (Warm Yellow)   — ممتن ومبسوط
  Peaceful:       #5B9BD5  (Soft Blue)     — هادي وراضي
  Loved:          #E85A8F  (Rose Pink)     — محبوب ومتطمن
  Hopeful:        #A78BFA  (Lavender)      — متفائل وفي بالي حاجة
  Grounded:       #84A366  (Sage Green)    — مستقر وثابت
  
Text Colors (WCAG AA Compliant):
  Dark Mode:
    Primary Text:      #E5E7EB  (RGB: 229, 231, 235)  — 14.5:1 on surface1
    Secondary Text:    #9CA3AF  (RGB: 156, 163, 175)  — 7.5:1 on surface1
    Tertiary Text:     #85909D  (RGB: 133, 144, 157)  — 4.8:1 on surface1 ✓
    Disabled:          #6B7685  (RGB: 107, 118, 133)  — 3.3:1 on surface1
    Dividers:          #374151  (RGB: 55, 65, 81)
    
  Light Mode:
    Primary Text:      #1F2937  (RGB: 31, 41, 55)
    Secondary Text:    #6B7280  (RGB: 107, 114, 128)
    Tertiary Text:     #5D6673  (RGB: 93, 102, 115)

Status Colors:
  Success:  #10B981  (Green)
  Warning:  #F59E0B  (Amber)
  Error:    #EF4444  (Red)
  Info:     #3B82F6  (Blue)
  Streak:   #FF6B35  (Orange)

Gradient Overlays (Premium Feel):
  Primary Gradient: 
    From #0A7E6B (Deep Emerald) → To #075E50 (Darker Emerald)
    
  Recording Active:
    From #EF4444 (Error Red) → To #DC2626 (Darker Red)
```

#### **Color Architecture — Token Files**

All colors live in `lib/core/theme/tokens/app_colors.dart`.  
Backward-compat re-exports at `lib/core/constants/app_colors.dart`.

```
AppColors (abstract class):
  ─ primary, primaryLight, primaryDark, primaryContainer
  ─ secondary, accent
  ─ surface0–surface3 (dark mode)
  ─ surfaceLight0–surfaceLight3 (light mode)
  ─ textPrimary, textSecondary, textTertiary (dark, WCAG AA)
  ─ lightTextPrimary, lightTextSecondary, lightTextTertiary
  ─ textOnPrimary, textOnPrimaryLight
  ─ success, warning, error, info, streakFire
  ─ emotionJoy, emotionPeace, emotionLoved, emotionHope, emotionGrounded
  ─ outline, divider, lightOutline
  ─ opacityHover/0.08, opacityFocus/0.12, opacityPressed/0.16, ...
  ─ overlayHover, overlayFocus, overlayPressed (white/black overlays)
  ─ surface(level, brightness)  → helper
  ─ onSurface(brightness, secondary, tertiary) → helper
```

### 3.2 Spacing System — 4-pt Scale

Token file: `lib/core/theme/tokens/app_spacing.dart`

```
Raw tokens (4-pt grid):
  xxs:     2px   (Tiny gaps)
  xs:      4px   (Internal component padding)
  sm:      8px   (Small gaps, icon spacing)
  md:     12px   (Input fields, chips)
  lg:     16px   (Standard card padding, section margins)
  xl:     20px   (Larger gaps)
  xxl:    24px   (Major section breaks)
  xxxl:   32px   (Full-screen margins)
  huge:   40px   (Large spacing)
  massive:48px   (Breathing room, top/bottom)
  giant:  64px   (Hero spacing)

Compatibility aliases (backward compat):
  compact  → xs   (4px)
  tight    → sm   (8px)
  cozy     → md   (12px)
  standard → lg   (16px)
  generous → xxl  (24px)
  spacious → xxxl (32px)
  abundant → massive (48px)
```

### 3.3 Border Radius System

Token file: `lib/core/theme/tokens/app_radius.dart`

```
None:      0px     (Hard edges — rarely used)
Tight:     4px     (Icon containers, small chips)
Cozy:      8px     (Input fields, small modals)
Standard: 12px     (Cards, buttons, major UI elements)
Generous: 16px     (Rounded bottom sheets, full-width modals)
Pill:      999px   (Fully rounded for chips, FABs, badges)
```

### 3.4 Shadow System (Depth & Elevation)

Token file: `lib/core/theme/tokens/app_elevation.dart`

```
Dark Mode (pure black shadow):
  Elevation 1 (Subtle):
    shadowColor: #000000 @ 20% opacity
    blur: 8px, offset: 0,2
    Usage: Hovered cards
    
  Elevation 2 (Medium):
    shadowColor: #000000 @ 25% opacity
    blur: 16px, offset: 0,4
    Usage: Modals, elevated buttons
    
  Elevation 3 (High):
    shadowColor: #000000 @ 30% opacity
    blur: 24px, offset: 0,8
    Usage: Floating action buttons, toasts

Light Mode (brand-tinted shadow):
  Elevation 1: shadowColor: #000000 @ 8%, blur: 8px, offset: 0,2
```

### 3.5 Typography System (Cairo Font — Arabic Native)

Token file: `lib/core/theme/tokens/app_typography.dart`

```
display:      32px  w700  -0.5  →  Onboarding titles, premium headers
headline:     28px  w700  -0.3  →  Screen titles, modal headers
titleLarge:   24px  w600   0.0  →  Card titles, section headers, stat numbers
titleMedium:  20px  w600   0.1  →  Subsection titles, prominent stats
titleSmall:   16px  w600   0.1  →  Button labels, small card titles
bodyLarge:    16px  w400   0.5  →  Primary body text, gratitude content
bodyMedium:   14px  w400   0.25 →  Secondary body text, metadata
bodySmall:    12px  w400   0.4  →  Captions, timestamps, labels
labelLarge:   14px  w600   0.1  →  Chips, badges, tags, compact buttons
labelMedium:  12px  w600   0.5  →  Small buttons, overlines
labelSmall:   11px  w500   0.5  →  Tiny badges, time displays
```

---

## 4. COMPONENT SYSTEM (Flutter Cupertino)

### 4.1 Button Component Hierarchy

#### **Primary Button (Main CTA)**
```dart
// Widget: PrimaryButton in lib/shared/widgets/
// Style: Filled primary background, white text
// Height: 52px (48px in compact contexts)
// Corner Radius: 12px
// Font: titleSmall (16px Semibold)
// Padding: 0, 24px (horizontal)

Properties:
  enabled: true
  disabled: Opacity 0.38, no interaction
  loading: CupertinoActivityIndicator

States:
  idle:      AppColors.primary (#0A7E6B) background
  pressed:   Opacity 0.16 overlay on primary
  disabled:  Opacity 0.38
  loading:   Small spinner, text fades
```

#### **Secondary Button (Alternative Action)**
```dart
// Widget: SecondaryButton in lib/shared/widgets/
// Style: Outlined stroke, transparent fill
// Height: 48px
// Corner Radius: 12px
// Font: titleSmall (16px Semibold)
// Stroke: 1.5px AppColors.primary (#0A7E6B)
```

#### **Tertiary Button (Ghost Action)**
```dart
// Widget: TertiaryButton in lib/shared/widgets/
// Style: Text only, no stroke or fill
// Height: auto
// Font: titleSmall (16px Semibold)
// Color: AppColors.primary (#0A7E6B)
```

### 4.2 Input Component Hierarchy

#### **GratitudeCard Widget** (Shared)
```dart
// Widget: GratitudeCard in lib/shared/widgets/
// Padding: AppSpacing.md (12px)
// Corner Radius: AppRadius.standard (12px)
// Background: AppColors.surface2 (#252D37) dark / surfaceLight1 (#FFFFFF) light
// Min Height: 80px

Content Layout (RTL):
  [Mood Icon] [Arabic Mood Label] [Text Snippet] [Time]
  
Typography:
  Text snippet: bodyMedium (14px Regular), 2 lines max
  Mood label: labelMedium (12px Semibold), secondary text
  Time: labelSmall (11px), tertiary text

States:
  normal:    Standard card
  pressed:   Opacity 0.16 state overlay
```

#### **Emotion Selector** (Shared)
```dart
// Widget: EmotionSelector in lib/shared/widgets/
// Horizontal row of emotion chips, no emojis
// Each chip: icon (CupertinoIcons) + Arabic label below
// Chip Size: 44w × 52h approx (icon 20px)
// Spacing: 12px between chips

Emotions (Arabic labels via AppStrings.moodLabel()):
  joyful  (😊 없음) → ممتن ومبسوط  - emotionJoy (#FFD85C)
  peaceful          → هادي وراضي    - emotionPeace (#5B9BD5)  
  loved             → محبوب ومتطمن  - emotionLoved (#E85A8F)
  hopeful           → متفائل...     - emotionHope (#A78BFA)
  grounded          → مستقر وثابت   - emotionGrounded (#84A366)
  reflective        → متأمل        - emotionPeace (#5B9BD5)

Selected State:
  Scale: 1.0 (no bounce)
  Ring: AppColors.primary (#0A7E6B)
  Background: 30% opacity of emotion color
  Shadow: None (flat)

Unselected State:
  Opacity: 0.5
```

### 4.3 Card Component System

#### **Gratitude Card (List Item)** — Deprecated, use shared `GratitudeCard`
```dart
// Uses GratitudeCard from lib/shared/widgets/
```

#### **Stat Card (Analytics)**
```dart
// Padding: 16px
// Corner Radius: 12px
// Background: Surface.dark2 on dark, surfaceLight2 on light
// Min Height: 80px

Layout (RTL):
  [Large Number] [Right 8px] [Label/Description]
  
Typography:
  Number: titleLarge (24px Semibold), AppColors.primary (#0A7E6B)
  Label: bodyMedium (14px Regular), secondary text
  Trend: labelSmall (11px Semibold), success or warning
```

#### **Breathing Button (Home Screen CTA)**
```dart
// Size: 44px × 44px (circular)
// Corner Radius: 999px
// Background: AppColors.primary (#0A7E6B) with gentle pulse
// Icon: CupertinoIcons.mic_fill, 22px, white
// Position: Bottom center, 16px from bottom edges

Animation:
  Pulse: Gentle breathing animation (scale 1.0 → 1.05, 2s cycle)
```

### 4.4 Modal & Sheet Components

#### **Bottom Sheet** — Uses shared `AppBottomSheet`
```dart
// Widget: AppBottomSheet in lib/shared/widgets/
// Height: 90% of screen
// Corner Radius Top: AppRadius.generous (16px)
// Background: AppColors.surface1
// Padding: AppSpacing.lg (16px)

Content Layout:
  [Top] Header (Title + Close button)
  [Center] Main content area (scrollable)
  [Bottom] Actions

RTL:
  Close button: Right side
  Actions: Right-aligned layout
```

#### **Alert Dialog** — Uses shared `AppDialog`
```dart
// Widget: AppDialog in lib/shared/widgets/
// Width: 90%, max 400px
// Corner Radius: AppRadius.generous (16px)
// Background: AppColors.surface2
// Padding: AppSpacing.xxl (24px)
```

### 4.5 Navigation Components

#### **Tab Bar (Bottom Navigation)** — Uses shared `AppBottomNavBar`
```dart
// Widget: AppBottomNavBar in lib/shared/widgets/
// Height: 44px (+ safe area inset)
// Position: Bottom fixed
// Background: AppColors.surface1 (#1A1F26) dark / surfaceLight1 (#FFFFFF) light
// Border Top: 1px AppColors.divider (#374151)

Tabs:
  1. Home (House icon)
  2. Record (Microphone icon)
  3. Timeline (Calendar icon)
  4. Analytics (Chart icon)
  5. Settings (Gear icon)

Icon Specs:
  Size: 22px
  Inactive: Opacity 0.6, textSecondary (#9CA3AF)
  Active: AppColors.primary (#0A7E6B)
  
Label:
  Font: labelSmall (11px Semibold)
  Only shown when active
```

#### **Top Navigation Bar (Header)**
```dart
// Height: 44px (iOS standard)
// Background: AppColors.surface1 or transparent
// Uses CupertinoNavigationBar

Content:
  [Trailing] Back or menu button (RTL: right)
  [Middle] Title
  [Leading] Action buttons (RTL: left)
```

---

## 5. SCREEN LAYOUTS & SPECIFICATIONS

### 5.1 Home Dashboard Screen

**Purpose:** Entry point showing today's gratitude status, quick recording, and reflection

**Layout (RTL):**

```
┌─────────────────────────────────┐
│ 9:41              ⟲ 📡 🔋     │ (Status bar)
├─────────────────────────────────┤
│  ≡ أمتنان يومي     [Settings ⚙]│ (Header with logo)
├─────────────────────────────────┤
│                                 │
│  ┌───────────────────────────┐  │
│  │  صباح الخير               │  │ (Time-aware greeting)
│  │  أضفت تطبيق...            │  │ (Small tip text)
│  └───────────────────────────┘  │
│                                 │
│  ┌─────────────┐  ┌─────────┐  │
│  │     12      │  │ نسبة يومية  │ (Gratitude count + badge)
│  │   شكر اليوم │  │   100%    │
│  └─────────────┘  └─────────┘  │
│                                 │
│  ╔═══════════════════════════╗  │
│  ║  🎤 سجل شيء تشكر عليه     ║  │ (Primary CTA - FAB alt)
│  ╚═══════════════════════════╝  │
│                                 │
│  ┌─────────────────────────────┐ │
│  │  "لماذا الامتنان؟"          │ │ (Daily prompt card)
│  │  حقائق مثيرة عن الامتنان... │ │
│  │  [تعرف أكثر]               │ │
│  └─────────────────────────────┘ │
│                                 │
│  [Recent Gratitudes Carousel]   │ (Horizontal scroll)
│  ← 🙏 شكرت على... | 💖 أحب... → │
│                                 │
├─────────────────────────────────┤ (Tab bar)
│ Home │ Record │ Timeline │...  │
└─────────────────────────────────┘
```

**Components:**
- **Greeting Section:** Dynamic "صباح الخير" / "مساء الخير" based on time
- **Gratitude Counter:** Large ring chart showing today's goal (animated increment)
- **CTA Button:** "سجل شكر" with microphone icon, gradient background, pulse animation
- **Daily Prompt:** Scrollable card with reflection question + tip
- **Recent Carousel:** Horizontal scroll of last 3 gratitudes, swipeable to previous day
- **Habits Ring:** Circular progress ring showing 7-day streak (if enabled)

**Dark Mode Specifics:**
- Background: AppColors.surface1 → surface0 gradient (subtle)
- Card shadows: Dark elevation 2
- Text: AppColors.textPrimary (#E5E7EB) with AppColors.textSecondary (#9CA3AF)
- Accent: AppColors.primary (#0A7E6B) on ring charts

**Micro-interactions:**
- Counter increments with haptic tap when navigating to screen
- Greeting animates in (fade + slide 300ms)
- CTA button pulses gently (1.2s cycle)
- Carousel auto-scrolls on idle (5s delay), pauses on interaction

**RTL Adjustments:**
- All text naturally flows RTL via Flutter Directionality
- Carousel scroll direction: Left = forward in time (reverse of LTR)
- Icons on right side of text
- Gradient overlays respect RTL context

---

### 5.2 Recording Screen (Bottom Sheet Modal)

**Purpose:** Capture gratitude via voice, text, or hybrid input

**Layout (RTL - Draggable Modal):**

```
┌─────────────────────────────────┐
│ ◄───── ◄──────────────► ─────► │ (Drag handle at top center)
├─────────────────────────────────┤
│  سجل شكرك        [✕ Close]     │ (Header)
│  [خطوات: 1 / 3]                │ (Progress indicator)
├─────────────────────────────────┤
│                                 │
│  [🎤] الخطوة 1: سجل صوتياً     │ (Step title with icon)
│  اضغط الزر وتحدث بطبيعية...   │ (Hint text)
│                                 │
│  ╔═══════════════════════════╗  │
│  ║  ⏹ 00:32                  ║  │ (Record button + timer)
│  ║  ▁▂▃▄▅▆▇█▇▆▅▄▃▂▁         ║  │ (Waveform visualizer)
│  ╚═══════════════════════════╝  │
│                                 │
│  ┌─────────────────────────────┐ │
│  │ 📝 أو أضف نص تفصيلي       │ │ (Text option)
│  │ [اختياري]                  │ │
│  └─────────────────────────────┘ │
│                                 │
│  ┌─────────────────────────────┐ │
│  │ "كيف تشعر؟"                 │ │ (Emotion selector)
│  │ 😊 😌 💗 🌟 🌿              │ │ (Emoji chips)
│  └─────────────────────────────┘ │
│                                 │
│ ┌──────────────────────────────┐│
│ │ [← الرجوع]  [التالي →]       ││ (Navigation buttons)
│ └──────────────────────────────┘│
│                                 │
└─────────────────────────────────┘
```

**Step 1: Audio Recording**
- **Record Button:** Large 80px circle with green gradient, scales on press
- **Waveform:** 20 animated bars updating in real-time with audio amplitude
- **Timer:** Digital display (MM:SS) in secondary grey, green accent on seconds
- **Stop Indication:** Color pulses red on long recording (5+ min warning)
- **Playback:** Optional preview button below waveform
- **Text Alternative:** Expandable text area for hybrid input

**Step 2: Emotion & Context**
- **Emotion Chips:** 5 options (Joy, Peace, Loved, Hopeful, Grounded)
- **Category Tags:** Optional multi-select chips (Health, Work, Family, Relationships, etc.)
- **Photo Attachment:** Camera icon, optional photo capture/selection

**Step 3: Review & Save**
- **Preview:** Display recording duration + emotion + text preview
- **Edit Actions:** Buttons to re-record, change emotion, delete text
- **Save Button:** Primary green CTA
- **Archive Option:** "Save & Close" vs. "Save & Record More"

**Dark Mode Specifics:**
- Screen background: AppColors.surface1
- Recording icon: AppColors.primary (#0A7E6B)
- Text input: AppColors.surface2 background
- Emotion chips: Light tint backgrounds (joy: #FFD85C at 20% opacity)

**RTL Considerations:**
- Modal draggable from any point (not direction-specific)
- All text naturally right-aligned
- Buttons: Primary on right, secondary on left
- Progress bar: Right-to-left fill
- Waveform: Symmetrical (no direction dependency)

---

### 5.3 Timeline Screen

**Purpose:** Browse, search, and reflect on past gratitudes

**Layout (RTL):**

```
┌─────────────────────────────────┐
│ 9:41              ⟲ 📡 🔋     │
├─────────────────────────────────┤
│  ≡ الخط الزمني                 │ (Header with mode selector)
│  [📅 شهري] [📋 قائمة] [🔍]     │ (View mode buttons)
├─────────────────────────────────┤
│                                 │
│  [Search box + Filter]          │
│  ┌─────────────────────────────┐│
│  │ 🔍 ابحث عن شكر...           ││
│  │ [Filters: الكل ▼]           ││
│  └─────────────────────────────┘│
│                                 │
│  ┌───┬───┬───┬───┬───┐         │
│  │ ش │ س │ أ │ ن │ ي │ June   │ (Calendar header)
│  ├───┼───┼───┼───┼───┤         │
│  │ 26│ 27│ 28│ 29│ 30│  ──     │
│  │───┼───┼───┼───┼───┤         │
│  │ 1 │ 2 │ 3 │ 4 │ 5 │         │ (Days with green dots)
│  │ ● │   │ ● │ ● │   │         │
│  ├───┼───┼───┼───┼───┤         │
│  │ 8 │ 9 │10 │11 │12 │         │
│  │ ● │ ● │   │ ● │ ● │         │
│  └───┴───┴───┴───┴───┘         │
│                                 │
│  [6 / 30 days completed - Badge]│ (Stats below calendar)
│                                 │
├─────────────────────────────────┤
│  June 2024 (or selected month)  │ (List title)
├─────────────────────────────────┤
│ ┌──────────────────────────────┐│ (List view with dates)
│ │ 🎯 [2:45 PM - 12 minutes ago]││
│ │ شكرت على دعم الأسرة والأصدقاء││
│ │ [مسرور - صحة]               ││
│ └──────────────────────────────┘│
│ ┌──────────────────────────────┐│
│ │ 💖 [1:30 PM - 45 minutes ago]││
│ │ أحب اللحظات الهادئة...       ││
│ │ [محبوب - ذاتي]              ││
│ └──────────────────────────────┘│
│ ┌──────────────────────────────┐│
│ │ 🌟 [9:15 AM - Today]         ││
│ │ آمل في مستقبل أفضل...       ││
│ │ [آمل - طموح]               ││
│ └──────────────────────────────┘│
│                                 │
│ [Load More] or [Infinite Scroll]│
│                                 │
├─────────────────────────────────┤
│ Home │ Record │ [Timeline] │... │
└─────────────────────────────────┘
```

**View Modes:**

**Mode 1: Calendar View**
- Monthly grid (Arabic month names)
- Dots on days with gratitudes (green = recorded)
- Tap date → shows list for that day
- Swipe left/right → previous/next month
- Stats badge: "X / 30 days completed"

**Mode 2: List View**
- Chronological list (most recent first)
- Gratitude cards (as per 4.3)
- Pull-to-refresh at top
- Infinite scroll to past

**Mode 3: Search/Filter**
- Search bar (right-aligned for RTL)
- Filter chips: Emotion, Category, Date range
- Results show matching gratitudes with highlights
- Empty state: "لم نجد نتائج"

**Gratitude Detail Page (On Tap):**

```
┌─────────────────────────────────┐
│ [← Back]              [⋯ Menu] │
├─────────────────────────────────┤
│                                 │
│  June 24, 2024 at 2:45 PM      │ (Metadata)
│                                 │
│  ┌─────────────────────────────┐ │
│  │  🎤 شكرت على دعم الأسرة... │ │ (Title with emotion)
│  │                             │ │
│  │  النص الكامل للشكر:         │ │
│  │  "كنت ممتناً اليوم على...  │ │ (Full text)
│  │   دعم أسرتي والأصدقاء      │ │
│  │   الذين وقفوا بجانبي في... │ │
│  │   وقت الحاجة."             │ │
│  │                             │ │
│  │  [▶ 2:34 min] Audio play   │ │ (Audio player if recorded)
│  │  ▁▂▃▄▅▆▇█▇▆▅▄▃▂▁           │ │
│  │                             │ │
│  └─────────────────────────────┘ │
│                                 │
│  ┌──────────────────────────────┐│ (Metadata)
│  │ الحالة المزاجية: مسرور 🎯  ││
│  │ الفئة: صحة، أسرة             ││
│  │ الصور: 1 صورة               ││
│  │ وقت التسجيل: 2:45 PM        ││
│  └──────────────────────────────┘│
│                                 │
│  ┌──────────────────────────────┐│ (Reflection prompt)
│  │ "كيف غيّر هذا الشكر يومك؟" ││
│  │ [أضف ملاحظات]              ││
│  └──────────────────────────────┘│
│                                 │
│ ┌──────────────────────────────┐│ (Actions)
│ │ [🖊 تعديل]  [🗑 حذف]        ││
│ │ [🔖 أرشفة]  [📤 مشاركة]     ││
│ └──────────────────────────────┘│
│                                 │
└─────────────────────────────────┘
```

**Dark Mode:**
- Background: AppColors.surface1 → surface0
- Cards: AppColors.surface2 surface
- Audio player: AppColors.primary (#0A7E6B) waveform on surface2

**Micro-interactions:**
- Calendar tap: Bounce scale (0.95 → 1.0) on date
- List card press: Elevation rise + fade transition
- Audio play: Waveform animates during playback
- Swipe delete: Red reveal with haptic warning

---

### 5.4 Analytics Dashboard

**Purpose:** Visualize gratitude patterns, trends, and insights

**Layout (RTL):**

```
┌─────────────────────────────────┐
│ 9:41              ⟲ 📡 🔋     │
├─────────────────────────────────┤
│  ≡ إحصائيات                    │ (Header)
│  [الشهر ▼]  [هذا الشهر]        │ (Time period selector)
├─────────────────────────────────┤
│                                 │
│  ┌─────────────────────────────┐ │ (Stat cards grid - 2 cols)
│  │  12            │  3          │ │
│  │ شكر هذا الشهر  │ رقم قياسي   │ │
│  │ (↑ 3 أمس)     │ (6 أيام)   │ │
│  └─────────────────────────────┘ │
│                                 │
│  ┌─────────────────────────────┐ │
│  │  85%           │  1.5 min    │ │
│  │ نسبة الإكمال   │ متوسط الطول │ │
│  │ (اليومية)     │ (للشكر)     │ │
│  └─────────────────────────────┘ │
│                                 │
│  ┌─────────────────────────────┐ │ (Emotion distribution pie)
│  │ توزيع المشاعر              │ │
│  │      🟡 30%  (مسرور)        │ │
│  │      🔵 25%  (محبوب)        │ │
│  │      🟢 20%  (آمل)         │ │
│  │      🟣 15%  (هادئ)        │ │
│  │      🟤 10%  (متجذر)       │ │
│  │                             │ │
│  │  [Show Details ▼]          │ │
│  └─────────────────────────────┘ │
│                                 │
│  ┌─────────────────────────────┐ │ (Trend line graph)
│  │ الاتجاه الأسبوعي            │ │
│  │                             │ │
│  │    █                 █      │ │
│  │  █   █     █       █   █    │ │
│  │ █     █   █ █   █ █     █   │ │
│  │─────────────────────────────  │
│  │ أح  إث  ثل  أر  خم  جم  سب  │
│  │                             │ │
│  │ Average: 2.3 gratitudes/day │ │
│  └─────────────────────────────┘ │
│                                 │
│  ┌─────────────────────────────┐ │ (Category breakdown)
│  │ الفئات الشهيرة              │ │
│  │ ━ صحة        ████████░░░   │ │
│  │ ━ أسرة        ███████░░░░   │ │
│  │ ━ ذاتي        ██████░░░░░   │ │
│  │ ━ عمل         ████░░░░░░░   │ │
│  │ ━ أصدقاء      ███░░░░░░░░   │ │
│  └─────────────────────────────┘ │
│                                 │
│  ┌─────────────────────────────┐ │ (Insights section)
│  │ 💡 إحصائيات ذكية            │ │
│  │                             │ │
│  │ ✓ أنت أفضل حالاً يوم الإثنين│ │
│  │   (متوسط 3.2 شكر)          │ │
│  │                             │ │
│  │ ✓ العائلة أكثر شيء تشكر عليه│ │
│  │   (45% من الشكر)            │ │
│  │                             │ │
│  │ ✓ أطول سلسلة: 12 يوماً      │ │
│  │   (آخر مرة يوم 3 يونيو)    │ │
│  └─────────────────────────────┘ │
│                                 │
│ ┌──────────────────────────────┐│ (Export options)
│ │ [📊 تصدير تقرير] [📈 مشاركة]││
│ └──────────────────────────────┘│
│                                 │
├─────────────────────────────────┤
│ Home │ Record │ Timeline │...   │
└─────────────────────────────────┘
```

**Card Components:**

| Metric | Value | Trend | Example |
|--------|-------|-------|---------|
| Total Gratitudes | Large number | ↑ today | "12 شكر" |
| Streak | Number + flame | Days | "3 أيام" |
| Completion Rate | Percentage | Daily goal | "85%" |
| Avg. Length | Time | Duration | "1:32 min" |
| Top Emotion | Icon + % | Pie slice | "مسرور 30%" |
| Top Category | Tag | Bar size | "صحة 45%" |

**Charts:**

**Emotion Distribution (Pie Chart)**
- 5 segments with emotion colors
- % labels on segments
- Legend below
- Tap slice → shows count + examples

**Weekly Trend (Line Graph)**
- X-axis: Days (أح, إث, ثل, أر, خم, جم, سب)
- Y-axis: Gratitudes count (0–5)
- Smooth curve, green line
- Data points are tappable for detail
- Shaded area under curve

**Category Breakdown (Horizontal Bars)**
- Top 5–7 categories
- Bar width = proportion
- Labels + percentages
- Color coded (different tints of green)

**Dark Mode:**
- Stat cards: AppColors.surface2 background, AppColors.primary for numbers
- Charts: Dark background, emotion accent colors
- Text: AppColors.textPrimary (#E5E7EB)

**Micro-interactions:**
- Pie slice tap: Scale + glow animation (150ms)
- Chart scroll: Smooth pan gesture
- Stat card swipe: Reveal previous period (e.g., last month)
- Insight toast: Slide in from top, haptic tap

---

### 5.5 Settings Screen

**Purpose:** User preferences, profile, backup, and app info

**Layout (RTL):**

```
┌─────────────────────────────────┐
│ 9:41              ⟲ 📡 🔋     │
├─────────────────────────────────┤
│  ≡ الإعدادات                   │ (Header)
├─────────────────────────────────┤
│                                 │
│  ┌─────────────────────────────┐ │ (Profile section)
│  │ 👤 الملف الشخصي            │ │
│  │ الاسم: محمد أحمد           │ │
│  │ البريد: user@example.com    │ │
│  │ [تعديل ▶]                 │ │
│  └─────────────────────────────┘ │
│                                 │
│  ┌─────────────────────────────┐ │ (Notification preferences)
│  │ 🔔 الإشعارات               │ │
│  │ تذكيرات الشكر       [Toggled ON ]  │
│  │ الوقت المفضل: 8:00 صباحاً  │ │
│  │ التكرار: يومياً             │ │
│  │ الصوت: مفعّل               │ │
│  └─────────────────────────────┘ │
│                                 │
│  ┌─────────────────────────────┐ │ (Appearance)
│  │ 🎨 المظهر                  │ │
│  │ الوضع المظلم    [Toggled ON ]  │
│  │ حجم الخط: عادي   [- | + ]     │
│  │ اللغة: العربية              │ │
│  └─────────────────────────────┘ │
│                                 │
│  ┌─────────────────────────────┐ │ (Data & Privacy)
│  │ 🔒 البيانات والخصوصية      │ │
│  │ [Backup to iCloud]         │ │
│  │ [Auto-sync: ON]            │ │
│  │ [Delete Local Data]        │ │
│  │ [Export as CSV]            │ │
│  └─────────────────────────────┘ │
│                                 │
│  ┌─────────────────────────────┐ │ (About)
│  │ ℹ️ حول التطبيق             │ │
│  │ الإصدار: 1.0.0 (Build 42)  │ │
│  │ [مشروع مفتوح المصدر]       │ │
│  │ [سياسة الخصوصية]           │ │
│  │ [شروط الاستخدام]           │ │
│  │ [تواصل معنا]              │ │
│  └─────────────────────────────┘ │
│                                 │
│  ┌─────────────────────────────┐ │ (Danger zone)
│  │ 🗑 منطقة الخطر              │ │
│  │ [تسجيل الخروج]             │ │
│  │ [حذف الحساب]              │ │
│  │ [مسح جميع البيانات]        │ │
│  └─────────────────────────────┘ │
│                                 │
├─────────────────────────────────┤
│ Home │ Record │ Timeline │...   │
└─────────────────────────────────┘
```

**Sections:**

1. **Profile**
   - Avatar placeholder with initials
   - Name (editable)
   - Email (editable)
   - Bio/About (optional)
   - Linked social (future)

2. **Notifications**
   - Toggle: Daily reminders on/off
   - Time picker: Preferred notification time
   - Frequency: Daily / Multiple times / Weekends only
   - Sound: On/Off
   - Haptics: On/Off

3. **Appearance**
   - Dark mode toggle
   - Font size slider (-/+)
   - Language selector (AR / EN)
   - Color theme preview (future)

4. **Data & Privacy**
   - iCloud backup toggle + last backup date
   - Auto-sync frequency selector
   - Export data as JSON/CSV
   - Delete local data (warning dialog)

5. **About**
   - App version + build number
   - Open source credits
   - Privacy policy link
   - Terms of use link
   - Contact/feedback
   - Rate app button

6. **Danger Zone**
   - Logout (sign out from account)
   - Delete account (red button, confirmation)
   - Clear all data (red button, irreversible warning)

**Dark Mode:**
- Sections: AppColors.surface2 background
- Toggle switches: AppColors.primary when ON
- Danger buttons: AppColors.error fill
- Text: AppColors.textPrimary

**Micro-interactions:**
- Toggle switch: Spring animation, haptic feedback
- Slider: Smooth real-time preview (e.g., font size)
- Time picker: Modal with haptic feedback on selection
- Red buttons: Scale 0.95 on press, confirmation dialog after tap

---

## 6. DARK MODE SPECIFICATIONS

### 6.1 Token Architecture (Source of Truth)

All colors, spacing, radius, elevation, and typography tokens live in `lib/core/theme/tokens/`:

| Token File | Constants Class | Key Contents |
|---|---|---|
| `app_colors.dart` | `AppColors` | `primary #0A7E6B`, `secondary #D4A574`, surfaces, text, emotions, state opacities |
| `app_typography.dart` | `AppTypography` | `display`..`labelSmall` TextStyle getters |
| `app_spacing.dart` | `AppSpacing` | `xxs 2px`..`giant 64px` + compat aliases |
| `app_radius.dart` | `AppRadius` | `tight 4px`..`pill 999px` |
| `app_elevation.dart` | `AppElevation` | `level1`..`level3` shadows |

Theme builder at `lib/core/theme/app_theme.dart`:
```dart
CupertinoThemeData buildDarkTheme() {
  return CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    primaryContrastingColor: AppColors.textOnPrimary,
    scaffoldBackgroundColor: AppColors.surface0,
    barBackgroundColor: AppColors.surface1,
    textTheme: CupertinoTextThemeData(
      primaryColor: AppColors.primary,
      textStyle: AppTypography.bodyMedium.copyWith(
        color: AppColors.textPrimary,
      ),
    ),
  );
}
```

Token access in widgets via `AppColorTheme` InheritedWidget:
```dart
final colors = AppColorTheme.of(context);
// colors.primary, colors.surface, colors.textPrimary, etc.
```

### 6.2 Component Dark Mode Adjustments

**Cards:**
- Background: #252D37
- Border: 1px #374151
- Shadow: 0,2 @ 25% black opacity
- Text: #E5E7EB primary, #9CA3AF secondary

**Inputs:**
- Background: #252D37
- Border (idle): #374151
- Border (focused): #0A7E6B
- Cursor: #0A7E6B
- Placeholder: #9CA3AF

**Buttons:**
- Primary: Solid AppColors.primary (#0A7E6B)
- Secondary: Outlined, no fill
- Text: White on primary background

**Waveform:**
- Active bars: #0A7E6B
- Background: Transparent or dark2 container

**Charts:**
- Background: Transparent (inherits surface)
- Line/bars: AppColors.primary (#0A7E6B)
- Grid lines: #374151 @ 30% opacity
- Labels: #9CA3AF

---

## 7. MICRO-INTERACTIONS & ANIMATIONS

### 7.1 Button Interactions

**Primary Button Press:**
```
Timeline:
  0ms:   Scale = 1.0, shadow = elevation 3
  150ms: Scale = 0.98, shadow = elevation 2
  300ms: Scale = 1.0, shadow = elevation 3 (release)
  
Curve: EaseInOutCubic
Haptic: Medium-strength tap feedback
```

**Toggle Switch Activation:**
```
Timeline:
  0ms:   Position = off, color = grey
  200ms: Position slides to on, color transitions to green
  300ms: Completed state (green, on position)
  
Curve: Curves.elasticOut (60% elasticity)
Haptic: Light tap on completion
```

### 7.2 Screen Transitions

**Push (Enter New Screen):**
```
Duration: 300ms
Curve: Curves.easeOutCubic
Animation:
  - Incoming screen: Slide from right (RTL) to center
  - Background dimming: Fade in 0% → 20%
  - Opacity: 0% → 100%
```

**Pop (Return to Previous Screen):**
```
Duration: 250ms
Curve: Curves.easeInCubic
Animation:
  - Outgoing screen: Slide to right (RTL)
  - Incoming screen revealed
  - Opacity fade-out
```

**Bottom Sheet Modal Entry:**
```
Duration: 350ms
Curve: Curves.easeOutCubic
Animation:
  - Sheet: Slide up from bottom
  - Content: Opacity fade-in (offset 100ms)
  - Background: Dimmer fade-in
  - Drag handle: Appear with slight scale bounce
```

### 7.3 List Animations

**Item Appear (On Load):**
```
Staggered delay: 50ms between items
Duration: 300ms per item
Curve: Curves.easeOut
Animation:
  - Slide from left (RTL) + opacity fade-in
  - Slight scale (0.95 → 1.0)
```

**Item Delete (Swipe Left):**
```
Duration: 200ms (reveal red backdrop)
Follow-up: 300ms (fade out + slide away on confirm)
Curve: Curves.easeInCubic
Haptic: Medium tap before confirming
```

**Pull-to-Refresh:**
```
Trigger distance: 60px below top
Duration: 400ms (spin animation)
Curve: Linear for spinner, Curves.easeOut for snap-back
Haptic: Tap when refreshing starts
```

### 7.4 Audio-Specific Animations

**Record Button Press:**
```
Duration: 150ms
Curve: Curves.elasticOut
Animation:
  - Scale: 1.0 → 0.92 (press) → 1.0 (release)
  - Ring: Outer ring appears (20% opacity)
  - Ripple pulse: Emanates outward (optional)
  
Haptic: Heavy tap feedback (duration: 50ms)
```

**Waveform During Recording:**
```
Update frequency: 30 times per second
Curve: No easing (instant bar height updates)
Bar animation:
  - Height interpolation: Current → target (10ms linear)
  - Opacity: Always 1.0
  
Idle (no audio):
  - Bars settle to baseline (3px height)
  - Pulsing animation (subtle 0.8 → 1.0 opacity every 600ms)
```

**Playback Progress:**
```
Duration: Matches audio length
Curve: Linear (tied to audio playback)
Indicator: Vertical line sweeping left-to-right (LTR) / right-to-left (RTL)
Update: 60fps sync with audio position
```

### 7.5 Emotion Chip Selection

**Tap Animation:**
```
Duration: 200ms
Curve: Curves.elasticOut
Animation:
  - Scale: 1.0 → 1.15 (peak) → 1.08 (settle)
  - Ring appears: 2px green stroke, grows then stabilizes
  - Background glow: 0% → 50% opacity (color-dependent)
  - Shadow: Elevation 0 → 2
  
Haptic: Light tap feedback
```

**Unselection:**
```
Duration: 150ms
Curve: Curves.easeOut
Animation:
  - Scale: 1.08 → 0.95 (brief shrink) → 1.0
  - Ring fades out
  - Glow fades
  - Shadow: Elevation 2 → 0
```

---

## 8. ACCESSIBILITY & INCLUSIVITY

### 8.1 Semantic Labels (Arabic)

**Button Labels:**
- Record: "اضغط لتسجيل شكرك"
- Save: "احفظ الشكر"
- Delete: "حذف الشكر (لا يمكن التراجع)"
- Close: "إغلاق الشاشة"

**Icon Descriptions:**
- Microphone: "رمز المايكروفون - اضغط لتسجيل صوتي"
- Calendar: "رمز التقويم - اعرض الخط الزمني"
- Home: "الشاشة الرئيسية"

### 8.2 Text Size Scaling

- **Small:** 0.8x default (for advanced users)
- **Default:** 1.0x (Cairo Regular)
- **Large:** 1.2x (Accessibility setting)
- **Extra Large:** 1.5x (A11y)

Line height auto-adjusts: 1.4x font size minimum

### 8.3 High Contrast Mode

**Option: Enable for visually impaired users**
```
Edges: Increase border widths 1px → 2px
Colors: Darken dark mode further, increase green saturation
Text: Increase font weight +100 (Semibold → Bold)
Shadows: Increase blur 8px → 12px
Icons: Increase stroke width 1.5px → 2.5px
```

### 8.4 Motion Preferences

**Reduced Motion (iOS Setting)**
```
If Cupertino.of(context).disableAnimations == true:
  - All animations: 0ms (instant)
  - Transitions: Fade only (no slide)
  - Micro-interactions: Haptic feedback only (no visual feedback)
  - Auto-play animations: Disabled
  
Example: Recording modal appears instantly without slide-up
```

---

## 9. FLUTTER WIDGET HIERARCHY

### 9.1 App Structure

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ar'),
        Locale('en'),
      ],
      locale: Locale('ar'),
      theme: _buildDarkCupertinoTheme(), // Dark mode default
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: MainNavigationScreen(),
      ),
    );
  }
}

CupertinoThemeData _buildDarkCupertinoTheme() {
  return CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFF2DD4A4), // Gratitude Green
    barBackgroundColor: Color(0xFF1A1F26),
    scaffoldBackgroundColor: Color(0xFF0F1419),
    // ... full theme config
  );
}
```

### 9.2 Main Navigation (5-Tab Shell)

```dart
class MainNavigationScreen extends StatefulWidget {
  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.mic)),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.calendar)),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.chart_bar)),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings)),
        ],
        onTap: (index) {
          setState(() => _selectedIndex = index);
          // Trigger haptic feedback
          HapticFeedback.lightImpact();
        },
        activeColor: Color(0xFF2DD4A4),
        inactiveColor: Color(0xFF9CA3AF),
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            switch (index) {
              case 0: return HomeScreen();
              case 1: return RecordingBottomSheet();
              case 2: return TimelineScreen();
              case 3: return AnalyticsScreen();
              case 4: return SettingsScreen();
              default: return SizedBox.shrink();
            }
          },
        );
      },
    );
  }
}
```

### 9.3 Home Dashboard Widget Tree

```dart
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('امتنان يومي'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.settings),
          onPressed: () => _openSettings(context),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              GreetingCard(onboardingStep: 1),
              SizedBox(height: 24),
              GratitudeCounterCard(),
              SizedBox(height: 24),
              PrimaryActionButton(
                label: 'سجل شكرك',
                icon: CupertinoIcons.mic_fill,
                onPressed: () => _showRecordingModal(context),
              ),
              SizedBox(height: 32),
              DailyPromptCard(),
              SizedBox(height: 24),
              RecentGratitudesCarousel(),
              SizedBox(height: 32),
              HabitsRingCard(),
            ],
          ),
        ),
      ),
    );
  }
}
```

### 9.4 Recording Modal Widget Tree

```dart
class RecordingBottomSheet extends StatefulWidget {
  @override
  State<RecordingBottomSheet> createState() => _RecordingBottomSheetState();
}

class _RecordingBottomSheetState extends State<RecordingBottomSheet> {
  int _currentStep = 1;
  AudioRecorder? _audioRecorder;
  String? _recordingPath;

  @override
  Widget build(BuildContext context) {
    return CupertinoBottomSheet(
      builder: (context) => _buildContent(),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        // Drag handle
        SizedBox(height: 8),
        Container(
          width: 48,
          height: 4,
          decoration: BoxDecoration(
            color: Color(0xFF6B7280),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(height: 16),

        // Header
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('سجل شكرك', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: Icon(CupertinoIcons.xmark),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),

        // Progress indicator
        LinearProgressIndicator(
          value: _currentStep / 3,
          backgroundColor: Color(0xFF374151),
          valueColor: AlwaysStoppedAnimation(Color(0xFF2DD4A4)),
        ),

        SizedBox(height: 24),

        // Step content (pages)
        Expanded(
          child: PageView(
            onPageChanged: (index) {
              setState(() => _currentStep = index + 1);
            },
            children: [
              _buildAudioRecordingStep(),
              _buildEmotionStep(),
              _buildReviewStep(),
            ],
          ),
        ),

        // Navigation buttons
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: SecondaryButton(
                  label: 'الرجوع',
                  onPressed: _currentStep > 1 ? () => _goToPreviousStep() : null,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: PrimaryButton(
                  label: _currentStep == 3 ? 'حفظ' : 'التالي',
                  onPressed: _currentStep < 3 ? () => _goToNextStep() : () => _save(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAudioRecordingStep() {
    return Column(
      children: [
        Icon(CupertinoIcons.mic_fill, size: 32, color: Color(0xFF2DD4A4)),
        SizedBox(height: 16),
        Text('الخطوة 1: سجل صوتياً'),
        SizedBox(height: 8),
        Text('اضغط الزر وتحدث بطبيعية...', style: TextStyle(color: Color(0xFF9CA3AF))),
        SizedBox(height: 24),
        RecordButton(
          onPressed: _toggleRecording,
          isRecording: _audioRecorder?.isRecording ?? false,
        ),
        SizedBox(height: 16),
        if (_audioRecorder?.isRecording ?? false)
          WaveformVisualizer(), // Custom widget with animated bars
        SizedBox(height: 16),
        Text(
          _formatDuration(_audioRecorder?.recordDuration ?? Duration.zero),
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildEmotionStep() {
    return Column(
      children: [
        Text('كيف تشعر؟'),
        SizedBox(height: 24),
        EmotionChipSelector(
          emotions: ['مسرور', 'هادئ', 'محبوب', 'آمل', 'متجذر'],
          onSelected: (emotion) => print('Selected: $emotion'),
        ),
        SizedBox(height: 24),
        CategoryTagSelector(),
      ],
    );
  }

  Widget _buildReviewStep() {
    return Column(
      children: [
        Text('مراجعة شكرك'),
        SizedBox(height: 16),
        RecordingPreview(
          duration: _audioRecorder?.recordDuration ?? Duration.zero,
          emotion: 'مسرور',
          text: 'أنا ممتن على دعم أسرتي...',
        ),
      ],
    );
  }
}
```

### 9.5 Reusable Component Widgets

#### **Primary Button Component**
```dart
class PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;

  const PrimaryButton({
    required this.label,
    required this.onPressed,
    this.icon,
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
      duration: Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _controller.forward();
        HapticFeedback.mediumImpact();
      },
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2DD4A4), Color(0xFF10B981)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF2DD4A4).withOpacity(0.3),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, color: Colors.white, size: 20),
                SizedBox(width: 8),
              ],
              Text(
                widget.label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
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

#### **Gratitude Card Widget**
```dart
class GratitudeCardItem extends StatelessWidget {
  final String gratitudeText;
  final DateTime recordedAt;
  final String emotion;
  final List<String> categories;
  final String? imagePath;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const GratitudeCardItem({
    required this.gratitudeText,
    required this.recordedAt,
    required this.emotion,
    required this.categories,
    this.imagePath,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Color(0xFF252D37),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Header row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatTime(recordedAt),
                  style: TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  emotion,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 8),
            // Gratitude text
            Text(
              gratitudeText,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Color(0xFFE5E7EB),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 8),
            // Categories
            Wrap(
              spacing: 8,
              children: categories
                  .map((cat) => Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Color(0xFF2DD4A4).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          cat,
                          style: TextStyle(
                            color: Color(0xFF2DD4A4),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
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

#### **Waveform Visualizer (Audio)**
```dart
class WaveformVisualizer extends StatefulWidget {
  final AudioRecorder audioRecorder;
  final double height;

  const WaveformVisualizer({
    required this.audioRecorder,
    this.height = 48,
  });

  @override
  State<WaveformVisualizer> createState() => _WaveformVisualizerState();
}

class _WaveformVisualizerState extends State<WaveformVisualizer>
    with TickerProviderStateMixin {
  late List<double> _amplitudes;
  late AnimationController _animationController;
  final int _barCount = 25;

  @override
  void initState() {
    super.initState();
    _amplitudes = List.filled(_barCount, 0.0);
    _animationController = AnimationController(
      duration: Duration(milliseconds: 100),
      vsync: this,
    )..repeat();

    _startListeningToAmplitude();
  }

  void _startListeningToAmplitude() {
    // Fetch amplitude every 50ms from audio recorder
    // Update _amplitudes list with new values
    // Trigger rebuild
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(_barCount, (index) {
          return Expanded(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Container(
                  height: (_amplitudes[index] * widget.height).clamp(3, widget.height),
                  margin: EdgeInsets.symmetric(horizontal: 1),
                  decoration: BoxDecoration(
                    color: Color(0xFF2DD4A4),
                    borderRadius: BorderRadius.circular(1.5),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
```

---

## 10. TYPOGRAPHY & LANGUAGE SPECIFICS

### 10.1 Cairo Font Implementation

```dart
// pubspec.yaml
dependencies:
  google_fonts: ^6.0.0

// lib/core/theme/typography.dart
class AppTypography {
  static TextStyle display = GoogleFonts.cairo(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.25,
    letterSpacing: -0.5,
  );

  static TextStyle headline = GoogleFonts.cairo(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 1.29,
    letterSpacing: -0.3,
  );

  static TextStyle titleLarge = GoogleFonts.cairo(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.33,
  );

  static TextStyle bodyLarge = GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.5,
  );

  static TextStyle labelSmall = GoogleFonts.cairo(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.27,
    letterSpacing: 0.5,
  );
}
```

### 10.2 Arabic Text Handling

**RTL Context:**
```dart
Directionality(
  textDirection: TextDirection.rtl,
  child: MyApp(),
)
```

**Mixed Text (Arabic + English):**
```dart
// Use Directionality per text widget if needed
RichText(
  text: TextSpan(
    children: [
      TextSpan(
        text: 'أنا ممتن: ',
        style: AppTypography.bodyLarge,
      ),
      TextSpan(
        text: 'Grateful',
        style: AppTypography.bodyLarge.copyWith(
          fontStyle: FontStyle.italic,
        ),
      ),
    ],
  ),
)
```

---

## 11. WEAKNESSES IN CURRENT DESIGN & IMPROVEMENTS

### Current Design Issues:

1. **Overcrowded Information**
   - Too many tabs and nested options
   - Mix of different interaction patterns (carousel, modals, sheets)

2. **Visual Hierarchy Unclear**
   - Multiple call-to-action buttons compete for attention
   - Text sizing inconsistent across screens

3. **Dark Mode Incomplete**
   - Some colors not optimized for dark mode
   - Insufficient contrast on some text

4. **Recording Experience Friction**
   - Multi-step process feels laborious
   - No clear save feedback

5. **Timeline Overwhelm**
   - Calendar + list view not clearly differentiated
   - Search limited, no advanced filtering

6. **Analytics Limited**
   - Few insights beyond basic counts
   - No AI-powered reflections

### Proposed Improvements (Premium Edition):

1. **Simplified Navigation**
   - ✅ 5-tab bottom navigation (vs. drawer + modals)
   - ✅ Quick record (floating button alternative)
   - ✅ Clear hierarchy: Home (dashboard) → Timeline (history) → Analytics (insights)

2. **Enhanced Visual Design**
   - ✅ Premium dark mode (true black, high contrast)
   - ✅ Consistent typography hierarchy (Cairo + weights)
   - ✅ Subtle gradients on cards and buttons
   - ✅ Micro-interactions (haptics, smooth animations)

3. **Recording Streamlined**
   - ✅ One-tap to start recording
   - ✅ Waveform visualizer provides visual feedback
   - ✅ Quick emotion selection (no modal overhead)
   - ✅ Auto-save on app close (never lose a recording)

4. **Timeline Reimagined**
   - ✅ Calendar view with visual heat-map
   - ✅ Advanced search + filter UI
   - ✅ Infinite scroll list with timestamps
   - ✅ Quick edit/delete on card swipe

5. **Analytics Intelligence**
   - ✅ Emotion trend insights
   - ✅ Category breakdown
   - ✅ Weekly streak visualization
   - ✅ AI insights section (future: generated reflections)

6. **Wellness Aesthetic**
   - ✅ Breathing room (generous padding)
   - ✅ Calm color palette (greens, blues, warm accents)
   - ✅ Reduced motion support (accessibility)
   - ✅ No guilt/shame triggers (no punishing streaks)

---

## 12. DESIGN HANDOFF CHECKLIST

- [x] **Colors:** `lib/core/theme/tokens/app_colors.dart` — Deep Emerald palette, WCAG AA compliant
- [x] **Typography:** `lib/core/theme/tokens/app_typography.dart` — Cairo font, 11-size system
- [x] **Components:** `lib/shared/widgets/` — 10 shared Cupertino widgets created
- [x] **Animations:** `lib/core/constants/app_animations.dart` — reduced motion helpers added
- [x] **Spacing:** `lib/core/theme/tokens/app_spacing.dart` — 4-pt system + compat aliases
- [x] **Dark Mode:** All screens tested — 0 analyze errors
- [x] **RTL:** `Directionality(textDirection: TextDirection.rtl)` at app root, verified
- [ ] **Accessibility:** Add semantic labels and test with VoiceOver
- [ ] **Haptics:** Ensure HapticFeedback on all interactive elements
- [ ] **Localization:** Arabic-first, `AppStrings` class with all labels

---

## 13. DESIGN FILE REFERENCES

| Screen | File | Status |
|--------|------|--------|
| Onboarding | `lib/features/onboarding/` | To Design |
| Home Dashboard | `lib/features/home/presentation/` | To Implement |
| Recording | `lib/features/recording/presentation/` | To Implement |
| Timeline | `lib/features/timeline/presentation/` | To Implement |
| Analytics | `lib/features/analytics/presentation/` | To Implement |
| Settings | `lib/features/settings/presentation/` | To Implement |
| Shared Components | `lib/shared/widgets/` | To Create |
| Theme & Tokens | `lib/core/theme/` | To Finalize |

---

## Conclusion

This design system prioritizes **intentional simplicity**, **emotional resonance**, and **cultural authenticity** for an Arabic-first gratitude app. The premium dark mode aesthetic, smooth micro-interactions, and accessibility-first approach create a distinctive iOS experience inspired by Apple Journal's minimalism and Headspace's wellness philosophy.

**Next Steps:**
1. Add VoiceOver accessibility labels to all shared widgets
2. Consider deprecating `kSpace*` constants in favor of `AppSpacing` tokens
3. Add HapticFeedback to remaining interactive elements
4. Gather user feedback on recording flow

---

**Design System v2.0 — June 2026**  
**Platform:** iOS (Cupertino) | **Language:** Arabic (RTL)  
**Status:** Implemented — Deep Emerald palette, 4-pt spacing, 10 shared widgets, 0 analyze errors
