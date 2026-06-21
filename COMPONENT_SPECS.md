# Component Specification Guide — Detailed Dimensions & States

## 1. BUTTON SPECIFICATIONS

### Primary Button (Call-to-Action)

```
┌─────────────────────────────────┐
│ سجل شكرك                        │ ← Text: Title Small (16px Bold)
└─────────────────────────────────┘

Size Specs:
  Height:             52px
  Min Width:          120px (text dependent)
  Padding:            16px (horizontal), 0px (vertical)
  Border Radius:      12px
  Font:               Cairo Bold 16px
  
Color (Dark Mode):
  Background:         Solid #0A7E6B
  Text:               #FFFFFF (white)
  Border:             None
  Shadow:             Elevation 3 (8px blur, 30% opacity black, 4px offset)
  
Color (Light Mode):
  Background:         Solid #0A7E6B
  Text:               #FFFFFF
  Border:             None
  Shadow:             Elevation 2 (4px blur, 12% opacity black)

States:
  Idle:
    Background:       Solid #0A7E6B
    Transform:        Scale 1.0
    Cursor:           Pointer
    
  Pressed/Active:
    Background:       Darkened by 5%
    Transform:        Scale 0.98
    Shadow:           Elevation 2 (reduced)
    Duration:         150ms (Curves.easeInOutCubic)
    Haptic:           Medium
    
  Disabled:
    Background:       Solid #0A7E6B at 50% opacity
    Text:             #9CA3AF (grey)
    Transform:        Scale 1.0
    Cursor:           Not-allowed
    Opacity:          0.6
    
  Loading:
    Background:       Solid #0A7E6B
    Text:             Hidden
    Spinner:          20px CupertinoActivityIndicator (white)
    Duration:         Continuous

Icon + Text Variant:
  Icon Size:          20px
  Icon Color:         #FFFFFF
  Icon Position:      Left of text (LTR) / Right of text (RTL)
  Gap:                8px
  
RTL Layout:
  Text Direction:     Right-to-left
  Icon Position:      Right side
  Text Alignment:     Center
```

### Secondary Button (Alternative Action)

```
┌─ الرجوع ─┐
└─────────┘

Size Specs:
  Height:             44px
  Min Width:          110px
  Padding:            12px (horizontal)
  Border Radius:      12px
  Border:             1.5px solid
  Font:               Cairo Semibold 16px

Color (Dark Mode):
  Background:         Transparent
  Text:               #0A7E6B (primary green)
  Border:             #0A7E6B
  
Color (Light Mode):
  Background:         Transparent
  Text:               #0A7E6B
  Border:             #0A7E6B

States:
  Idle:
    Border:           1.5px solid color
    Background:       Transparent
    Opacity:          1.0
  
  Pressed:
    Background:       Color at 10% opacity
    Border:           1.5px solid (same color)
    Transform:        Scale 0.97
    Haptic:           Light
    
  Disabled:
    Border:           1.5px at 30% opacity
    Text:             Grey at 50% opacity
    Cursor:           Not-allowed
```

### Icon Button (Compact Action)

```
┌──────┐
│      │ ← 24px icon
└──────┘

Size Specs:
  Width:              44px
  Height:             44px
  Border Radius:      8px (or 999px for pill)
  Icon Size:          24px
  Padding:            10px (centered)

Color (Dark Mode):
  Background:         #252D37 (surface2Dark) or transparent
  Icon Color:         #E5E7EB (primary text)
  
Color (Light Mode):
  Background:         #F3F4F6 or transparent
  Icon Color:         #1F2937

States:
  Idle:
    Background:       Specified color
    Icon:             Opacity 1.0
    
  Pressed:
    Background:       Lightened by 10%
    Transform:        Scale 0.95
    Ripple:           Ink splash effect
    
  Loading:
    Icon:             Hidden
    Spinner:          18px CupertinoActivityIndicator
```

---

## 2. INPUT FIELD SPECIFICATIONS

### Text Input (Single Line)

