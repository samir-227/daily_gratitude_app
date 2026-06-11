# 🙏 Daily Gratitude App — Project Plan

> A Flutter app that helps Arabic/Egyptian users record their daily gratitude via voice or text, with automatic speech-to-text transcription, streaks, and mood analytics.

---

## 📋 Project Summary

| Field | Details |
|-------|---------|
| **Platform** | Flutter (iOS + Android) |
| **Target Users** | Arabic & Egyptian speakers |
| **Speech Recognition** | `speech_to_text` package (on-device, free) |
| **Local Database** | Hive |
| **State Management** | flutter_bloc |
| **MVP Timeline** | 5 weeks |

---

## 🎯 Core Features (MVP)

1. **Voice Recording + Transcription** — Record voice, save audio file, auto-transcribe to Arabic text on-device via `speech_to_text` package (100% free, no internet required)
2. **Daily Timeline** — Browse past entries by date, replay audio, read transcription
3. **Streak & Motivation** — Daily streak counter, reminder notifications, milestone celebrations
4. **Analytics** — Weekly activity chart, top topics, mood trends

---

## 🗂️ Screen Structure

```
App
├── Splash Screen
├── Onboarding (3 screens)
│   ├── Welcome
│   ├── How it works
│   └── Set daily reminder time
├── Home Screen
│   ├── Streak counter
│   ├── Main record button
│   └── Today's last entry preview
├── Record Screen
│   ├── Hold-to-record mic button
│   ├── Transcription display (live / post-processing)
│   ├── Mood tag selector (optional)
│   └── Save button
├── Timeline Screen
│   ├── Entries list (grouped by date)
│   ├── Entry card (text + audio player + time)
│   └── Date filter
├── Analytics Screen
│   ├── Streak stats
│   ├── Weekly activity chart
│   ├── Top topics
│   └── Mood trend chart
└── Settings Screen
    ├── Notification time
    ├── Language (Arabic / English UI)
    ├── Backup & Export
    └── About
```

---

## 🏗️ Architecture

