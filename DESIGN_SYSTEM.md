# Daily Gratitude | امتنان يومي — Premium Design System

**Version:** 1.0  
**Platform:** iOS First (Cupertino)  
**Language:** Arabic RTL + English  
**Inspirations:** Apple Journal, Headspace, Daylio, Reflectly  

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
Gratitude Green (Primary Action)
  Dark Mode:  #2DD4A4  (RGB: 45, 212, 164)
  Light Mode: #10B981  (RGB: 16, 185, 129)
  Usage: CTAs, active states, success, gratitude affirmations

Calm Slate (Neutral & Surfaces)
  Dark Mode Bg:  #0F1419  (RGB: 15, 20, 25)  — Premium dark
  Dark Mode Fg:  #1A1F26  (RGB: 26, 31, 38)
  Dark Mode Card: #252D37 (RGB: 37, 45, 55)
  Light Mode Bg:  #FAFBFC  (RGB: 250, 251, 252)
  Light Mode Fg:  #FFFFFF
  Light Mode Card: #F3F4F6
  
Emotion Accent Colors (for mood/emotion chips):
  Joy/Grateful:   #FFD85C  (Warm Yellow)   — Optimistic
  Peaceful:       #5B9BD5  (Soft Blue)     — Calm
  Loved:          #E85A8F  (Rose Pink)     — Connection
  Hopeful:        #A78BFA  (Lavender)      — Inspiration
  Grounded:       #84A366  (Sage Green)    — Nature
  
Secondary Greys (Text & Dividers):
  Dark Mode:
    Primary Text:      #E5E7EB  (RGB: 229, 231, 235)
    Secondary Text:    #9CA3AF  (RGB: 156, 163, 175)
    Tertiary Text:     #6B7280  (RGB: 107, 114, 128)
    Dividers:          #374151  (RGB: 55, 65, 81)
    Disabled:          #4B5563  (RGB: 75, 85, 99)
    
  Light Mode:
    Primary Text:      #1F2937  (RGB: 31, 41, 55)
    Secondary Text:    #6B7280  (RGB: 107, 114, 128)
    Tertiary Text:     #9CA3AF  (RGB: 156, 163, 175)
    Dividers:          #E5E7EB  (RGB: 229, 231, 235)
    Disabled:          #D1D5DB  (RGB: 209, 213, 219)

Status Colors:
  Success:  #10B981  (Matches Primary)
  Warning:  #F59E0B  (Amber)
  Error:    #EF4444  (Red)
  Info:     #3B82F6  (Blue)

Gradient Overlays (Premium Feel):
  Wellness Gradient: 
    From #2DD4A4 (Green) → To #5B9BD5 (Blue) — Serenity
    
  Golden Hour Gradient (Recording state):
    From #FFD85C (Yellow) → To #F97316 (Orange) — Energy
    
  Evening Gradient (Night mode variant):
    From #1E293B (Dark) → To #334155 (Slate) — Dusk
```

#### **Dark Mode Color Assignment (Primary)**

```dart
// Light/Dark Mode variants
Color.primary =          #2DD4A4 (Gratitude Green)
Color.primaryContainer = #1A3D35 (Dark green for containers)
Color.secondary =        #E85A8F (Rose Pink - emotion accent)
Color.tertiary =         #FFD85C (Warm Yellow - accent)

Surface.dark0 =          #0F1419 (True black - immersive)
Surface.dark1 =          #1A1F26 (Primary dark surface)
Surface.dark2 =          #252D37 (Elevated card)
Surface.dark3 =          #2E3847 (Floating action)

OnSurface.dark =         #E5E7EB (Primary text on dark)
OnSurface.dark.medium =  #9CA3AF (Secondary text)
OnSurface.dark.low =     #6B7280 (Tertiary text)

