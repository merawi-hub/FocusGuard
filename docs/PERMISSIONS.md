# FocusGuard — Permissions & Privacy Architecture

FocusGuard is designed as a privacy-preserving, offline digital wellbeing application. This document details why each platform permission is requested, how it is handled, and how user privacy is guarded.

---

## 1. Summary of Required Android Permissions

### `android.permission.PACKAGE_USAGE_STATS` (Usage Access)
- **Why it is needed**: To read the daily foreground duration for applications selected by the user.
- **How it is requested**: FocusGuard directs the user to Android Settings via `Settings.ACTION_USAGE_ACCESS_SETTINGS`.
- **Privacy Safeguards**: FocusGuard filters usage only for user-monitored applications. Usage statistics are stored exclusively in the local device SQLite database and are never uploaded.

### `android.permission.SYSTEM_ALERT_WINDOW` (Display Over Other Apps)
- **Why it is needed**: Enables FocusGuard to display the full-screen restriction shield when a user attempts to open an application whose daily limit has been exhausted.
- **How it is requested**: Directed to `Settings.ACTION_MANAGE_OVERLAY_PERMISSION` with `package:com.focusguard.app`.

### `android.permission.BIND_ACCESSIBILITY_SERVICE` (Foreground Detection)
- **Why it is needed**: Standard Android APIs do not notify third-party applications in real-time when another application is launched. `FocusAccessibilityService` receives `TYPE_WINDOW_STATE_CHANGED` events to immediately intercept restricted application launches without polling.
- **How it is requested**: The user is guided through Onboarding to enable `FocusGuard` in Android Accessibility Settings.
- **Privacy Safeguards & Google Play Compliance**:
  - `android:canRetrieveWindowContent="false"` is explicitly configured in `accessibility_service_config.xml`.
  - FocusGuard **cannot** read screen contents, messages, keystrokes, passwords, or personal data.
  - The service is strictly used for foreground package matching against the user's configured restriction list.

### `android.permission.POST_NOTIFICATIONS`
- **Why it is needed**: Android 13+ (API 33+) requires explicit notification permission to post threshold warnings (e.g. "TikTok: 80% daily limit reached (24 min used)") and restriction notices.

### `android.permission.QUERY_ALL_PACKAGES`
- **Why it is needed**: Allows the catalog screen to discover installed apps with launcher activities so users can select which apps to monitor.

---

## 2. Offline Privacy Policy Summary

- **Zero Cloud Storage**: No user accounts, cloud databases, or remote servers exist in this version.
- **No Third-Party Analytics**: No telemetry SDKs, crash trackers, or ad identifiers are bundled.
- **Sandboxed SQLite**: All historical usage sessions, restriction events, and emergency unlocks are stored in the app's sandboxed Drift database.