**Pattern: Clean Architecture + BLoC**

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart
│   │   ├── app_strings.dart
│   │   └── app_theme.dart
│   ├── services/
│   │   ├── speech_service.dart        # speech_to_text integration
│   │   ├── audio_service.dart         # Record + Playback
│   │   └── notification_service.dart  # Local notifications
│   └── utils/
│       ├── arabic_text_utils.dart     # Arabic text helpers
│       └── date_utils.dart
├── data/
│   ├── models/
│   │   ├── gratitude_entry.dart       # Hive model
│   │   └── user_stats.dart            # Hive model
│   └── repositories/
│       ├── entry_repository.dart
│       └── stats_repository.dart
├── features/
│   ├── onboarding/
│   │   └── presentation/
│   │       ├── bloc/
│   │       └── screens/
│   ├── home/
│   │   └── presentation/
│   │       ├── bloc/
│   │       └── screens/
│   ├── recording/
│   │   └── presentation/
│   │       ├── bloc/
│   │       └── screens/
│   ├── timeline/
│   │   └── presentation/
│   │       ├── bloc/
│   │       └── screens/
│   ├── analytics/
│   │   └── presentation/
│   │       ├── bloc/
│   │       └── screens/
│   └── settings/
│       └── presentation/
│           ├── bloc/
│           └── screens/
└── main.dart
```

---

## 📦 Tech Stack

| Purpose | Package | Version |
|---------|---------|---------|
| State Management | `flutter_bloc` | ^8.1.3 |
| Local Database | `hive_flutter` | ^1.1.0 |
| Hive Code Gen | `hive_generator` + `build_runner` | latest |
| Audio Recording | `record` | ^5.0.4 |
| Audio Playback | `just_audio` | ^0.9.36 |
| Speech-to-Text | `speech_to_text` | ^6.6.2 |
| Notifications | `flutter_local_notifications` | ^16.3.2 |
| Charts | `fl_chart` | ^0.68.0 |
| Animations | `lottie` | ^3.1.0 |
| File Paths | `path_provider` | ^2.1.2 |
| Dependency Injection | `get_it` | ^7.6.7 |
| Navigation | `go_router` | ^13.2.0 |
| Permissions | `permission_handler` | ^11.3.0 |

---

## 🗄️ Hive Data Models

### `GratitudeEntry` (HiveObject)
```dart
@HiveType(typeId: 0)
class GratitudeEntry extends HiveObject {
  @HiveField(0) late String id;                  // UUID
  @HiveField(1) late DateTime createdAt;
  @HiveField(2) late String text;                // speech_to_text transcription or typed text
  @HiveField(3) String? audioPath;               // Local file path
  @HiveField(4) int? audioDurationMs;            // Audio duration in milliseconds
  @HiveField(5) String? moodTag;                 // 'grateful'|'happy'|'calm'|'reflective'
  @HiveField(6) late List<String> topics;        // Extracted keywords for analytics
  @HiveField(7) late bool isVoiceEntry;          // true = recorded, false = typed
}
```

### `UserStats` (HiveObject)
```dart
@HiveType(typeId: 1)
class UserStats extends HiveObject {
  @HiveField(0) late int currentStreak;
  @HiveField(1) late int longestStreak;
  @HiveField(2) late int totalEntries;
  @HiveField(3) DateTime? lastEntryDate;
  @HiveField(4) late Map<String, int> topTopics; // topic → count
}
```

### Hive Box Names
```dart
const String kEntriesBox = 'gratitude_entries';
const String kStatsBox   = 'user_stats';
const String kSettingsBox = 'app_settings';
```

---

## 🎙️ Speech-to-Text Integration (Arabic)

### Package: `speech_to_text`
On-device speech recognition — 100% free, no API key, works offline.

### How it works
The `speech_to_text` package uses the device's built-in speech engine:
- **Android:** Google Speech Recognition (supports Arabic `ar-EG` for Egyptian)
- **iOS:** Apple Speech Framework (supports Arabic `ar-SA` and regional variants)

### Important: Arabic on Android
On Android, the user **must have Arabic language pack installed** on their device. Most Egyptian Android users already have it. If not, the app will prompt them to download it.

### Implementation
```dart
// lib/core/services/speech_service.dart
class SpeechService {
  final SpeechToText _speech = SpeechToText();

  Future<bool> initialize() async {
    return await _speech.initialize(
      onError: (error) => debugPrint('STT Error: $error'),
    );
  }

  // Returns stream of partial results while user is speaking
  Future<void> startListening({
    required Function(String text) onResult,
    required Function(String error) onError,
  }) async {
    await _speech.listen(
      onResult: (result) => onResult(result.recognizedWords),
      localeId: 'ar-EG',           // Egyptian Arabic
      listenFor: const Duration(minutes: 3),
      pauseFor: const Duration(seconds: 3),  // Auto-stop after 3s silence
      partialResults: true,         // Show text live as user speaks
      cancelOnError: false,
    );
  }

  Future<void> stopListening() async {
    await _speech.stop();
  }

  bool get isListening => _speech.isListening;

  // Get all available Arabic locales on the device
  Future<List<LocaleName>> getArabicLocales() async {
    final locales = await _speech.locales();
    return locales.where((l) => l.localeId.startsWith('ar')).toList();
  }
}
```

### Locale Fallback Strategy
```dart
// In SpeechService.startListening():
// 1. Try 'ar-EG' first (Egyptian Arabic)
// 2. If not available, try 'ar-SA' (Modern Standard Arabic)
// 3. If neither, use first available 'ar-*' locale
// 4. If no Arabic at all, show dialog: "Please install Arabic language pack"
```

### Known Limitations
- Accuracy depends on the device's speech engine quality
- Egyptian dialect words may be transcribed in Modern Standard Arabic (e.g., "مش" → "ليس")
- User can always edit the transcription text before saving
- No internet required — fully offline

---

## 🔄 Recording Flow (Step by Step)

```
User taps Record button
        ↓
