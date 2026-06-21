# Recording Experience — Deep Dive Design Document

## 1. RECORDING FLOW OVERVIEW

**Goal:** One-tap to start, smooth voice capture, optional enrichment, one-tap save.

**Current Pain Points:**
- 3 separate complex steps feel laborious
- Emotion selection comes after recording (retroactive)
- No visual feedback during recording
- Save confirmation unclear

**Premium Solution:**
- Single unified modal with progressive disclosure
- Waveform visualizer provides real-time audio feedback
- Inline emotion/text enrichment (optional)
- Haptic + toast confirmation on save
- Auto-save on app backgrounding (never lose recording)

---

## 2. RECORDING MODAL SPEC

### Visual Layout (RTL)

```
┌─────────────────────────────────────────────────────┐
│ ◄─────────────── Drag Handle ──────────────────► │ (8pt)
├─────────────────────────────────────────────────────┤
│ سجل شكرك        [✕ Close]                        │ (Header)
│ [Progress: 1 / 3]                                │ (Linear progress bar)
├─────────────────────────────────────────────────────┤
│                                                     │
│ 🎤 الخطوة 1: سجل صوتياً                         │ (Step title)
│ اضغط الزر وتحدث بطبيعية حول ما تشكر عليه       │ (Hint text)
│                                                     │
│    ╔═════════════════════════════════════╗         │
│    ║  ⏹  00:32                            ║         │ (Record button + timer)
│    ║  ▁▂▃▄▅▆▇█▇▆▅▄▃▂▁ ▁▂▃▄▅            ║         │ (Waveform visualizer)
│    ║                                     ║         │
│    ╚═════════════════════════════════════╝         │
│                                                     │
│ [📝 + Text Input (optional)]                     │
│ ┌─────────────────────────────────────────┐       │
│ │ أضف نص تفصيلي (اختياري)                │       │
│ └─────────────────────────────────────────┘       │
│                                                     │
│ ┌─────────────────────────────────────────┐       │
│ │ كيف تشعر؟                               │       │ (Emotion selector)
│ │ 😊  😌  💗  🌟  🌿                    │       │
│ └─────────────────────────────────────────┘       │
│                                                     │
│ [📸 Attach Photo (optional)]                      │
│                                                     │
├─────────────────────────────────────────────────────┤
│ [← الرجوع]           [التالي →]                 │ (Navigation buttons)
└─────────────────────────────────────────────────────┘
```

### Size & Layout Specs

```
Height:             90% of screen
Min Draggable:      70% (can collapse, not dismiss)
Corner Radius:      24px (top only)
Background:         #1A1F26 (surface1Dark)
Safe Area:          Respected (20px+ bottom inset)

Drag Handle:
  Size:             4px × 48px
  Color:            #6B7280
  Positioning:      Centered top, 8px from surface

Header:
  Title:            "سجل شكرك" (Headline 28px Bold)
  Close Button:     Icon button, top-right corner
  Height:           44px

Progress Bar:
  Height:           4px
  Background:       #374151
  Fill:             #0A7E6B (animated)
  Position:         Below header, full width

Content Area:
  Padding:          16px (sides), 20px (top/bottom)
  Scrollable:       Yes (if content > available height)
  Max Width:        400px (centered on large screens)

Button Footer:
  Height:           60px (includes safe area)
  Padding:          16px
  Gap:              12px between buttons
  Spacing Layout:   [ Back Button ] [ 12px ] [ Next Button ]
  Button Width:     Equal flex
```

---

## 3. STEP 1: AUDIO RECORDING

### Record Button Specification

