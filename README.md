# Daily Gratitude

A gratitude journal app for Arabic speakers with voice recording, speech-to-text, and analytics. Built with Flutter using Clean Architecture and Cubit state management.

## Features

### 📝 Recording
- **Voice recording** — record your gratitude entries with a single tap. WAV audio saved locally, no cloud storage.
- **Arabic speech-to-text** — on-device STT (no API key needed) auto-detects Arabic locales (ar-EG → ar-SA → fallback). Partial live transcription updates in real time.
- **Editable transcription** — correct STT mistakes with the editable text field before saving.
- **Mood tagging** — select a mood (grateful, happy, calm, reflective) to accompany each entry.
- **Auto-topic extraction** — Arabic keywords are automatically extracted from your text (stopwords, diacritics, punctuation removed).

### 🏠 Home Dashboard
- **Streak tracking** — current streak with flame icon and total entry count.
- **Today's entry card** — shows first 60 characters of today's entry, tappable to open full detail with audio playback.
- **Quick actions** — record button and timeline shortcut.

### 📖 Entry Detail
- **Full text view** — read the complete entry in a clean card layout.
- **Audio playback** — play/pause and seek through the recorded audio.
- **Mood badge** — mood emoji and name shown when present.

### 📅 Timeline
- **Entry history** — browse all past entries in reverse chronological order.
- **Filtering** — view All, This Week, or This Month.
- **Inline audio playback** — play/pause audio directly from the timeline. Only one entry plays at a time.
- **Delete entries** — with confirmation dialog.

### 📊 Analytics
- **Weekly activity chart** — bar chart showing entries per day for the last 7 days.
- **Streak stats** — current streak, longest streak, total entries.
- **Top topics** — most frequent keywords with proportional bars (max 5).
- **Mood distribution** — percentage breakdown of mood tags.

### ⚙️ Settings
- **Daily reminder** — toggle and set notification time for daily gratitude prompts.
- **Arabic locale status** — shows detected Arabic speech locale.
- **Export data** — export all entries as a .txt file and share via system share sheet.
- **Clear all data** — delete all entries, audio files, and stats with confirmation.

### 🏆 Streak Milestones
- Celebrate reaching 3, 7, 14, 30, 60, and 100 consecutive days with congratulatory dialogs. Each milestone shown only once.

## Tech Stack

| Category | Choice |
|----------|--------|
| State Management | flutter_bloc (Cubit only) |
| Architecture | Clean Architecture: `presentation → domain → data` |
| Local Database | Hive with custom TypeAdapters |
| Navigation | go_router |
| DI | get_it |
| Audio Recording | `record` package (WAV, 16kHz) |
| Audio Playback | `just_audio` (AVAudioPlayer) |
| Speech-to-Text | `speech_to_text` (on-device, offline) |
| Charts | fl_chart |
| Notifications | flutter_local_notifications |
| UI | Cupertino only (zero Material widgets) |
| Text Direction | RTL (Arabic-first) |
| Font | Cairo |

## Project Structure

```
lib/
├── main.dart                          # Entry point, Hive init, DI setup
├── core/
│   ├── constants/                     # Colors, strings, theme, app constants
│   ├── di/injection.dart              # get_it service locator
│   ├── errors/failures.dart           # Failure types
│   ├── router/app_router.dart         # GoRouter configuration
│   ├── services/                      # Audio, Speech, Notification, Permission
│   └── utils/                         # Arabic text extraction, date formatting
├── data/
│   ├── models/                        # GratitudeEntry, UserStats (Hive)
│   └── repositories/                  # EntryRepository, StatsRepository
└── features/
    ├── onboarding/                    # 3-page onboarding flow
    ├── home/                          # Dashboard, entry detail, milestone dialog
    ├── recording/                     # Voice recording + STT screen
    ├── timeline/                      # Entry history with filters
    ├── analytics/                     # Charts and statistics
    └── settings/                      # Notifications, export, clear data
```

## Getting Started

### Prerequisites
- Flutter SDK 3.11+
- iOS 13+ or Android 5.0+

### Run

```bash
flutter pub get
flutter run
```

### Commands

```bash
flutter analyze        # Lint + static analysis
flutter test           # Run tests
flutter run -d "iPhone 15"  # Run on iOS simulator
```

## Architecture Rules

- **Cubit only** — no Riverpod, Provider, or GetX for state management.
- **Domain layer purity** — no `package:flutter/` imports in `domain/` files.
- **No code generation** — Dart 3 sealed classes, records, switch expressions instead of Freezed/build_runner.
- **Error handling** — cubits use try/catch and emit typed error states. No raw exceptions escape.

## Data Flow

1. **Record** → AudioService records WAV + SpeechService transcribes Arabic → Cubit holds text + path
2. **Save** → UUID generated → Audio file moved to permanent storage → Entry saved to Hive → Stats updated (streak, topics)
3. **View** → Entry loaded from Hive → Full text shown → Audio playback via just_audio
4. **Analyze** → All entries fetched from Hive → Week activity, topics, mood distribution calculated