```
┌────────────────────────────────────┐
│ البريد الإلكتروني ← Label (12px Grey) │
├────────────────────────────────────┤
│ اكتب بريدك هنا                      │ ← Input text (16px)
│                                    │
└────────────────────────────────────┘

Size Specs:
  Height:             48px
  Padding:            12px (vertical), 16px (horizontal)
  Border Radius:      12px
  Border:             1px solid
  Font:               Cairo Regular 16px
  Line Height:        1.5 (24px)

Color (Dark Mode):
  Background:         #252D37 (surface2Dark)
  Text:               #E5E7EB (primary text)
  Placeholder:        #9CA3AF (secondary text)
  Border (Idle):      #374151 (outline)
  Border (Focused):   #0A7E6B (primary)
  Cursor:             #0A7E6B
  
Color (Light Mode):
  Background:         #F9FAFB
  Text:               #1F2937
  Placeholder:        #9CA3AF
  Border (Idle):      #E5E7EB
  Border (Focused):   #0A7E6B

States:
  Idle:
    Border:           1px solid, width auto
    Shadow:           None
    
  Focused:
    Border:           1px solid #0A7E6B
    Shadow:           Elevation 1 (8px blur)
    
  Filled (with text):
    Border:           1px solid #0A7E6B
    Text:             #E5E7EB
    
  Disabled:
    Background:       Opacity 50%
    Text:             #6B7280 (tertiary text)
    Border:           #374151 at 30% opacity
    Cursor:           Not-allowed
    
  Error State:
    Border:           1px solid #EF4444 (red)
    Icon:             Red indicator
    Helper Text:      "هذا الحقل مطلوب" (12px red)
    
  Success State:
    Border:           1px solid #10B981 (green)
    Icon:             Green checkmark
```

### Textarea (Multi-line)

```
┌──────────────────────────────────────────┐
│ تحدث عن شيء تشكر عليه...                │ (Placeholder)
│                                          │
│ أنا ممتن على دعم عائلتي والأصدقاء الذين│
│ وقفوا بجانبي في وقت الحاجة. هذا الدعم   │
│ ساعدني كثيراً على التغلب على الصعوبات  │
│                                          │
│                                          │
│                                    10/500│ ← Character count
└──────────────────────────────────────────┘

Size Specs:
  Min Height:         120px
  Max Height:         240px (scrollable after)
  Padding:            16px
  Border Radius:      12px
  Border:             1px solid
  Font:               Cairo Regular 16px
  Line Height:        1.5

Behavior:
  Auto-expand:        Smooth height animation (200ms) as user types
  Min rows:           4
  Max rows:           10 (then scrollable)
  Character Counter:  Bottom right, "X / 500"
  
Counter Colors:
  0–80%:              Grey (#9CA3AF)
  80–95%:             Orange (#F59E0B) ← Warning
  95–100%:            Red (#EF4444) ← Danger
```

### Emotion/Mood Selector (Chips)

```
┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐
│        │ │        │ │        │ │        │ │        │
│ مسرور  │ │ هادئ   │ │ محبوب  │ │ آمل    │ │ متجذر  │
└────────┘ └────────┘ └────────┘ └────────┘ └────────┘
  Joy    +  Peace   +   Love   +   Hope   +  Grounded

Container Size:
  Height:             120px (icon + label)
  Spacing:            12px (between chips)
  
Single Chip:
  Icon Container:     44px diameter circle
  Icon Size:          24px (icon)
  Label Font:         Cairo Regular 12px
  Label Color:        #E5E7EB
  Gap (icon to text): 8px vertical

Colors:
  Joy/Grateful:   Background #FFD85C at 20% opacity on dark
  Peaceful:       Background #5B9BD5 at 20% opacity
  Loved:          Background #E85A8F at 20% opacity
  Hopeful:        Background #A78BFA at 20% opacity
  Grounded:       Background #84A366 at 20% opacity

States:
  Unselected:
    Border:           None
    Icon:             Opacity 0.7
    Background:       Transparent
    Scale:            1.0
    
  Hovered:
    Border:           None
    Icon:             Opacity 0.9
    Scale:            1.05
    
  Selected:
    Border:           2px solid, matching emotion color
    Background:       Emotion color at 15% opacity
    Icon:             Opacity 1.0
    Scale:            1.1
    Ring Glow:        Soft shadow matching color
    Animation:        Spring curve (200ms, elasticOut)
    Haptic:           Light tap feedback
```

---

## 3. CARD SPECIFICATIONS

### Gratitude Card (List Item)

