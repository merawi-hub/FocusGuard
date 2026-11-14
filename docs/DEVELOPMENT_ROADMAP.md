# FocusGuard — Development Roadmap

FocusGuard is developed across structured phases to ensure stability, reliability, and clean separation of responsibilities.

---

## Phase Overview

### Phase 1: Project Foundation & UI Architecture (Current Task — COMPLETED)
- [x] Workspace inspection and tooling verification (Flutter 3.50, Dart 3.14, Java 17, Android SDK).
- [x] Clean Flutter project creation with Kotlin native Android backend (`com.focusguard.app`).
- [x] Material 3 Dark Navy theme, typography, and responsive component library (`AppCard`, `AppIconAvatar`, `StatusBadge`, `MetricTile`).
- [x] GoRouter configuration with persistent bottom navigation shell and typed routes.
- [x] Normalized local Drift SQLite database with 9 core tables:
  - `MonitoredApps`, `AppLimits`, `UsageSessions`, `DailyUsageSummaries`, `FocusSessions`, `DailyGoals`, `RestrictionEvents`, `EmergencyUnlocks`, `DailyRoutines`.
- [x] Native Android bridge (`RestrictionEngine`, MethodChannel `com.focusguard.app/restrictions`):
  - `UsageTracker`: Package enumeration, Base64 app icons, and `UsageStatsManager` aggregation.
  - `PermissionHelper`: Real-time checking and intent launchers for Usage, Overlay, Accessibility, and Notifications.
  - `FocusAccessibilityService`: Foreground app launch interception without polling.
  - `RestrictionBlockerActivity`: Native fullscreen blocker shield with home navigation & emergency unlock.
  - `NotificationHelper`: Multi-channel threshold notifications (50%, 80%, 100%).
- [x] Decoupled domain business logic:
  - Pure Dart `LimitEvaluator` with warning & restriction state evaluation.
  - `RestrictionCoordinator` managing enforcement and emergency unlock lifecycles.
- [x] Complete presentation screens:
  - Onboarding, Dashboard, App Catalog, App Limits & Config, Restrictions, Focus Mode, Daily Routines, Analytics, Settings.
- [x] Comprehensive unit and widget tests (14/14 tests passing).
- [x] Zero static analysis issues (`flutter analyze` clean).
- [x] Architecture and platform documentation (`ARCHITECTURE.md`, `ANDROID_SETUP.md`, `IOS_SETUP.md`, `PERMISSIONS.md`, `DEVELOPMENT_ROADMAP.md`).

---

### Phase 2: Live Background Tracking & Periodic Usage Sync (COMPLETED)
- [x] Integration of Android `WorkManager` (`UsageMonitorWorker`) for autonomous background usage aggregation every 15 minutes.
- [x] Session interval calculation using `UsageEvents.Event.MOVE_TO_FOREGROUND` and `MOVE_TO_BACKGROUND` in `UsageTracker.kt`.
- [x] Synchronization of granular session intervals into Drift `UsageSessions` table.
- [x] Native active foreground tracking in `FocusAccessibilityService` checking usage during active sessions every 15s.

---

### Phase 3: Android Warning Escalation & Strict Lockout (COMPLETED)
- [x] Multi-tier warning thresholds (50%, 80%, 100%) with duplicate prevention per daily cycle in `RestrictionManager`.
- [x] Native blocking screen (`RestrictionBlockerActivity`) launched immediately upon restricted launch or limit exhaustion.
- [x] Home navigation escape and deliberate emergency unlock dialog.

---

### Phase 4: Emergency Unlock & Scheduled Reset Engine (COMPLETED)
- [x] Native `AlarmManager` exact scheduling (`EmergencyUnlockReceiver`) for 10-minute temporary unlock expiration (re-locking automatically without requiring Flutter process to stay in memory).
- [x] Midnight (00:00) native broadcast receiver (`DailyResetReceiver`) to reset daily usage counters and unblock restricted apps for the new day.
- [x] Device reboot & timezone change receiver (`BootReceiver`) to re-sync restrictions, re-arm midnight alarms, and re-enqueue WorkManager tasks.

---

### Phase 5: Focus Mode & Daily Routines Automation
- [ ] Background routine service that automatically activates restrictions when routine time ranges begin (e.g. 09:00 - 12:00 Deep Work).
- [ ] Pomodoro session pause/resume support and audible completion chime.
- [ ] Whitelist/Blacklist app group presets.

---

### Phase 6: Long-Term Analytics & Data Export
- [ ] Multi-week trend aggregation in SQLite.
- [ ] Category grouping (Social Media, Entertainment, Productivity, Games).
- [ ] CSV/JSON export of local wellbeing history.

---

### Phase 7: Native iOS Screen Time Integration
- [ ] Apple Family Controls entitlement setup.
- [ ] `FamilyActivityPicker` Swift UI integration.
- [ ] `DeviceActivityMonitor` extension for background threshold callbacks.
- [ ] `ManagedSettings` Shield configuration and shield action extensions.
- [ ] App Group shared storage bridge.

---

### Phase 8: Hardening, Battery Optimization & Release
- [ ] Battery drain profiling on physical devices (measuring `AccessibilityService` overhead).
- [ ] OEM battery optimization documentation (MIUI, OneUI, ColorOS background killing).
- [ ] Release signing and Google Play Store metadata preparation.