Outline.dark =           #374151 (Dividers)
```

### 3.2 Spacing System

```
Compact:   4px   (Internal component padding)
Tight:     8px   (Small gaps, icon spacing)
Cozy:     12px   (Input fields, chips)
Standard: 16px   (Standard card padding, section margins)
Generous: 24px   (Major section breaks)
Spacious: 32px   (Full-screen margins)
Abundant: 48px   (Breathing room, full-screen top/bottom)
```

### 3.3 Border Radius System

```
None:      0px     (Hard edges - rarely used)
Tight:     4px     (Icon containers, small chips)
Cozy:      8px     (Input fields, small modals)
Standard: 12px     (Cards, buttons, major UI elements)
Generous: 16px     (Rounded bottom sheets, full-width modals)
Pill:      999px   (Fully rounded for chips, FABs, badges)
```

### 3.4 Shadow System (Depth & Elevation)

```
Deep Dark Mode:
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

Light Mode (Softer):
  Elevation 1: shadowColor: #000000 @ 8%, blur: 8px, offset: 0,2
  Elevation 2: shadowColor: #000000 @ 12%, blur: 16px, offset: 0,4
  Elevation 3: shadowColor: #000000 @ 16%, blur: 24px, offset: 0,8
```

### 3.5 Typography System (Cairo Font - Arabic Native)

#### **Font Hierarchy**

```
Display: 
  Size: 32px
  Weight: Bold (700)
  Line Height: 40px
  Letter Spacing: -0.5px
  Usage: Onboarding titles, premium headers
  
Headline:
  Size: 28px
  Weight: Bold (700)
  Line Height: 36px
  Letter Spacing: -0.3px
  Usage: Screen titles, modal headers
  
Title Large:
  Size: 24px
  Weight: Semibold (600)
  Line Height: 32px
  Letter Spacing: 0px
  Usage: Card titles, section headers
  
Title Medium:
  Size: 20px
  Weight: Semibold (600)
  Line Height: 28px
  Letter Spacing: 0.1px
  Usage: Subsection titles, prominent stats
  
Title Small:
  Size: 16px
  Weight: Semibold (600)
  Line Height: 24px
  Letter Spacing: 0.1px
  Usage: Button labels, small card titles
  
Body Large:
  Size: 16px
  Weight: Regular (400)
  Line Height: 24px
  Letter Spacing: 0.5px
  Usage: Primary body text, gratitude content
  
Body Medium:
  Size: 14px
  Weight: Regular (400)
  Line Height: 20px
  Letter Spacing: 0.25px
  Usage: Secondary body text, metadata
  
Body Small:
  Size: 12px
  Weight: Regular (400)
  Line Height: 16px
  Letter Spacing: 0.4px
  Usage: Captions, timestamps, labels

Label Large:
  Size: 14px
  Weight: Semibold (600)
  Line Height: 20px
  Letter Spacing: 0.1px
  Usage: Chips, badges, tags
  
Label Medium:
  Size: 12px
  Weight: Semibold (600)
  Line Height: 16px
  Letter Spacing: 0.5px
  Usage: Small buttons, overlines
  
Label Small:
  Size: 11px
  Weight: Medium (500)
  Line Height: 14px
  Letter Spacing: 0.5px
  Usage: Tiny badges, time displays
```

---

## 4. COMPONENT SYSTEM (Flutter Cupertino)

### 4.1 Button Component Hierarchy

#### **Primary Button (Main CTA)**
```dart
// Style: Filled gradient background, white text
// Height: 52px
// Corner Radius: 12px
// Font: Title Small (16px Semibold)
// Padding: 0, 24px (horizontal)

Properties:
  enabled: true
  disabled: Opacity 0.5, no interaction
  loading: Spinner overlay, text hidden
  
Variants:
  - filled (primary green gradient)
  - outlined (stroke only, no fill)
  - ghost (text only, no stroke)
  - danger (red fill for destructive)

States:
  idle:      #2DD4A4 background
  pressed:   Lightens to #3AE8B0 + 4px lift
  disabled:  Opacity 0.5
  loading:   Small spinner, text fades

RTL: Text is naturally right-aligned via Flutter's Directionality
```

#### **Secondary Button (Alternative Action)**
```dart
// Style: Outlined stroke, transparent fill
// Height: 44px
// Corner Radius: 12px
// Font: Title Small (16px Semibold)
// Stroke: 1.5px #2DD4A4

Variants:
  - filled outline (stroke with light fill)
  - text only (no stroke or fill)
  - icon + text
