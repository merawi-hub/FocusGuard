# FocusGuard — Android Platform Setup Guide

This guide details the native Android architecture, required permissions, accessibility configuration, and testing procedures for FocusGuard.

---

## 1. Prerequisites
- **Android SDK**: Min SDK 26 (Android 8.0 Oreo), Target SDK 34 / 35.
- **JDK**: Java 17 LTS.
- **Kotlin**: 1.9+.
- **Build Tools**: Gradle 8.x with Android Gradle Plugin 8.x.

---

## 2. Declared Permissions & Capabilities

| Permission | Purpose | Type |
|---|---|---|
| `android.permission.PACKAGE_USAGE_STATS` | Queries foreground durations using `UsageStatsManager` | System Settings (`Settings.ACTION_USAGE_ACCESS_SETTINGS`) |
| `android.permission.SYSTEM_ALERT_WINDOW` | Enables drawing the full-screen restriction shield over apps | System Settings (`Settings.ACTION_MANAGE_OVERLAY_PERMISSION`) |
| `android.permission.BIND_ACCESSIBILITY_SERVICE` | Enables `FocusAccessibilityService` to detect foreground window transitions | Accessibility Settings (`Settings.ACTION_ACCESSIBILITY_SETTINGS`) |
| `android.permission.POST_NOTIFICATIONS` | Delivers 50%, 80%, and 100% threshold alerts on Android 13+ | Runtime permission |
| `android.permission.QUERY_ALL_PACKAGES` | Enumerates installed launcher activities for catalog selection | Manifest declaration |

---

## 3. Native Component Breakdown

### A. `FocusAccessibilityService` (`com.focusguard.app.native.restrictions`)
- **Event Filter**: `AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED`.
- **Configuration** (`res/xml/accessibility_service_config.xml`):
  ```xml
  <accessibility-service xmlns:android="http://schemas.android.com/apk/res/android"
      android:description="@string/accessibility_service_description"
      android:accessibilityEventTypes="typeWindowStateChanged"
      android:accessibilityFeedbackType="feedbackGeneric"
      android:notificationTimeout="100"
      android:canRetrieveWindowContent="false"
      android:accessibilityFlags="flagDefault" />
  ```
- **Privacy Notice**: Notice `android:canRetrieveWindowContent="false"`. FocusGuard only receives the top package name; it cannot read texts, inputs, or personal communications.

### B. `RestrictionBlockerActivity`
- Configured with `launchMode="singleInstance"`, `excludeFromRecents="true"`, and `noHistory="true"`.
- Uses programmatic views to render a sleek dark navy shield screen without layout XML dependencies.
- Offers direct return to launcher home or 10-minute temporary emergency unlock with confirmation.

### C. `RestrictionManager`
- Backed by persistent `SharedPreferences`.
- Restrictions and emergency unlock expiry timestamps remain intact even if the Flutter engine process terminates or restarts.

---

## 4. Testing Restrictions on Android Emulator / Device

1. Launch FocusGuard on your device or emulator:
   ```bash
   flutter run -d android
   ```
2. In the Onboarding screen, grant **Usage Access**, **Display Over Other Apps**, and enable **FocusGuard** in Accessibility Services.
3. Open the **App Catalog** tab and toggle monitoring on a target app (e.g. Chrome or Calculator).
4. Tap the app to configure a strict 1-minute limit.
5. Launch the target app and use it for 1 minute.
6. Observe the warning notification at 50% and 80%, followed by the native `RestrictionBlockerActivity` shield locking the screen at 100%.