```
┌────────────────────────────────────────┐
│ [2:45 PM - 12 minutes ago]            │ ← Emotion icon + timestamp
├────────────────────────────────────────┤
│ شكرت على دعم الأسرة والأصدقاء الذين  │ ← Title (2 lines max, truncated)
│ وقفوا بجانبي في وقت الحاجة           │
├────────────────────────────────────────┤
│ [صحة]  [أسرة]  [دعم معنوي]           │ ← Category badges
└────────────────────────────────────────┘

Size Specs:
  Min Height:         80px
  Padding:            16px
  Margin Bottom:      12px
  Border Radius:      12px
  Shadow:             Elevation 2
  
Typography:
  Header:             Title Small (16px Bold) - emotion + time
  Body:               Body Large (16px Regular) - 2 lines max
  Metadata:           Label Medium (12px Semibold) - categories
  
Color (Dark Mode):
  Background:         #252D37 (surface2Dark)
  Text (Primary):     #E5E7EB
  Text (Secondary):   #9CA3AF
  Badge BG:           #0A7E6B at 15% opacity
  Badge Text:         #0A7E6B

States:
  Idle:
    Shadow:           Elevation 2 (16px blur, 8px offset)
    Transform:        Scale 1.0
    Border:           None
    
  Hover:
    Shadow:           Elevation 2 (slight enhancement)
    Transform:        Scale 1.01
    Background:       Lightened by 5%
    
  Selected:
    Border:           Left 4px solid #0A7E6B (stripe)
    Background:       Unchanged
    
  Pressed:
    Shadow:           Elevation 1 (reduced)
    Transform:        Scale 0.98
    Transition:       300ms ease-out (to detail page)
    
  Swipe-to-Delete:
    Duration:         200ms reveal
    Reveal Color:     #EF4444 (red)
    Icon:             Trash can
    Haptic:           Medium warning tap before confirming
```

### Stat Card (Analytics)

```
╔════════════════════════════════════════╗
║ 12 شكر       ↑ 3 من أمس             ║ ← Large number + trend
║                                        ║
║ شكر هذا الشهر                          ║ ← Label description
╚════════════════════════════════════════╝

Gradient Background:
  Top:        #252D37 (surface2)
  Bottom:     #1A1F26 (surface1)
  Direction:  Top → Bottom (vertical)

Size Specs:
  Min Height:         100px
  Padding:            16px
  Border Radius:      12px
  Shadow:             Elevation 2

Typography:
  Number:             Title Large (24px Bold) - primary green
  Label:              Body Medium (14px Regular) - grey
  Trend:              Label Small (11px Semibold) - green or orange
  
Color (Dark Mode):
  Number:             #0A7E6B (primary green)
  Label:              #9CA3AF (secondary)
  Trend Up:           #10B981 (green)
  Trend Down:         #F59E0B (orange)
```

### Breathing Button (44px circular)

```
    ┌───────────┐
    │           │
    │     +     │ ← 24px icon
    │           │
    └───────────┘
       44px

Size Specs:
  Diameter:           44px
  Icon Size:          24px
  Border Radius:      999px (fully rounded)
  Position:           Bottom-right (LTR) / Bottom-left (RTL), 24px inset
  
Color (Dark Mode):
  Background:         Solid #0A7E6B
  Icon Color:         #FFFFFF
  
Elevation:
  Idle:               Elevation 3 (24px shadow)
  Pressed:            Elevation 2 (16px shadow)
  
Animation:
  Breathing Pulse:    1.2s cycle
    Min Opacity:      0.8
    Max Opacity:      1.0
    Timing:           Curves.easeInOutCubic
  
  Press Animation:
    Duration:         150ms
    Scale:            1.0 → 0.95
    Haptic:           Light feedback

RTL Adjustment:
  Position:           Bottom-left instead of bottom-right
  Icon Direction:     No change (icon is symmetrical)
```

---

## 4. MODAL & SHEET SPECIFICATIONS

### Bottom Sheet Modal

```
┌─────────────────────────────────────────┐
│ ────── Drag ────────────────────       │ ← 4px × 48px handle
├─────────────────────────────────────────┤
│ سجل شكرك        [Close]                │ ← Header
│ [خطوات: 1 / 3]                          │ ← Progress bar
├─────────────────────────────────────────┤
│                                         │
│ [Main Content Area - Scrollable]       │
│                                         │
├─────────────────────────────────────────┤
│ [الرجوع]  [التالي]                     │ ← Button footer
└─────────────────────────────────────────┘

Size Specs:
  Height:             90% of screen (min draggable to 70%)
  Corner Radius Top:  24px
  Background:         #1A1F26 (surface1Dark)
  Border:             None
  
Drag Handle:
  Size:               4px height × 48px width
  Border Radius:      2px
  Color:              #6B7280 (tertiary grey)
  Position:           Centered top, 8px below surface

Content Area:
  Padding:            Standard 16px (with safe area)
  Scrollable:         Yes (if content exceeds available space)
  
Header:
  Title Font:         Headline (28px Bold)
  Close Button:       Icon button, top-right
  
Progress Bar:
  Height:             4px
  Background:         #374151 (outline dark)
  Fill Color:         #0A7E6B (primary)
  Fill Progress:      Based on step (1/3, 2/3, 3/3)
  
Button Footer:
  Spacing:            12px between buttons
  Layout:             Row with 2 buttons (equal width)
  Safe Area:          Respected for iPhone with notch

Interactions:
  Drag Up:            Smooth tracking, 60fps
  Drag Down > Threshold: Dismiss with deceleration
  Swipe Down:         Quick dismiss animation (250ms)
  
Animations:
  Entry:              Slide up from bottom (300ms ease-out)
  Exit:               Slide down (250ms ease-in)
  Dimmer Fade:        Background dimming (200ms)
```