SpeechService.startListening() called (locale: ar-EG)
        ↓
Live transcription text appears on screen as user speaks
        ↓
User taps Stop (or 3s silence auto-stops)
        ↓
Final transcription text shown in editable TextField
AudioService also saves the .m4a file simultaneously
        ↓
User reviews + optionally edits text
        ↓
User optionally selects Mood Tag
        ↓
User taps Save
        ↓
Save GratitudeEntry to Hive (text + audioPath + duration + mood)
        ↓
Move audio file from temp → permanent app storage
        ↓
Update UserStats (streak + totalEntries + topics)
        ↓
Show success animation → return to Home
```

> **Note:** Recording audio (.m4a) and speech recognition run simultaneously.
> `record` package captures the audio file while `speech_to_text` handles live transcription.

---

## 📅 Detailed Task Plan

> Tasks are written to be self-contained and executable by any developer or LLM. Each task specifies exact files, inputs, outputs, and acceptance criteria.

---

### WEEK 1 — Project Setup & Foundation

---

#### TASK 1.1 — Initialize Flutter Project
**Description:** Create the Flutter project with the correct structure and install all dependencies.

**Steps:**
1. Run `flutter create --org com.yourname gratitude_app`
2. Replace `pubspec.yaml` dependencies section with the full package list from the Tech Stack table above
3. Run `flutter pub get`
4. Create the full folder structure under `lib/` as shown in Architecture section
5. Create empty `index.dart` barrel files in each folder

**Acceptance Criteria:**
- `flutter pub get` runs with no errors
- `flutter analyze` shows no errors
- All folders exist as defined in Architecture

---

#### TASK 1.2 — Configure Hive
**Description:** Set up Hive database with all models and adapters.

**Files to create:**
- `lib/data/models/gratitude_entry.dart`
- `lib/data/models/user_stats.dart`
- `lib/data/models/gratitude_entry.g.dart` (generated)
- `lib/data/models/user_stats.g.dart` (generated)

**Steps:**
1. Write `GratitudeEntry` HiveObject exactly as defined in Data Models section
2. Write `UserStats` HiveObject exactly as defined in Data Models section
3. Run `flutter pub run build_runner build --delete-conflicting-outputs` to generate `.g.dart` adapters
4. In `main.dart`, initialize Hive before `runApp`:
```dart
await Hive.initFlutter();
Hive.registerAdapter(GratitudeEntryAdapter());
Hive.registerAdapter(UserStatsAdapter());
await Hive.openBox<GratitudeEntry>(kEntriesBox);
await Hive.openBox<UserStats>(kStatsBox);
await Hive.openBox(kSettingsBox);
```

**Acceptance Criteria:**
- Hive initializes without errors on app start
- Can write and read a `GratitudeEntry` to/from the box in a unit test

---

#### TASK 1.3 — App Theme & Constants
**Description:** Define the app's visual identity used across all screens.

**File:** `lib/core/constants/app_theme.dart`

**Specs:**
- Primary color: `#4CAF82` (calm green)
- Background: `#FAF9F6` (warm white)
- Card color: `#FFFFFF`
- Text primary: `#1A1A2E`
- Text secondary: `#6B7280`
- Font family: `Cairo` (add to pubspec + assets from Google Fonts)
- Support both light and dark theme from the start
- Border radius standard: `16.0`
- Define `AppTextStyles` class with: `heading1`, `heading2`, `body`, `caption`, `button`

**Acceptance Criteria:**
- Theme applied in `MaterialApp`
- Dark mode works by toggling `ThemeMode`

---

#### TASK 1.4 — Permissions Setup
**Description:** Request microphone and notification permissions on both platforms.

**Files to edit:**
- `android/app/src/main/AndroidManifest.xml`
- `ios/Runner/Info.plist`
- Create `lib/core/services/permission_service.dart`

**Android permissions to add:**
```xml
<uses-permission android:name="android.permission.RECORD_AUDIO"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
```

**iOS Info.plist keys to add:**
```xml
<key>NSMicrophoneUsageDescription</key>
<string>We need microphone access to record your gratitude entries.</string>
```