```
        ┌──────────────┐
        │              │
        │     ⏹ 🔴     │  ← 72px diameter with icon
        │              │
        └──────────────┘
           Recording...
          (00:32)

Size & Appearance:
  Diameter:           72px
  Border Radius:      999px (fully rounded)
  Background:         Solid #0A7E6B
  Icon:               ⏹ (Circle icon), 32px, white
  Inner Glow:         Optional animated ring (1.2s cycle)
  Shadow:             Elevation 3 (24px blur, 8px offset)
  
Typography:
  Status Text:        "Recording..." (Body Medium, 14px, grey)
  Timer:              "00:32" (Title Small, 16px, bold green)
  Position:           Centered below button

States:

Idle (not recording):
  Background:         Solid (#0A7E6B)
  Icon:               ▶ Play icon (24px)
  Scale:              1.0
  Ring:               Subtle pulse (0.8 → 1.0 opacity, 1.2s)
  Text:               "اضغط للتسجيل"
  
Press (starting):
  Scale:              1.0 → 0.9 (150ms spring out)
  Ring:               Visible glow
  Haptic:             Heavy impact (medium-strong vibration)
  Text:               Fade to "Recording..."
  
Recording (active):
  Background:         Solid #0A7E6B
  Icon:               ⏹ Stop icon (24px)
  Scale:              1.0
  Ring:               Pulsing glow (1.0 → 1.3 opacity, 600ms cycle)
  Timer:              Incrementing (MM:SS format)
  Haptic:             None (continuous)
  
Long Recording (5+ min):
  Border Color:       Gradual fade to orange (#F59E0B)
  Warning Text:       "Long recording - consider saving soon"
  Haptic:             Periodic light tap (every 10s after 5min)
  
Stop Press:
  Scale:              1.0 → 0.95 (150ms compress)
  Haptic:             Medium impact
  Text:               Fade to "Processing..."
  
Error State (mic permission):
  Background:         Greyed out (#6B7280 at 50%)
  Icon:               ⚠️ Warning icon
  Text:               "Permission required"
  Button:             Opens settings
  Disabled:           No interaction
```

### Waveform Visualizer

```
┌──────────────────────────────────────────┐
│ ▁▂▃▄▅▆▇█▆▅▄▃▂▁▂▃▄▅▆▇█▇▆▅▄▃▂▁        │
└──────────────────────────────────────────┘

Specifications:
  Height:             48px (fits within modal)
  Width:              Full-width - 32px padding
  Bar Count:          25 bars
  Bar Width:          2px
  Bar Spacing:        2px
  Bar Radius:         1.5px (rounded top)
  Container BG:       Transparent

Colors:
  Active Bars:        #0A7E6B (primary green)
  Inactive Bars:      #374151 (grey outline)
  Background:         Transparent (or #252D37 container)

Animation Behavior:

Idle (no recording):
  Bar Height:         3px baseline
  Animation:          Subtle pulsing (0.8 → 1.0 opacity, 600ms)
  Curve:              Curves.easeInOutCubic
  
Recording (live audio):
  Update Frequency:   30 times per second
  Height Mapping:     Amplitude → bar height (3px to 100% height)
  Interpolation:      Smooth 10ms tween between updates
  Peak Lock:          Don't exceed 100% of container
  Curve:              Linear (instant response, then ease)
  
Playback (reviewing):
  Height Mapping:     Pre-recorded waveform data
  Progress Line:      Vertical indicator sweeping left-to-right (LTR) or right-to-left (RTL)
  Sync:               60fps with audio playback position
  Interactive:        Tap to seek, swipe to scrub

Tech Implementation:
  Audio Package:      flutter_sound or just_audio
  Amplitude Callback: Called every 50ms during recording
  Waveform Cache:     Store normalized amplitude array (0.0 → 1.0)
  Performance:        GPU-accelerated via CustomPaint widget
```

### Playback Button & Preview

```
[▶ Playback - 2:34] [🎧 Volume] [↻ Re-record]

Playback Button:
  Height:             44px
  Style:              Secondary button (outlined)
  Icon:               ▶ Play (or ⏸ Pause during playback)
  Text:               "Playback - 2:34"
  
Behavior:
  Initial:            "▶ Playback - [duration]"
  On Play:            Icon changes to ⏸, text shows "Paused - [current time]"
  On Complete:        Icon reverts to ▶
  
Waveform During Playback:
  Bars animate to waveform data
  Vertical progress line tracks position
  Tap to seek

Volume Control:
  Icon:               Speaker (right of playback button)
  Action:             Long press or tap to open slider
  Range:              0–100%
  Haptic:             Tick feedback every 10%

Re-record Option:
  Button:             "↻ Re-record"
  Action:             Clears current recording, resets step to beginning
  Confirmation:       Optional (discard current?)
  Haptic:             Light warning tap
```

---

## 4. STEP 2: EMOTION & ENRICHMENT

### Emotion Selection