---

## 5. NAVIGATION BAR SPECIFICATIONS

### Bottom Tab Bar

```
┌─────────────────────────────────────────┐
│ Home │ Record │ Timeline │ Chart │       │
│      │        │          │       │       │
└─────────────────────────────────────────┘

Size Specs:
  Height:             56px (+ safe area inset)
  Position:           Fixed bottom
  Background:         #1A1F26 (surface1Dark)
  Border Top:         1px #374151 (divider)
  Safe Area:          Respected (adds padding below)
  
Tab Item:
  Width:              Equal distribution (20% each)
  Padding:            8px (horizontal), 8px (vertical)
  
Icon:
  Size:               24px
  Opacity (inactive): 0.6
  Opacity (active):   1.0
  Color (inactive):   #9CA3AF (secondary grey)
  Color (active):     #0A7E6B (primary green)
  
Label:
  Font:               Label Medium (12px Semibold)
  Opacity:            0 (hidden by default)
  Appears on Active:  Fades in (150ms)
  Color:              #0A7E6B when active

Indicator:
  Style:              Underline or pill background
  Height:             3px (underline) or background fill
  Color:              #0A7E6B
  Animation:          Slide to position (200ms ease-out)

States:
  Inactive Tab:
    Icon:             #9CA3AF, scale 1.0
    Label:            Hidden
    
  Active Tab:
    Icon:             #0A7E6B, scale 1.0
    Label:            Visible, fade-in 150ms
    Indicator:        Animated to position
    
  Pressed:
    Icon:             #0A7E6B
    Haptic:           Light impact
    Transition:       Instant icon color, smooth animation for content

RTL Rendering:
  Tab Order:          Right-to-left direction
  Icons:              Naturally mirror for RTL
  Animation:          Direction reverses (slide from left)
```

---

## 6. ANIMATION SPECIFICATIONS

### Button Press Interaction

```
Timeline:
  0ms:    Scale 1.00, Shadow elevation 3
  75ms:   Scale 0.99 (halfway press)
  150ms:  Scale 0.98 (full press), Shadow elevation 2
  ↓
  Release:
  0ms:    Scale 0.98, Shadow elevation 2
  150ms:  Scale 1.00, Shadow elevation 3
  
Curve:   Curves.easeInOutCubic
Haptic:  Medium impact (heavy vibration)
```

### Emotion Chip Selection

```
Timeline:
  0ms:    Scale 1.00, Opacity 0.7, ring opacity 0
  100ms:  Scale 1.15 (peak)
  150ms:  Scale 1.10 (settle)
  200ms:  Scale 1.08 (final), ring opacity 1.0, glow visible
  
Curve:   Curves.elasticOut
Haptic:  Light feedback
```

### Screen Transition (Push)

```
Duration:         300ms
Curve:            Curves.easeOutCubic

Incoming Screen:
  - Horizontal slide: From right → center
  - Opacity:         0% → 100%
  
Background Dimmer:
  - Opacity:         0% → 20%
  - Curve:           Linear

RTL Variant:
  - Slide direction: From left (reversed)
  - All other specs: Same
```

### Waveform Visualizer (Audio Recording)

```
Update Frequency:  30 times per second
Bar Count:         20–30 bars
Bar Animation:     10ms linear interpolation
Bar Width:         2px
Bar Spacing:       2px

Idle (no audio):
  Bar Height:      3px (baseline)
  Pulsing:         0.8 → 1.0 opacity (600ms cycle)
  
Recording (audio input):
  Bar Height:      Varies 3px → 100% height
  Update:          Real-time amplitude tracking
  Easing:          Curves.easeInOutCubic (10ms)
  
Playback:
  Bar Height:      Follows waveform data
  Progress Line:   Vertical indicator sweeping L→R (LTR) / R→L (RTL)
  Sync:            60fps with audio position
```