**`PermissionService` methods:**
- `Future<bool> requestMicrophonePermission()`
- `Future<bool> requestNotificationPermission()`
- `Future<bool> hasMicrophonePermission()`

**Acceptance Criteria:**
- Permission dialogs appear correctly on both iOS and Android
- App does not crash if permission is denied; shows a friendly message instead

---

#### TASK 1.5 — Onboarding Screens
**Description:** 3-screen onboarding shown only on first app launch.

**Files:**
- `lib/features/onboarding/presentation/screens/onboarding_screen.dart`
- `lib/features/onboarding/presentation/screens/notification_time_picker_screen.dart`

**Screen 1 — Welcome:**
- Lottie animation (grateful hands or sparkle)
- Title: "Start Your Gratitude Journey"
- Subtitle: "One moment a day changes everything"
- Button: "Get Started"

**Screen 2 — How It Works:**
- 3 icon + text rows: Record → Reflect → Grow
- Button: "Sounds Good"

**Screen 3 — Set Your Reminder:**
- `TimePickerDialog` to select daily reminder time
- Default: 8:00 PM
- Button: "I'm Ready"
- Save selected time to `kSettingsBox` under key `'reminder_time'`
- Schedule notification (call `NotificationService.scheduleDaily(time)`)

**Logic:**
- Save `'onboarding_complete': true` to `kSettingsBox` after screen 3
- In `main.dart`: check this key; if true, skip onboarding and go to Home

**Acceptance Criteria:**
- Onboarding shows only on first launch
- Selected reminder time is saved and notification is scheduled
- On subsequent launches, app goes directly to Home

---

### WEEK 2 — Recording & Transcription

---

#### TASK 2.1 — Audio Service
**Description:** Wrapper around the `record` package for recording and `just_audio` for playback.

**File:** `lib/core/services/audio_service.dart`

**Methods to implement:**

```dart
// Recording
Future<void> startRecording()
// Saves to: (appDocDir)/recordings/temp_recording.m4a
// Config: AudioEncoder.aacLc, sampleRate: 16000, bitRate: 128000

Future<String> stopRecording()
// Returns: absolute path to the saved .m4a file
// Also returns duration via a separate getter

Future<void> cancelRecording()

// Playback
Future<void> playAudio(String filePath)
Future<void> pauseAudio()
Future<void> stopAudio()
Stream<Duration> get playbackPosition
Stream<Duration?> get totalDuration

// File management
Future<String> moveToPermStorage(String tempPath, String entryId)
// Moves file from temp → (appDocDir)/recordings/(entryId).m4a
// Returns new permanent path

Future<void> deleteRecording(String filePath)
```

**Acceptance Criteria:**
- Recording saves a valid .m4a file
- File size is reasonable (< 1MB per minute)
- Playback works for saved recordings

---

#### TASK 2.2 — Speech Service
**Description:** On-device Arabic speech recognition using the `speech_to_text` package.

**File:** `lib/core/services/speech_service.dart`

**Implementation:** Write the full `SpeechService` class exactly as defined in the Speech-to-Text Integration section above, including:
- `initialize()` method
- `startListening({onResult, onError})` with `ar-EG` locale and fallback strategy
- `stopListening()` method
- `isListening` getter
- `getArabicLocales()` helper

**Additional method:**
```dart
Future<String?> getBestArabicLocale() async {
  final locales = await getArabicLocales();
  if (locales.any((l) => l.localeId == 'ar-EG')) return 'ar-EG';
  if (locales.any((l) => l.localeId == 'ar-SA')) return 'ar-SA';
  if (locales.isNotEmpty) return locales.first.localeId;
  return null; // No Arabic available
}
```

**iOS Info.plist — add speech permission:**
```xml
<key>NSSpeechRecognitionUsageDescription</key>
<string>We need speech recognition to transcribe your gratitude entries.</string>
```

**Android — no extra config needed** (uses Google Speech which is pre-installed)