```

#### **Icon Button (Action Trigger)**
```dart
// Style: Circular, 44px diameter
// Icon Size: 24px
// Background: Surface.dark2 on dark, F3F4F6 on light
// Ripple: Yes, animated scale 0.95 on press

Variants:
  - standard (no background, text-only)
  - filled (background color)
  - floating (elevated shadow)
  - outlined (stroke only)
```

### 4.2 Input Component Hierarchy

#### **Text Input Field**
```dart
// Height: 48px
// Corner Radius: 12px
// Padding: 12px (vertical), 16px (horizontal)
// Font: Body Medium (14px Regular)
// Border: 1px, idle: #374151, focused: #2DD4A4

Dark Mode:
  Background: #252D37
  Text: #E5E7EB
  Placeholder: #9CA3AF
  Border (idle): #374151
  Border (focused): #2DD4A4
  
Light Mode:
  Background: #F9FAFB
  Text: #1F2937
  Placeholder: #9CA3AF
  Border (idle): #E5E7EB
  Border (focused): #2DD4A4

States:
  idle:      Border #374151, no shadow
  focused:   Border #2DD4A4, elevation 1
  disabled:  Opacity 0.5, no interaction
  error:     Border #EF4444, error icon shown
  filled:    Success checkmark overlay

RTL: Label right-aligned, cursor on right, icons swap positions
```

#### **Textarea/Multi-line Input**
```dart
// Min Height: 120px
// Max Height: 240px (scrollable after)
// Corner Radius: 12px
// Padding: 16px
// Font: Body Large (16px Regular)
// Placeholder: "تحدث عن شيء تشكر عليه..."

Dynamic Height:
  Expands as user types
  Smooth height animation (200ms)
  
Character Count:
  Bottom-right, grey text
  Format: "X / 500"
  Color changes to orange at 80%, red at 95%
```

#### **Voice Waveform Visualizer (Recording Input)**
```dart
// Height: 48px
// Width: Full-width, 16px margins
// Style: Animated green bars on dark background
// Bar Width: 2px, spacing 2px
// Bars: 20-30 animated per second during recording

Color:
  Active: #2DD4A4
  Inactive (playback): #5B9BD5
  
Animation:
  Height varies with audio amplitude
  Smooth easing (Curves.easeInOutCubic)
  Responsive to real-time audio input
```

#### **Emotion/Mood Selector (Radio Chips)**
```dart
// Container Height: 60px
// Chip Size: 44px diameter (icon) + 8px label
// Style: Circular with emoji/icon, label below
// Spacing: 12px between chips

Emotions Offered:
  😊 مسرور (Joyful)    - #FFD85C
  😌 هادئ (Peaceful)   - #5B9BD5
  💗 محبوب (Loved)     - #E85A8F
  🌟 آمل (Hopeful)     - #A78BFA
  🌿 متجذر (Grounded)  - #84A366
  🤝 شاكر (Grateful)   - #2DD4A4

Selected State:
  Scale: 1.1
  Ring: 2px stroke in primary green
  Shadow: Elevation 2
  Animation: Spring curve (30ms)
  
Unselected State:
  Scale: 1.0
  Opacity: 0.6
  No shadow
```

### 4.3 Card Component System

#### **Gratitude Card (List Item)**
```dart
// Padding: 16px
// Corner Radius: 12px
// Background: Surface.dark2 (#252D37)
// Min Height: 80px
// Border: None (shadows provide depth)

Content Layout (RTL):
  [Icon/Emoji] [Time/Date] [Right 12px]
  [Gratitude Text Snippet] [Context/Category]
  
Text:
  Title: Title Small (16px Semibold), 2 lines max, truncated
  Subtitle: Body Small (12px Regular), grey text
  Time: Label Medium (12px Semibold), secondary grey

Interactions:
  Press: Elevation +1, background lightens 5%
  Long Press: Haptic feedback + context menu (edit/delete)
  Swipe Left (Delete): Red danger reveal
  Swipe Right (Archive): Subtle fade

States:
  normal:    Standard card
  hover:     Elevation 2, slight scale (1.01)
  selected:  Left border 4px green stripe
  archived:  Opacity 0.6
