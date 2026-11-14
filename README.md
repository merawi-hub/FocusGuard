# FocusGuard — Cross-Platform Digital Wellbeing & App Restriction System

FocusGuard is a digital wellbeing and productivity mobile application engineered to help users regain control of their attention. It combines a Flutter interface with native Android system integration to monitor application usage, set daily limits, deliver graduated warnings, and automatically restrict distracting apps when limits are exceeded.

---

## Key Highlights

- **Native Android Interception**: Leverages Android's `UsageStatsManager` for precise time accounting and an authorized `AccessibilityService` for instantaneous foreground app detection without continuous polling.
- **Native Lock Screen**: Presents an unbypassable native `RestrictionBlockerActivity` shield over restricted apps with a built-in deliberate Emergency Unlock workflow.
- **100% Offline & Private**: All data is stored locally in an embedded SQLite database using Drift. Zero telemetry, tracking, or network calls.
- **Material Design 3**: Dark Navy aesthetic (`#0B132B`, `#1C2541`, `#48CAE4`) with fluid typography, cards, and animations.
- **Extensible Architecture**: Shared Flutter interface abstracted through a common `RestrictionEngine` contract, ready for future iOS Screen Time framework integration.

---

## Tech Stack

- **Framework**: Flutter 3.50+ / Dart 3.14+
- **State Management**: Riverpod (`flutter_riverpod: ^3.5.0`)
- **Navigation**: GoRouter (`go_router: ^18.1.4`)
- **Persistence**: Drift (`drift: ^2.35.4`) with SQLite
- **Visuals & Charts**: `fl_chart: ^1.3.1`
- **Native Android**: Kotlin 1.9+, `UsageStatsManager`, `AccessibilityService`, `NotificationManager`

---

## Project Structure

```
FocusGuard/
├── android/
│   └── app/
│       └── src/main/kotlin/
│           └── com/focusguard/app/
│               ├── MainActivity.kt
│               └── native/
│                   ├── usage/             # UsageTracker & app enumeration
│                   ├── restrictions/      # FocusAccessibilityService & RestrictionBlockerActivity
│                   ├── permissions/       # PermissionHelper & Settings intents
│                   └── notifications/     # NotificationHelper & threshold alerts
│
├── ios/
│   ├── Runner/
│   │   └── Native/
│   └── ScreenTimeExtensions/              # Placeholders for Phase 7 Screen Time extensions
│       ├── ActivityMonitor/
│       ├── ShieldConfiguration/
│       └── ShieldAction/
│
├── lib/
│   ├── main.dart                          # Application entry point
│   ├── app/                               # Theme, Router, Root widget
│   ├── core/
│   │   ├── constants/                     # App and Route constants
│   │   ├── database/                      # Drift database & 9 SQLite tables
│   │   ├── errors/                        # Custom exceptions
│   │   ├── platform/                      # RestrictionEngine abstraction & Android implementation
│   │   └── utilities/                     # Duration & DateTime formatters
│   ├── features/
│   │   ├── onboarding/                    # Welcome & 4-step permission grant flow
│   │   ├── dashboard/                     # Screen time, daily goal, most-used apps
│   │   ├── app_monitoring/                # Real device app catalog & search
│   │   ├── app_limits/                    # Limit configuration & strict/soft modes
│   │   ├── restrictions/                  # Active locks, emergency unlock & audit log
│   │   ├── focus_mode/                    # Pomodoro & custom deep work sessions
│   │   ├── daily_routines/                # Study, workout, and sleep schedules
│   │   ├── analytics/                     # 7-day trend charts & distribution
│   │   └── settings/                      # Permission center, reset times, data control
│   └── shared/                            # Reusable widgets (AppCard, StatusBadge, AppIconAvatar)
│
├── docs/                                  # Complete architecture & platform setup guides
│   ├── ARCHITECTURE.md
│   ├── ANDROID_SETUP.md
│   ├── IOS_SETUP.md
│   ├── PERMISSIONS.md
│   └── DEVELOPMENT_ROADMAP.md
│
├── test/                                  # Unit & widget tests (14 passing tests)
├── pubspec.yaml
└── README.md
```

---

## Getting Started

### 1. Prerequisites
- Flutter SDK (v3.50.0 or later)
- Android SDK (API 26+)
- Java 17 LTS

### 2. Run Tests
```bash
flutter test
```

### 3. Run Static Analysis
```bash
flutter analyze
```

### 4. Build or Run on Android Device / Emulator
```bash
flutter run
```
Or build a debug APK:
```bash
flutter build apk --debug
```

---

## Documentation
- [Architecture Details](docs/ARCHITECTURE.md)
- [Android Setup & Permissions](docs/ANDROID_SETUP.md)
- [iOS Setup & Screen Time Architecture](docs/IOS_SETUP.md)
- [Permissions & Privacy Policy](docs/PERMISSIONS.md)
- [Development Roadmap](docs/DEVELOPMENT_ROADMAP.md)