**Acceptance Criteria:**
- `initialize()` returns `true` on a real device with Arabic installed
- Live transcription text updates correctly as user speaks Arabic
- If no Arabic locale found, returns `null` from `getBestArabicLocale()` and calling code shows a dialog: "Please install Arabic language pack from your device settings"

---

#### TASK 2.3 — Record Screen UI
**Description:** The main recording screen with tap-to-record, live transcription display, mood selector, and save button.

**File:** `lib/features/recording/presentation/screens/record_screen.dart`

**UI Layout (top to bottom):**
1. App bar with back button and title "New Entry"
2. Date + time display (current)
3. **Live transcription area** — shows text updating in real-time as user speaks; idle state shows prompt text "Tap the button and speak your gratitude"
4. **Record button** (center, large circle, 80px radius):
   - Default state: green with mic icon
   - Recording state: red with pulsing animation + stop icon
   - `onTap` → if idle: `StartRecordingEvent`; if recording: `StopRecordingEvent`
5. **Transcription card** (visible throughout recording and after):
   - Editable `TextField` pre-filled with recognized text
   - User can correct any STT mistakes before saving
   - Audio duration label (from `record` package)
6. **Mood tag row** (appears once recording is stopped):
   - 4 chips: 😊 Grateful, 😄 Happy, 😌 Calm, 🤔 Reflective
   - Single-select; deselectable
7. **Save button** (bottom, full width):
   - Disabled until recording has stopped and text is non-empty
   - On tap: dispatch `SaveEntryEvent` to BLoC

**BLoC Events:**
- `StartRecordingEvent`
- `StopRecordingEvent`
- `LiveTranscriptionUpdatedEvent(String text)` — fired on each partial STT result
- `MoodSelectedEvent(String? mood)`
- `SaveEntryEvent`

**BLoC States:**
- `RecordingIdleState`
- `RecordingInProgressState(String liveText)` — updates as STT returns partial results
- `RecordingDoneState(String text, String audioPath, int durationMs)`
- `SavingEntryState`
- `EntrySavedState`
- `RecordingErrorState(String message)`

**Acceptance Criteria:**
- Tap-to-start and tap-to-stop works smoothly
- Transcription text updates live while user speaks
- User can edit transcription text before saving
- Entry is saved to Hive on tap Save

---

#### TASK 2.4 — Entry Repository
**Description:** All Hive CRUD operations for `GratitudeEntry`.

**File:** `lib/data/repositories/entry_repository.dart`

**Methods:**
```dart
Future<void> saveEntry(GratitudeEntry entry)

Future<List<GratitudeEntry>> getAllEntries()
// Returns: sorted by createdAt descending

Future<List<GratitudeEntry>> getEntriesByDate(DateTime date)
// Returns: all entries where createdAt.day == date.day

Future<GratitudeEntry?> getEntryById(String id)

Future<void> updateEntry(GratitudeEntry entry)

Future<void> deleteEntry(String id)
// Also deletes the associated audio file if audioPath is not null

Future<bool> hasEntryToday()
// Returns: true if any entry exists for today's date
```

**Acceptance Criteria:**
- All methods tested with in-memory Hive in unit tests
- `deleteEntry` also removes the audio file from disk

---

### WEEK 3 — Home Screen & Timeline

---

#### TASK 3.1 — Stats Repository
**Description:** Manage streak calculation and user statistics in Hive.

**File:** `lib/data/repositories/stats_repository.dart`

**Methods:**
```dart
Future<UserStats> getStats()

Future<void> updateStatsAfterEntry(DateTime entryDate)
// Logic:
// 1. Get current stats
// 2. If lastEntryDate is null OR was > 1 day ago → reset streak to 1
// 3. If lastEntryDate was yesterday → increment streak by 1
// 4. If lastEntryDate is today → do not change streak
// 5. Update longestStreak if currentStreak > longestStreak
// 6. Increment totalEntries
// 7. Save updated stats

Future<void> updateTopTopics(List<String> newTopics)
// Increment count for each topic in the map

Future<void> resetStats()
// Used in Settings for "Clear all data"
```

