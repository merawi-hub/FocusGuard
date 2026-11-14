# FocusGuard — Architecture Documentation

FocusGuard is built using a clean, layered, feature-first architecture that strictly separates user interface, business logic, persistence, and native operating-system integration.

```
┌────────────────────────────────────────────────────────────────────────┐
│                        Flutter UI Presentation                         │
│   Material 3 • Riverpod 2.6 • GoRouter 14 • fl_chart • Dark Navy Theme  │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │
┌───────────────────────────────────▼────────────────────────────────────┐
│                    Domain & Business Logic Layer                       │
│    LimitEvaluator (Pure Dart) • RestrictionCoordinator • Timers        │
└──────────────────┬─────────────────────────────────┬───────────────────┘
                   │                                 │
┌──────────────────▼─────────────┐ ┌─────────────────▼──────────────────┐
│      Data & Persistence        │ │         Platform Abstraction       │
│  Drift 2.35 • SQLite3 Local DB │ │          RestrictionEngine         │
│     9 Normalized Tables        │ │     (MethodChannel / IPC Bridge)   │
└────────────────────────────────┘ └─────────────────┬──────────────────┘
                                                     │
                                   ┌─────────────────▼──────────────────┐
                                   │       Native Android Platform      │
                                   │  • UsageStatsManager               │
                                   │  • FocusAccessibilityService       │
                                   │  • RestrictionBlockerActivity      │
                                   │  • NotificationHelper              │
                                   │  • RestrictionManager (Prefs)      │
                                   └────────────────────────────────────┘
```

---

## 1. Core Architectural Layers

### A. Presentation Layer (`lib/features/`, `lib/shared/widgets/`)
- **UI Toolkit**: Flutter Material 3 with signature Dark Navy aesthetic (`#0B132B`, `#1C2541`, `#48CAE4`).
- **State Management**: `flutter_riverpod` providers for declarative, reactive data binding.
- **Routing**: `go_router` with shell navigation for the 4 core bottom navigation tabs and typed routes for modals and config flows.

### B. Business Logic & Domain (`lib/features/restrictions/domain/`)
- **`LimitEvaluator`**: A pure Dart evaluator that takes current usage seconds, configured daily limits, and threshold milestones (50%, 80%, 100%) to calculate warnings or restrictions. Fully decoupled from platform APIs and easily testable.
- **`RestrictionCoordinator`**: Coordinates database queries, calls `LimitEvaluator`, triggers native alerts, and logs events into Drift.

### C. Data & Local Persistence Layer (`lib/core/database/`)
- Built using **Drift** and **SQLite**.
- **100% Offline**: No network requests or remote analytics.
- **Entities**:
  1. `MonitoredApps`: Registered apps on the device with platform IDs.
  2. `AppLimits`: Daily allowance, warning thresholds, and strict vs. soft modes.
  3. `UsageSessions`: Individual usage sessions with start, end, and duration.
  4. `DailyUsageSummaries`: Aggregated daily usage time per app.
  5. `FocusSessions`: Focus mode sessions with goals and timers.
  6. `DailyGoals`: Screen time and digital wellbeing targets.
  7. `RestrictionEvents`: Audit log of warnings, restrictions, and unlock events.
  8. `EmergencyUnlocks`: Verified emergency override records with expirations.
  9. `DailyRoutines`: Scheduled focus timeframes (Study, Exercise, Sleep).

### D. Native Platform Integration (`lib/core/platform/` & `android/`)
- **`RestrictionEngine`**: Abstract Dart contract defining authorization checks, application querying, usage retrieval, and restriction enforcement.
- **`AndroidRestrictionEngine`**: Concrete implementation utilizing a Flutter `MethodChannel` (`com.focusguard.app/restrictions`).
- **Android Native Layer**:
  - `UsageTracker`: Employs Android `UsageStatsManager` to aggregate daily foreground durations.
  - `FocusAccessibilityService`: Intercepts `TYPE_WINDOW_STATE_CHANGED` accessibility events. When a restricted package appears in the foreground, it immediately presents `RestrictionBlockerActivity`.
  - `RestrictionBlockerActivity`: A native full-screen lock screen displayed over restricted apps. Provides exit to launcher or emergency unlock with intentional confirmation.
  - `RestrictionManager`: Native SharedPreferences storage ensuring restrictions stay active even if the Flutter app is closed or killed.
  - `NotificationHelper`: Sets up Android NotificationChannels (`focusguard_warnings`, `focusguard_restrictions`) and issues alerts at 50%, 80%, and 100% thresholds.

---

## 2. Privacy Guarantees
1. FocusGuard does **not** collect, store, or transmit personal data, keystrokes, messages, or screen contents.
2. The `AccessibilityService` configuration explicitly sets `canRetrieveWindowContent="false"`, ensuring that window text and user input are completely inaccessible to the service.
3. All database tables and logs reside locally on the device in an encrypted/sandboxed SQLite database file.