```
┌──────────────────────────────────────────┐
│ كيف تشعر الآن؟                        │
│                                        │
│   😊     😌     💗     🌟     🌿    │
│ مسرور   هادئ   محبوب  آمل  متجذر   │
│                                        │
│ ┌ إختر مشاعر متعددة ┐                │
│ │ (يمكنك الاختيار أكثر من واحد)    │
│ └────────────────────────────────────┘
└──────────────────────────────────────────┘

Emotion Options:
  1. مسرور (Joy/Grateful)    - #FFD85C (Warm Yellow)
  2. هادئ (Peaceful)         - #5B9BD5 (Soft Blue)
  3. محبوب (Loved)           - #E85A8F (Rose Pink)
  4. آمل (Hopeful)          - #A78BFA (Lavender)
  5. متجذر (Grounded)       - #84A366 (Sage Green)

Multi-Select Option:
  Allow:              User can select 1–3 emotions
  Primary Emotion:    First selected (used for analytics)
  Secondary:          Additional emotions stored for nuance

Chip Specifications:
  Container:          60px (icon) + 12px label
  Spacing:            12px between chips
  
  Single Chip:
    Icon:             24px emoji
    Icon Container:   44px circle
    Label:            "مسرور" (Body Small, 12px)
    Gap:              8px vertical
    
  State (Unselected):
    Background:       Emotion color @ 10% opacity
    Icon:             Opacity 0.6
    Border:           None
    
  State (Selected):
    Background:       Emotion color @ 20% opacity
    Icon:             Opacity 1.0
    Border:           2px solid (emotion color)
    Scale:            1.1
    Ring:             Soft glow (emotion color at 30% opacity)
    Animation:        Spring curve (200ms, elasticOut)
    Haptic:           Light feedback

Interaction:
  Single Tap:         Toggle selection
  Multiple Select:    Tap multiple chips, indicator shows count
  Feedback:           Scale bounce + haptic light tap
```

### Text Enrichment (Optional)

```
┌──────────────────────────────────────────┐
│ 📝 أضف ملاحظات نصية (اختياري)        │
├──────────────────────────────────────────┤
│ إذا كنت تريد إضافة نص تفصيلي حول      │
│ تسجيلك الصوتي، يمكنك فعل ذلك هنا      │
│                                        │
│ ┌──────────────────────────────────┐  │
│ │ أضف نص إضافي...                 │  │
│ │                                  │  │
│ │                                  │  │
│ │ (سيتم الاحتفاظ بالنص مع التسجيل)│  │
│ │                            15/500 │  │
│ └──────────────────────────────────┘  │
└──────────────────────────────────────────┘

Textarea Specs:
  Min Height:         100px
  Max Height:         180px (scrollable)
  Character Limit:    500
  
Placeholder:
  "أضف ملاحظات نصية... (اختياري)"
  Style:              Body Medium (14px), #9CA3AF grey
  
Counter:
  Position:           Bottom-right
  Format:             "X / 500"
  Color:              Grey (#9CA3AF) until 80%, orange at 95%
  
Behavior:
  Auto-expand:        Smooth height animation (200ms) as user types
  Dismiss Keyboard:   Tap outside input
  
Accessibility:
  Label:              "Text input for additional notes"
  Hint:               "Optional enrichment, max 500 characters"
```

### Category Tags

```
┌──────────────────────────────────────────┐
│ 🏷️ تصنيفات (اختياري)                  │
│                                        │
│ [صحة] [أسرة] [علاقات] [عمل] [ذاتي] │
│ [أصدقاء] [روحانية] [تعليم] [هوايات]  │
│                                        │
│ ✓ تحديد متعدد                        │
└──────────────────────────────────────────┘

Available Categories:
  صحة (Health)
  أسرة (Family)
  علاقات (Relationships)
  عمل (Work)
  ذاتي (Personal)
  أصدقاء (Friendship)
  روحانية (Spirituality)
  تعليم (Education)
  هوايات (Hobbies)
  أخرى (Other)

Tag Chip Specs:
  Size:               Auto-fit
  Padding:            8px (horizontal), 4px (vertical)
  Border Radius:      4px
  Font:               Label Small (11px Semibold)
  
  State (Unselected):
    Background:       #252D37
    Text:             #9CA3AF
    Border:           1px #374151
    
  State (Selected):
    Background:       #0A7E6B @ 15% opacity
    Text:             #0A7E6B
    Border:           1px #0A7E6B
    Checkmark:        ✓ icon
    
  Interaction:
    On Tap:           Toggle select/deselect
    Haptic:           Light feedback
    Animation:        Fade in/out (150ms)

Multi-select:
  Allow:              User can select 1–5 tags
  Primary Tag:        First selected (used for sorting)
  Display:            All selected tags shown with count badge
```