**Streak edge cases to handle:**
- First ever entry: streak = 1
- Entry on same day twice: streak stays the same
- Missed a day: streak resets to 1

**Acceptance Criteria:**
- Unit tests for all 4 streak scenarios listed above

---

#### TASK 3.2 — Home Screen
**Description:** Main landing screen with streak, today's status, and record button.

**File:** `lib/features/home/presentation/screens/home_screen.dart`

**UI Layout:**
1. Top bar: app name + settings icon
2. **Streak Card** (prominent):
   - Fire emoji + "X Day Streak"
   - Subtitle: "X total entries"
   - Animated number counter on update
3. **Today's status:**
   - If no entry today: "You haven't recorded today yet 🌱"
   - If entry exists today: preview card (first 60 chars of text + audio duration)
4. **Record button** (large, centered): navigates to Record Screen
5. **"View Timeline" button**: navigates to Timeline Screen

**BLoC Events:** `LoadHomeEvent`, `RefreshHomeEvent`

**BLoC States:**
- `HomeLoadingState`
- `HomeLoadedState(UserStats stats, GratitudeEntry? todayEntry)`
- `HomeErrorState(String message)`

**Acceptance Criteria:**
- Streak updates immediately after returning from Record Screen
- Today's entry preview shows correctly
- Pull-to-refresh works

---

#### TASK 3.3 — Timeline Screen
**Description:** Chronological list of all entries with audio playback.

**File:** `lib/features/timeline/presentation/screens/timeline_screen.dart`

**UI Layout:**
1. Search bar (filter by text)
2. Date filter chips: All / This Week / This Month
3. **Grouped list** — section headers by date ("Today", "Yesterday", "Monday June 2", etc.)
4. **Entry Card** (per entry):
   - Top row: timestamp (e.g., "9:41 PM") + mood tag chip (if any)
   - Text body (max 3 lines, expandable on tap)
   - If voice entry: audio player bar (play/pause + progress slider + duration)
   - Bottom row: edit icon + delete icon

**Audio Player behavior:**
- Only one entry plays at a time; tapping play on another pauses the current one
- Progress slider updates in real time

**Acceptance Criteria:**
- All entries load correctly grouped by date
- Audio plays and pauses correctly
- Delete shows a confirmation dialog before removing entry + audio file

---

#### TASK 3.4 — Notification Service
**Description:** Schedule and manage daily reminder notifications.

**File:** `lib/core/services/notification_service.dart`

**Methods:**
```dart
Future<void> initialize()
// Call in main.dart after Hive init

Future<void> scheduleDaily(TimeOfDay time)
// Schedules a repeating daily notification at the given time
// Notification title: "Time for your daily gratitude 🙏"
// Notification body: "Take 30 seconds to appreciate something today"
// Cancels any previously scheduled notification first

Future<void> cancelAll()

Future<void> showTestNotification()
// For debug/settings use
```

**Platform config:**
- Android: create notification channel `gratitude_daily` with importance HIGH
- iOS: request permission before scheduling

**Acceptance Criteria:**
- Notification fires at the correct time on both platforms
- Rescheduling with a new time cancels the old one

---

### WEEK 4 — Analytics & Polish

---

#### TASK 4.1 — Topic Extraction
**Description:** Extract keywords from Arabic entry text for analytics.

**File:** `lib/core/utils/arabic_text_utils.dart`

**Method:**
```dart
List<String> extractTopics(String arabicText)
```

**Logic:**
1. Lowercase + remove punctuation and diacritics (tashkeel)
2. Split into words
3. Remove Arabic stopwords (define a list of ~50 common Arabic stopwords: أنا، هو، في، من، على، أن، لا، ما، كان، etc.)
4. Remove words shorter than 3 characters
5. Return remaining unique words (max 10)