```

#### **Stat Card (Analytics)**
```dart
// Padding: 16px
// Corner Radius: 12px
// Background: Linear gradient (top: dark2, bottom: dark1)
// Min Height: 100px

Layout (RTL):
  [Large Number] [Right 8px] [Label/Description]
  [Small Icon] [Trend Indicator (up/down)]
  
Typography:
  Number: Title Large (24px Semibold), primary green
  Label: Body Medium (14px Regular), secondary text
  Trend: Label Small (11px Semibold), green or orange

Variants:
  - metric (number + label)
  - percentage (with progress ring)
  - streak (with flame icon)
  - average (with sparkline)
```

#### **Floating Action Button (FAB)**
```dart
// Size: 56px diameter (base), 48px (compact)
// Corner Radius: 999px (fully rounded)
// Background: Linear gradient (#2DD4A4 → #10B981)
// Icon: 24px, white, centered
// Position: Bottom right, 24px from edges

Elevation:
  idle:    Elevation 3 (24px shadow)
  pressed: Elevation 2 (16px shadow) + scale 0.95
  
Animation:
  Pulse: Subtle breathing animation (1.2s cycle)
  Haptic: Light tap on press
  
RTL Swap:
  Bottom left (mirrored for RTL context)
```

### 4.4 Modal & Sheet Components

#### **Bottom Sheet (Recording Modal)**
```dart
// Height: 90% of screen (draggable to 70%)
// Corner Radius Top: 24px
// Background: Surface.dark1
// Drag Handle: 4px × 48px, #6B7280, centered top
// Padding: Standard 16px (with safe area)

Content Layout:
  [Top] Header (Title + Close button)
  [Center] Main content area (scrollable)
  [Bottom] Primary + secondary actions (safe area aware)
  
Interaction:
  Drag up/down: Smooth tracking
  Threshold swipe down: Dismiss with deceleration animation
  Gesture: Haptic on dismiss

RTL:
  Close button: Right side
  Actions: Right-aligned layout
```

#### **Alert Dialog (Delete Confirmation)**
```dart
// Width: 90%, max 400px
// Corner Radius: 16px
// Background: Surface.dark2
// Padding: Generous 24px

Layout:
  [Top] Icon + Title
  [Center] Description text (scrollable if long)
  [Bottom] Primary (red) + Secondary buttons

Buttons:
  Primary (Destructive): Red fill, right side
  Secondary (Cancel): Outlined, left side
  
Animation:
  Scale in from center (200ms)
  Fade background dimmer (200ms)
```

### 4.5 Navigation Components

#### **Tab Bar (Bottom Navigation)**
```dart
// Height: 56px (+ safe area inset)
// Position: Bottom fixed
// Background: Surface.dark1 (#1A1F26)
// Border Top: 1px #374151

Tabs:
  1. Home (House icon)
  2. Record (Microphone icon)
  3. Timeline (Calendar icon)
  4. Analytics (Chart icon)
  5. Settings (Gear icon)

