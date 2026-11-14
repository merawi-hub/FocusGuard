# FocusGuard — iOS Platform Setup & Architecture Guide

> **Note**: As requested for the initial foundation phase, Android is the active target. This document outlines the planned iOS implementation architecture using Apple's official Screen Time frameworks for Phase 7.

---

## 1. Apple Screen Time Architecture

Unlike Android's `UsageStatsManager` and `AccessibilityService`, iOS prohibits package enumeration and direct foreground window interception for third-party apps. Instead, iOS 15+ provides Apple's official Screen Time APIs:

```
┌────────────────────────────────────────────────────────┐
│                   Flutter iOS Runner                   │
│          MethodChannel / EventChannel Bridge           │
└───────────────────────────┬────────────────────────────┘
                            │
┌───────────────────────────▼────────────────────────────┐
│                FamilyControls Framework                │
│       AuthorizationCenter.shared.requestAuthorization   │
│                 FamilyActivityPicker                   │
└───────────────────────────┬────────────────────────────┘
                            │
┌───────────────────────────▼────────────────────────────┐
│               DeviceActivity Framework                 │
│         DeviceActivityCenter / Schedule / Event        │
│       DeviceActivityMonitor Extension (Background)     │
└───────────────────────────┬────────────────────────────┘
                            │
┌───────────────────────────▼────────────────────────────┐
│               ManagedSettings Framework                │
│       ManagedSettingsStore().shield.applications       │
│       ShieldConfiguration & ShieldAction Extensions    │
└────────────────────────────────────────────────────────┘
```

---

## 2. Frameworks & Extensions Breakdown

### A. `FamilyControls`
- **Purpose**: Authorizes access to Screen Time controls on the device.
- **Privacy Model**: Uses opaque tokens (`ApplicationToken`, `ActivityCategoryToken`). The app cannot inspect the bundle identifiers or names of other apps directly; the user selects them via Apple's native `FamilyActivityPicker`.
- **Required Entitlement**: `com.apple.developer.family-controls` (Requires Apple Developer account distribution request approved by Apple).

### B. `DeviceActivity` & `DeviceActivityMonitor`
- **Target**: An iOS App Extension running in the background.
- **Methods**:
  - `intervalDidStart`: Triggers scheduled monitoring routines.
  - `intervalDidEnd`: Performs daily usage reset.
  - `eventDidReachThreshold`: Triggered by iOS when the user reaches the configured usage limit (e.g. 30 minutes).

### C. `ManagedSettings` & `ShieldConfiguration`
- **Target**: Shield Extension.
- **Functionality**:
  - Sets `ManagedSettingsStore().shield.applications = selectedAppTokens`.
  - iOS automatically blocks the application at the system level and displays the custom `ShieldConfigurationExtension` view.
  - The `ShieldActionExtension` handles user interactions (e.g., requesting Emergency Unlock).

---

## 3. Required App Group & Communication
- Shared App Group container (e.g. `group.com.focusguard.app`) allows the main Flutter Runner app and the extensions (`ActivityMonitor`, `ShieldAction`) to share unlock timestamps, limits, and routine definitions via `UserDefaults(suiteName:)`.

---

## 4. Phase 7 Implementation Steps
1. Apply for the `FamilyControls` entitlement in the Apple Developer Portal.
2. Add App Extensions:
   - `FocusActivityMonitor` (DeviceActivityMonitor extension)
   - `FocusShieldConfiguration` (ShieldConfiguration extension)
   - `FocusShieldAction` (ShieldAction extension)
3. Implement `FamilyActivityPicker` Swift bridge to pass selected tokens to `ManagedSettingsStore`.
4. Implement emergency unlock by removing shields temporarily for 10 minutes and scheduling a `DeviceActivityCenter` warning.