### Photo Attachment (Optional)

```
[📸 Attach Photo] or [Image Preview]

Button (No Photo):
  Style:              Secondary outlined button
  Icon:               📸 Camera
  Text:               "Attach Photo"
  Height:             44px
  
On Tap:
  Open Camera Roll picker (native iOS)
  Crop & resize option
  Show preview after selection

Preview (Photo Selected):
  Aspect Ratio:       Square (1:1)
  Size:               60 × 60px thumbnail
  Border Radius:      8px
  Position:           Inline with text
  Remove Button:      Small ✕ overlay to delete
  
Metadata:
  Caption:            "1 photo attached"
  Color:              Green (#0A7E6B)

Storage:
  Store:              Referenced in recording metadata
  Max Size:           5MB
  Format:             JPEG or PNG
```

---

## 5. STEP 3: REVIEW & SAVE

### Review Summary

```
┌──────────────────────────────────────────┐
│ مراجعة شكرك                          │
├──────────────────────────────────────────┤
│                                        │
│ 🎤 الملخص الصوتي                     │
│ ▶ 2:34 min                            │
│ ▁▂▃▄▅▆▇█▇▆▅▄▃▂▁                     │
│                                        │
│ 📝 النص الإضافي (إن وجد)             │
│ "شكرت على دعم عائلتي الذين وقفوا   │
│  بجانبي في وقت الحاجة..."           │
│                                        │
│ 😊 المشاعر: مسرور                    │
│ 🏷️ التصنيفات: صحة، أسرة             │
│ 📸 الصور: 1 صورة                   │
│                                        │
│ ⏰ وقت التسجيل: 2:45 PM              │
│ 📅 التاريخ: 24 يونيو 2024           │
│                                        │
├──────────────────────────────────────────┤
│ [🖊 تعديل] [⏪ إعادة التسجيل]         │
│                                        │
│ ╔════════════════════════════════════╗  │
│ ║ ✓ احفظ الشكر                      ║  │
│ ╚════════════════════════════════════╝  │
└──────────────────────────────────────────┘

Summary Section:
  Title:              "مراجعة شكرك"
  Padding:            16px
  Background:         #252D37
  Border Radius:      12px
  
Display Elements:
  Audio:              Playback button + waveform
  Text:               Quoted preview (2–3 lines max)
  Metadata:           Mood, tags, time, date as labels
  Photo:              Thumbnail (60px)

Edit Actions:
  Edit Button:        Goes back to step 1
  Re-record Button:   Clears audio, stays on step 1
  Delete Button:      Red, dangerous, confirmation dialog

Save Button:
  Style:              Primary button (solid #0A7E6B)
  Text:               "✓ احفظ الشكر"
  Size:               Full-width, 52px height
  Haptic:             Heavy impact on success

Behavior on Save:
  Duration:           Instant save to local storage
  Feedback:           Success haptic (triple-tap pattern)
  Toast:              "تم حفظ شكرك بنجاح!" (2s, fade-out)
  Transition:         Modal dismisses, returns to home tab
  Sound:              Optional chime (if enabled in settings)
```

---

## 6. AUTO-SAVE & RECOVERY

### Background Save

```
Scenario: User records, then force-closes app

Behavior:
  1. Recording in progress
  2. User closes app or presses home
  3. Cubit triggers save to local storage
  4. Audio file saved with temp filename
  5. Metadata (emotion, text, tags) cached
  
Restoration:
  1. User reopens app
  2. System detects unsaved recording
  3. Show dialog: "Found unsaved recording (2:34)"
  4. Options: [Resume] [Discard]
  5. Resume opens recording modal with recovered data
  6. User can edit, re-record, or save

Implementation:
  - Use GetIt singleton to access SharedPreferences
  - Store draft in `recording_draft` key
  - Cache audio temp file in app documents folder
  - Cleanup after 7 days if not recovered
```

### Conflict Handling

```
Scenario: User saves same recording twice

Prevention:
  - Disable save button during first save (200ms)
  - Show spinner overlay during save
  - Play haptic feedback
  
Resolution:
  - If duplicate detected (same timestamp + audio hash)
  - Keep first save, ignore second
  - Show toast: "Already saved this recording"
```

---

## 7. HAPTIC & AUDIO FEEDBACK

### Haptic Patterns