---

## 7. DARK MODE COLOR MAPPING

### Component Color Reference

```
Element Type         Color Token         Hex Code      Usage
────────────────────────────────────────────────────────
Primary Action       primary             #0A7E6B       Buttons, links, active states
Primary Container    primaryContainer    #1A3D35       Button backgrounds
Secondary Accent     secondary           #E85A8F       Emotion: Love
Tertiary Accent      tertiary            #FFD85C       Emotion: Joy

Surface Levels:
  Level 0 (Background)    surface0Dark    #0F1419       App background
  Level 1 (Primary)       surface1Dark    #1A1F26       Bars, surfaces
  Level 2 (Cards)         surface2Dark    #252D37       Cards, containers
  Level 3 (Floating)      surface3Dark    #2E3847       FAB, popovers

Text:
  Primary                 onSurface       #E5E7EB       Main text
  Secondary               onSurface       #9CA3AF       Metadata, hints
  Tertiary                onSurface       #6B7280       Disabled, placeholders

Outline:
  Dividers               outlineDark      #374151       Borders, dividers

Status:
  Success                success          #10B981       Confirmations
  Warning                warning          #F59E0B       Warnings
  Error                  error            #EF4444       Errors
  Info                   info             #3B82F6       Info messages
```

---

## 8. RESPONSIVE SPECIFICATIONS

### iPhone Sizes

```
Device               Screen      Safe Area      Component Notes
─────────────────────────────────────────────────────────────
iPhone SE (3rd)      375 × 667   (0, 47)        Standard compact
iPhone 14            390 × 844   (0, 47)        Standard
iPhone 14 Plus       430 × 932   (0, 47)        Larger comfortable
iPhone 14 Pro        390 × 844   (0, 59)        Dynamic Island
iPhone 14 Pro Max    430 × 932   (0, 59)        Dynamic Island + large

Breakpoints:
  Compact:           < 400 (SE) — Use 12px padding instead of 16px
  Standard:          400–430 (Regular models)
  Large:             > 430 (Plus/Pro Max)

Component Adjustments:
  Button Height:     Always 52px (respects safe areas)
  Bottom Tab:        Always 56px + safe area inset
  Modal Content:     Max 90% height, respects notch/Dynamic Island
  Card Padding:      Always 16px (no responsive change)
```

---

## 9. TESTING SPECIFICATIONS

### Visual QA Checklist

- [ ] **Colors:** Validate hex codes match design tokens (use color picker)
- [ ] **Shadows:** Verify elevation levels are distinct (no muddy shadows)
- [ ] **Typography:** Check line heights, letter spacing on all text sizes
- [ ] **Spacing:** Confirm 4px-based grid adherence (use ruler)
- [ ] **Border Radius:** Verify consistency (12px for cards, 4px for small)
- [ ] **Icons:** Ensure 24px size (not stretched or too small)
- [ ] **Animations:** Check 60fps smoothness (use device fps counter)
- [ ] **Haptics:** Test feedback on button press, chip selection
- [ ] **Dark Mode:** All screens rendering with correct colors
- [ ] **RTL:** Text flowing right-to-left, icons mirrored where needed
- [ ] **Accessibility:** VoiceOver labels present, contrast ratios ≥ 4.5:1

### Performance Targets

- Waveform: 30fps smooth animation
- List scroll: 60fps infinite scroll
- Transitions: 300ms smooth (no dropped frames)
- Charts: 200ms transition with 60fps rendering
- Audio playback: Non-blocking UI updates

---

## Summary Table

| Component | Height | Width | Corner Radius | Font Size | Shadow |
|-----------|--------|-------|---|---|---|
| Primary Button | 52px | Auto | 12px | 16px | Elev 3 |
| Secondary Button | 44px | Auto | 12px | 16px | None |
| Icon Button | 44px | 44px | 8px | 24px icon | None |
| Text Input | 48px | Full | 12px | 16px | Elev 1 (focused) |
| Gratitude Card | 80px+ | Full | 12px | 16px | Elev 2 |
| Stat Card | 100px+ | Full | 12px | 24px | Elev 2 |
| Bottom Tab Bar | 56px | Full | 0px | 12px | Border top |
| Breathing Button | 44px | 44px | 999px | 24px icon | Elev 3 |

---

**Component Specification Guide v1.0**  
**All measurements in pixels (px), all colors in hex codes (#)**  
**Flutter implementation ready**