**Stopwords list to include at minimum:**
`أنا، أنت، هو، هي، نحن، في، من، على، إلى، عن، مع، أن، لا، ما، كان، كانت، يكون، هذا، هذه، ذلك، التي، الذي، وقد، قد، لقد، لكن، إذا، كل، بعد، قبل، عند، حتى، أو، إلا، غير`

**Acceptance Criteria:**
- "أنا ممتن لعيلتي وصحتي" → returns `["ممتن", "عيلتي", "صحتي"]`
- No stopwords in output
- No words shorter than 3 chars in output

---

#### TASK 4.2 — Analytics Screen
**Description:** Visual dashboard of the user's gratitude habits.

**File:** `lib/features/analytics/presentation/screens/analytics_screen.dart`

**Sections:**

**1. Stats Row (3 cards):**
- Current Streak / Longest Streak / Total Entries

**2. Weekly Activity Chart (BarChart via fl_chart):**
- X-axis: last 7 days (Mon–Sun)
- Y-axis: number of entries per day (0–3 max usually)
- Highlight today's bar in primary color

**3. Top 5 Topics:**
- Horizontal bar chart or list with progress bars
- Shows word → count (e.g., "عيلة → 12 times")

**4. Mood Distribution (PieChart or row of percentages):**
- Only show if user has used mood tags
- 4 moods with their colors

**BLoC:**
- `LoadAnalyticsEvent`
- `AnalyticsLoadedState(UserStats stats, Map<DateTime, int> weekActivity, Map<String, int> topTopics, Map<String, int> moodDistribution)`

**Acceptance Criteria:**
- All charts render correctly with real Hive data
- Empty state shown gracefully when no entries exist

---

#### TASK 4.3 — Streak Milestone Celebrations
**Description:** Show a celebration animation when user hits milestone streaks.

**File:** `lib/features/home/presentation/widgets/milestone_dialog.dart`

**Milestones:** 3, 7, 14, 30, 60, 100 days

**Implementation:**
1. After `updateStatsAfterEntry`, check if new streak value is in the milestones list
2. If yes, show a full-screen dialog with:
   - Lottie confetti animation
   - Title: "🎉 X Day Streak!"
   - Subtitle: contextual message per milestone (e.g., for 7: "One full week of gratitude!")
   - Button: "Keep Going"
3. Save `'last_milestone_shown': X` to `kSettingsBox` so it only shows once per milestone

**Acceptance Criteria:**
- Dialog appears exactly once per milestone
- Does not re-appear if user closes and reopens app

---

#### TASK 4.4 — Settings Screen
**Description:** User preferences and data management.

**File:** `lib/features/settings/presentation/screens/settings_screen.dart`

**Sections:**

**Notifications:**
- Toggle: Enable/disable daily reminder
- Tappable row: "Reminder Time" → opens `TimePickerDialog` → reschedules notification

**Speech Recognition:**
- Read-only row showing detected Arabic locale (e.g., "ar-EG — Egyptian Arabic ✓")
- If no Arabic locale found: show warning chip "Arabic not installed" + button "How to fix"
- "How to fix" opens a bottom sheet with step-by-step instructions to install Arabic on Android/iOS

**Data:**
- "Export entries as text" → generates a `.txt` file with all entries and prompts share sheet
- "Clear all data" → confirmation dialog → deletes all Hive boxes + all audio files in `/recordings/`

**About:**
- App version (from `package_info_plus`)
- Privacy policy link

**Acceptance Criteria:**
- Arabic locale detection shows correct info
- "Clear all data" removes ALL files and resets stats to zero
- Export creates a readable text file with all entries

---

### WEEK 5 — Testing, Fixes & Release Prep

---

#### TASK 5.1 — Unit Tests
**Description:** Write unit tests for all business logic.

**Files:**
- `test/repositories/entry_repository_test.dart`
- `test/repositories/stats_repository_test.dart`
- `test/utils/arabic_text_utils_test.dart`
- `test/services/speech_service_test.dart` (with mocked SpeechToText)

**Required test cases:**

`stats_repository_test.dart`:
- First entry → streak = 1
- Entry on same day → streak unchanged
- Entry next day → streak incremented
- Entry after 2+ days → streak reset to 1
- Streak exceeds previous longest → longestStreak updated