Icon Specs:
  Size: 24px
  Inactive: Opacity 0.6, grey (#9CA3AF)
  Active: Opacity 1.0, primary green (#2DD4A4)
  
Label:
  Font: Label Medium (12px Semibold)
  Only shown when active
  Fade in/out (150ms)
  
Indicator:
  Option 1: Underline 3px green
  Option 2: Background pill shape
  Animation: Slide to position (200ms)

RTL:
  Icons naturally swap positions
  Animation direction mirrors
  Label positioning reverses
```

#### **Top Navigation Bar (Header)**
```dart
// Height: 44px (iOS standard)
// Background: Surface.dark1 or transparent over content
// Blur: Optional (dark mode friendly)

Content:
  [Left] Back button or menu
  [Center] Title or logo
  [Right] Action buttons (1-2 max)

Safe Area: Top inset respected

States:
  scrolled: Background becomes opaque, shadow appears
  top: Background transparent if over content
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
- Background gradient: Dark1 (#1A1F26) → Dark0 (#0F1419) (subtle)
- Card shadows: Deep dark elevation 2
- Text: Primary grey (#E5E7EB) with secondary accents
- Accent: Green primary (#2DD4A4) on ring charts

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
- Modal background: Surface.dark1 (#1A1F26)
- Waveform bars: Primary green (#2DD4A4)
- Text input: Dark2 surface (#252D37) with grey border
- Emotion chips: Light tint backgrounds (Joy: #FFD85C at 20% opacity)

**Micro-interactions:**
- **Record Press:** Spring scale (0.9 → 1.0), haptic medium
- **Waveform Bars:** Smooth amplitude response, no lag
- **Emotion Chip Select:** Scale 1.1 + ring glow (150ms spring)
- **Next Button:** Slide transition (300ms ease-out) to next step
- **Save Success:** Haptic triple-tap + toast "تم حفظ شكرك"

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
- Background: Gradient dark1 → dark0
- Cards: Dark2 surface with subtle shadows
- Audio player: Green waveform on dark2

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
- Stat cards: Dark2 background, green text for large numbers
- Charts: Dark background, bright accent colors
- Pie slices: Muted emotion colors + glow on hover
- Text: Primary grey

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
- Sections: Dark2 background with subtle borders
- Toggle switches: Green when ON, grey when OFF
- Danger buttons: Red fill, white text
- Text: Primary grey on dark background

**Micro-interactions:**
- Toggle switch: Spring animation, haptic feedback
- Slider: Smooth real-time preview (e.g., font size)
- Time picker: Modal with haptic feedback on selection
- Red buttons: Scale 0.95 on press, confirmation dialog after tap

---

## 6. DARK MODE SPECIFICATIONS

### 6.1 Color Mapping (Dark Mode Primary)

```dart
// Global theme override
final darkTheme = CupertinoThemeData(
  brightness: Brightness.dark,
  primaryColor: Color(0xFF2DD4A4), // Gratitude Green
  primaryContrastingColor: Color(0xFFFFFFFF), // White
  scaffoldBackgroundColor: Color(0xFF0F1419), // True black
  
  barBackgroundColor: Color(0xFF1A1F26), // Dark slate bar
  
  // Text themes
  textTheme: CupertinoTextThemeData(
    primaryColor: Color(0xFF2DD4A4), // Primary green
    textStyle: TextStyle(
      color: Color(0xFFE5E7EB), // Primary text
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  ),
);

// Surface colors for custom widgets
const surfaceColors = {
  'dark0': Color(0xFF0F1419), // Background
  'dark1': Color(0xFF1A1F26), // Primary surface
  'dark2': Color(0xFF252D37), // Elevated card
  'dark3': Color(0xFF2E3847), // Floating elements
};
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
- Border (focused): #2DD4A4
- Cursor: #2DD4A4
- Placeholder: #9CA3AF

**Buttons:**
- Primary: Green gradient (#2DD4A4 → #10B981)
- Secondary: Outlined, no fill
- Text: White on green background

**Waveform:**
- Active bars: #2DD4A4
- Inactive bars: #5B9BD5
- Background: Transparent or dark2 container

**Charts:**
- Background: Transparent (inherits surface)
- Line/bars: Primary green
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

- [ ] **Colors:** Define all hex codes in `lib/core/theme/colors.dart`
- [ ] **Typography:** Export Cairo font styles from `lib/core/theme/typography.dart`
- [ ] **Components:** Create Cupertino-based widgets in `lib/shared/widgets/`
- [ ] **Animations:** Define reusable animation curves in `lib/core/animations/`
- [ ] **Spacing:** Use consistent padding/margin from spacing token enum
- [ ] **Dark Mode:** Test all screens in both light & dark modes
- [ ] **RTL:** Verify all text, icons, and layouts in RTL context
- [ ] **Accessibility:** Add semantic labels and test with VoiceOver
- [ ] **Assets:** Export vector icons as SVGs, raster in @2x/@3x
- [ ] **Haptics:** Integrate HapticFeedback for all interactive elements
- [ ] **Localization:** Set up Arabic translations in `lib/l10n/`

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
1. Implement design tokens in Flutter theme
2. Create reusable component library
3. Test dark mode and RTL across all screens
4. Gather user feedback on recording flow
5. Iterate on analytics visualizations

---

**Design System v1.0 — June 2024**  
**Platform:** iOS (Cupertino) | **Language:** Arabic (RTL) + English  
**Team:** Design → Flutter Handoff