```
Interaction             Haptic Pattern              Duration
─────────────────────────────────────────────────────────────
Record Button Tap       Heavy impact               50ms
Recording Started       Medium pulse               100ms
Emotion Chip Select     Light tap                  40ms
Text Input Focus        Light tap                  30ms
Save Button Press       Heavy impact               50ms
Save Success            Triple-tap (light)        150ms (3×50ms)
Error/Invalid           Double-tap (strong)       100ms (2×50ms)
Recording Warning       Single periodic pulse     Every 10s after 5min
```

### Audio Cues (Optional)

```
Event                       Sound               Duration
─────────────────────────────────────────────────────
Recording Start             Click (optional)     100ms
Recording Stop              Ping (optional)      200ms
Save Complete               Chime (optional)     300ms
Error/Permission Denied     Buzz (optional)      150ms
```

---

## 8. ERROR HANDLING

### Microphone Permission Denied

```
┌────────────────────────────────┐
│        ⚠️ Permission Needed    │
├────────────────────────────────┤
│                                │
│ تطبيق "امتنان يومي" يحتاج إلى │
│ إذن الوصول إلى الميكروفون     │
│                                │
│ اضغط "الإعدادات" لتفعيل       │
│ الإذن، ثم عد إلى التطبيق      │
│                                │
├────────────────────────────────┤
│ [الإعدادات] [الرجوع]          │
└────────────────────────────────┘

Button Actions:
  Settings:           Opens iOS Settings → Daily Gratitude → Microphone
  Back:               Dismisses modal, returns to home
  
Retry:
  After user grants permission, modal closes
  System prompts to try recording again
```

### Low Storage Warning

```
⚠️ Storage Low: Only 50MB remaining

Action:
  - Display warning in recording modal (if < 100MB)
  - Suggest saving current recording before continuing
  - Recommend deleting old recordings from settings
```

### Network Sync Error (Future)

```
If syncing to cloud:
  Error:              "Sync failed - will retry"
  Indicator:          ⚠️ badge on sync icon
  Auto-retry:         Every 5 minutes
  Manual Retry:       Button in settings
```

---

## 9. PERFORMANCE OPTIMIZATION

### Audio Processing

```
Waveform Generation:
  - Generate on background thread (isolate)
  - Cache normalized array for playback
  - Limit bars to 25–30 (not 1000+)
  - Update at 30fps (not 60fps)

Memory Management:
  - Dispose audio player on modal close
  - Clear waveform data on success
  - Use WeakReference for controllers

Storage:
  - Compress audio to AAC (128kbps)
  - Auto-trim silence at start/end
  - Cache only last 10 recordings
```

---

## 10. TESTING SCENARIOS

### User Journey Tests

1. **Happy Path:**
   - [ ] Tap record → audio plays → emotion selected → text added → save → toast
   - [ ] Verify haptic feedback at each step
   - [ ] Verify animation smoothness

2. **Audio Only:**
   - [ ] Record → no text, no emotion, no photo → save
   - [ ] Verify audio saved correctly

3. **Re-record:**
   - [ ] Record → re-record button → new audio replaces old
   - [ ] Verify old audio discarded

4. **Permission Denied:**
   - [ ] Deny microphone permission → error modal → grant permission → retry
   - [ ] Verify flow works end-to-end

5. **Background Save:**
   - [ ] Record → app backgrounded → app reopened
   - [ ] Verify recovery prompt appears
   - [ ] Resume editing → save successfully

6. **Long Recording:**
   - [ ] Record for 10+ minutes
   - [ ] Verify waveform doesn't lag
   - [ ] Verify timer display updates correctly
   - [ ] Verify warning appears at 5+ min

---

## Summary: Recording as a Differentiator

The **recording experience** is the core differentiator of Daily Gratitude:

1. **Voice-First:** Unlike text-only apps, voice captures emotion & nuance
2. **Visual Feedback:** Waveform visualizer makes audio tangible
3. **Frictionless:** One modal, progressive disclosure (no context switching)
4. **Enrichment:** Optional text, emotion, tags, photos (not forced)
5. **Auto-save:** Never lose a recording
6. **Haptic Polish:** Every interaction is tactile & responsive

**Target User Experience:**
- Open app → tap record → speak naturally → waveform animates → pick emotion → save → done (30–60 seconds)

---

**Recording Experience Design v1.0**  
**Premium Voice-First Journaling**