`arabic_text_utils_test.dart`:
- Stopwords are removed
- Short words (< 3 chars) are removed
- Diacritics (tashkeel) are stripped before processing
- Max 10 topics returned

**Acceptance Criteria:**
- `flutter test` passes with 0 failures

---

#### TASK 5.2 — Error Handling & Edge Cases
**Description:** Ensure the app handles all failure scenarios gracefully.

**Scenarios to handle:**

| Scenario | Expected behavior |
|----------|-------------------|
| No Arabic language pack on device | Show dialog: "Please install Arabic language pack from device settings" + "Open Settings" button |
| STT engine error mid-recording | Show error snackbar; keep audio file; let user type manually instead |
| Microphone permission denied | Show dialog explaining why it's needed + "Open Settings" button |
| Audio file deleted externally | Gracefully skip playback, show "Audio unavailable" |
| Hive box corrupted | Catch error, show "Data error" screen with option to reset |

**Acceptance Criteria:**
- No unhandled exceptions in any of the above scenarios
- User always sees a human-readable message, never a Flutter error screen

---

#### TASK 5.3 — App Icon & Splash Screen
**Description:** Set final app icon and splash screen.

**Files to edit:**
- Replace `assets/icon/app_icon.png` with final 1024x1024 icon
- `flutter_launcher_icons` config in `pubspec.yaml`
- `flutter_native_splash` config in `pubspec.yaml`

**Specs:**
- Icon: green gradient background + white praying hands emoji style
- Splash: white background + centered icon + app name in Cairo font

**Steps:**
1. Add `flutter_launcher_icons` and `flutter_native_splash` to dev dependencies
2. Run `flutter pub run flutter_launcher_icons`
3. Run `flutter pub run flutter_native_splash:create`

**Acceptance Criteria:**
- Correct icon appears on both iOS and Android home screen
- Splash screen shows on cold start with no white flash

---

#### TASK 5.4 — Release Build Preparation
**Description:** Prepare signed release builds for both platforms.

**Android:**
1. Generate keystore: `keytool -genkey -v -keystore gratitude.jks -keyAlias gratitude -keyalg RSA -keysize 2048 -validity 10000`
2. Create `android/key.properties` (do NOT commit this file)
3. Update `android/app/build.gradle` to use signing config
4. Run `flutter build apk --release` and `flutter build appbundle --release`

**iOS:**
1. Set Bundle ID in Xcode to `com.yourname.gratitudeapp`
2. Set minimum iOS version to 14.0
3. Archive via `flutter build ipa`

**Acceptance Criteria:**
- Release APK installs and runs correctly on a physical Android device
- No debug banner visible in release build

---

## 🚀 Future Features (Post-MVP)

| Feature | Priority |
|---------|----------|
| Social feed (share anonymously) | Medium |
| AI weekly summary (GPT-4o) | High |
| Home screen widget (iOS/Android) | Medium |
| Export to PDF journal | Low |
| 30-day gratitude challenge | Medium |
| iCloud / Google Drive backup | High |

---

## ⚠️ Key Constraints & Decisions

1. **Fully free & offline:** `speech_to_text` uses the device's built-in engine — no API key, no internet, no cost.
2. **Egyptian Arabic accuracy:** The `ar-EG` locale gives the best results for Egyptian dialect. Words may occasionally transcribe in Modern Standard Arabic (e.g., "مش" → "ليس"). The editable text field is the safety net for corrections.
3. **Audio storage:** Recordings are stored locally only. No cloud upload in MVP. Avg size ~240KB/minute at 128kbps AAC.
4. **Arabic support:** All UI strings support Arabic RTL. Use `Directionality` widget where needed. Font `Cairo` covers all Arabic Unicode ranges.
5. **Dual recording:** `record` package and `speech_to_text` run simultaneously — one saves the audio file, the other does live transcription. Both must be started together in `StartRecordingEvent` and stopped together in `StopRecordingEvent`.
